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
    if @scan.save
      CreateScanJob.perform_later(@scan.id)
      redirect_to scan_path(@scan)
    else
      flash[:alert] = "Something went wrong"
      render :new
    end


  end

  private

  def scan_params
    params.require(:scan).permit(:image)
  end
end
