class CreateScanJob < ApplicationJob
  queue_as :default

  def perform(scan_id)
    scan = Scan.find(scan_id)
    chaptgpt_response = GptApiImageCallService.call(scan) # background job
    infos = chaptgpt_response["choices"][0]["message"]["content"].split(",").map(&:strip)
    scan.ai_response = {
      title: infos[0],
      year: infos[1],
      artist_name: infos[2]
    }

    if scan.save
      ActionCable.server.broadcast(
        "scan_#{scan.id}",
        {html: ApplicationController::render(partial: "scans/scan", locals: { scan: scan }, layout: false, formats: %i[html])}
      )
    end
    # broadcast to the chatgpt channel
  end
end
