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
    discogs_vinyl = DiscogsApiService.new.search(@vinyl)
    @vinyl.title = discogs_vinyl.title
    @vinyl.genre = discogs_vinyl.genre.join('')
    @vinyl.country = discogs_vinyl.country
    @vinyl.resource_url = discogs_vinyl.resource_url
    @vinyl.save
  end

  def new
    @vinyl = Vinyl.new
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = User.first ## bien changer en current_user
    @vinyl.save!

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
    params.require(:vinyl).permit(:title, :artist_name, :year)
  end
end
