class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
  end

  def new
    @vinyl = Vinyl.new
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = current_user
    @vinyl.save

    redirect_to user_vinyls_path(current_user)
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def destroy
    @vinyl = Vinyl.find(params[:id])
    @vinyl.destroy

    redirect_to user_vinyls_path
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist_name, :year)
  end
end
