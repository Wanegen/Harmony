class VinylsController < ApplicationController
  def index
    if params[:query].present?
      @vinyls = Vinyl.search(params[:query])
     #params[:query] = nil
    else
      @vinyls = Vinyl.all
    end

  respond_to do |format|
      format.html
      format.text do
      render partial: 'vinyls/index', locals: { vinyls: @vinyls }, formats: [:html]
      end
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
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


  def destroy
    @vinyl = Vinyl.find(params[:id])
    @vinyl.destroy

    redirect_to vinyls_path
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist_name, :year)
  end
end
