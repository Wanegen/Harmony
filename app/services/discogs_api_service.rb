class DiscogsApiService < ApplicationService
  def initialize
    super
    @auth_wrapper = Discogs::Wrapper.new('Harmony', user_token: ENV['DISCOGS_TOKEN'])
  end

  def get_artist(artist_id)
    @auth_wrapper.get_artist(artist_id)
  end

  # Infos à récupérer sur l'album cherché et à envoyer à l'user pour confirmation
  def get_master(master_id)
    @auth_wrapper.get_master(master_id).title
  end

    # vinyl_attributes = {
    #   title: response.title,
    #   artist_name: response.artists[0].name,
    #   year: response.year,
    # }
end
