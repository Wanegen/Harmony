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

  def search(vinyl)
    discogs_vinyl = @auth_wrapper.search(
      vinyl.title,
      artist: vinyl.artist_name,
      year: vinyl.year,
      resource_url: vinyl.resource_url #Rechercher à travers cette URL pour choper le main release qui nous filera la tracklist
    ).results.first

    return discogs_vinyl
  end
end
