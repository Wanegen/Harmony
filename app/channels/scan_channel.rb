class ScanChannel < ApplicationCable::Channel
  def subscribed
    scan = Scan.find(params[:id])
    stream_for scan
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
