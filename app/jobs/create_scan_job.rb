class CreateScanJob < ApplicationJob
  queue_as :default

  def perform(scan_id)
    puts "✅✅✅✅✅✅✅✅"
    puts "job"
    puts scan_id
    scan = Scan.find(scan_id)
    p scan
    p scan.image.key
    puts "✅✅✅✅✅✅✅✅"
    # chaptgpt_response = GptApiImageCallService.call(scan)
    # infos = chaptgpt_response["choices"][0]["message"]["content"].split(",").map(&:strip)
    # scan.ai_response = {
    #   title: infos[0],
    #   year: infos[1],
    #   artist_name: infos[2],
    # }

    # if scan.save
    sleep 3
    ScanChannel.broadcast_to(scan, { scan: scan, status: "started" })

    # end
    # broadcast to the chatgpt channel
  end
end
