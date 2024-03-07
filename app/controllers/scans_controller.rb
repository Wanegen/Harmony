class ScansController < ApplicationController
  def show
    @scan = Scan.find(params[:id])
    @vinyl = Vinyl.new
  end

  def new
    @scan = Scan.new
  end

  def create
    @scan = Scan.new(scan_params)
    @scan.save!
    CreateScanJob.perform_later(@scan.id)
    # else
    # flash[:alert] = "Something went wrong"
    # render :new
    # end

    redirect_to scan_path(@scan)
  end

  private

  def scan_params
    params.require(:scan).permit(:image)
  end
end
