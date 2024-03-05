class ScansController < ApplicationController
  def show
    @scan = Scan.find(params[:id])
  end

  def new
    @scan = Scan.new
  end

  def create
    @scan = Scan.new(scan_params)
    @scan.user = current_user
    @scan.save

    redirect_to user_vinyls_path(current_user)
  end
end
