class DiscogsApiService < ApplicationService
  def initialize
    super
    @auth_wrapper = Discogs::Wrapper.new('Harmony', user_token: ENV['DISCOGS_TOKEN'])
  end

  def search(vinyl)
    discogs_vinyl = @auth_wrapper.search(
      vinyl.release_title,
      artist: vinyl.artist_name,
      year: vinyl.year,
      genre: vinyl.genre,
      resource_url: vinyl.resource_url
    ).results.first

    # Vérifier si discogs_vinyl n'est pas nil pour éviter les erreurs
    if discogs_vinyl
      # Récupérer la main_release_url à partir de la resource_url
      main_release_url = fetch_main_release_url(discogs_vinyl.resource_url)

      # Ajouter la main_release_url aux données discogs_vinyl
      discogs_vinyl.main_release_url = main_release_url if main_release_url
    end
    return discogs_vinyl
  end

  def fetch_tracklist(main_release_url)
    # Effectuer la requête HTTP pour récupérer les données JSON
    uri = URI.parse(main_release_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.code == '200'
      # Parser les données JSON
      data = JSON.parse(response.body)
      # Extraction de la tracklist
      data['tracklist']
    else
      puts "La requête a échoué avec le code : #{response.code}"
      return nil
    end
  end

  def fetch_album_name(main_release_url)
    # Effectuer la requête HTTP pour récupérer les données JSON
    uri = URI.parse(main_release_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.code == '200'
      # Parser les données JSON
      data = JSON.parse(response.body)
      # Extraction du titre de l'album
      data['title']
    else
      puts "La requête a échoué avec le code : #{response.code}"
      return nil
    end
  end

  def fetch_artist_name(main_release_url)
    # Effectuer la requête HTTP pour récupérer les données JSON
    uri = URI.parse(main_release_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.code == '200'
      # Parser les données JSON
      data = JSON.parse(response.body)
      # Extraction du titre de l'album
      data['artists'][0]['name']
    else
      puts "La requête a échoué avec le code : #{response.code}"
      return nil
    end
  end

  private

  def fetch_main_release_url(resource_url)
    # Effectuer la requête HTTP pour récupérer les données JSON
    uri = URI.parse(resource_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.code == '200'
      # Parser les données JSON
      data = JSON.parse(response.body)
      # Extraire la main_release_url si elle est présente
      main_release_url = data['main_release_url']
      return main_release_url
    else
      puts "La requête a échoué avec le code : #{response.code}"
      nil
    end
  end
end
