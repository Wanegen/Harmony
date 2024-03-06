class ScanChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    scan = Scan.find(params[:scan_id])
    p scan
    stream_for scan
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
