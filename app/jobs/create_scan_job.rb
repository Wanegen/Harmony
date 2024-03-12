class CreateScanJob < ApplicationJob
  queue_as :default
  # include ActionView::Rendering
  # include Rails.application.routes.url_helpers

  def perform(scan_id)
    scan = Scan.find(scan_id)

    chaptgpt_response = GptApiImageCallService.call(scan)
    infos = chaptgpt_response["choices"][0]["message"]["content"].split(",").map(&:strip)
    scan.ai_response = {
      title: infos[0],
      year: infos[1],
      artist_name: infos[2]
    }

    return unless scan.save

    ScanChannel.broadcast_to(
      scan,
      {
        scan: scan,
        html: ApplicationController.render(partial: "scans/infos", locals: { scan: scan }, formats: :html)
      }
    )
  end
end
