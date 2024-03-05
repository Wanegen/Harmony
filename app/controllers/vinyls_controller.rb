class VinylsController < ApplicationController
  def index
    @vinyls = Discogs::Wrapper.all
  end

  def show
    @vinyl = DiscogsApi.new.get_vinyl(params[:id])
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist_name, :year)
  end
end
