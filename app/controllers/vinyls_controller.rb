class VinylsController < ApplicationController
  def index
    if params[:query].present?
      @vinyls = Vinyl.search(params[:query])
     #params[:query] = nil
    else
      @vinyls = Vinyl.all.order(created_at: :desc)
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
    # On récupère également la resource_url pour avoir accès à une autre URL que l'on parse.
    # On parse l'autre URL (main_release) pour récupérer la tracklist.
    # On affiche la tracklist dans la vue show.
  end

  def new
    @vinyl = Vinyl.new
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = User.first ## bien changer en current_user
    @vinyl.save!
    DiscogsApiService.new.update_vinyl_infos(@vinyl)

    redirect_to vinyl_path(@vinyl)
  end

  def destroy
    @vinyl = Vinyl.find(params[:id])
    @vinyl.destroy

    redirect_to vinyls_path
    @vinyls = Discogs::Wrapper.all
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist_name, :year, :genres)
  end
end
