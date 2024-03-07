class ScanChannel < ApplicationCable::Channel
  def subscribed
    stream_for "scan_#{params[:scan_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
