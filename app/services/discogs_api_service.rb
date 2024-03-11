class DiscogsApiService < ApplicationService
  def initialize
    super
    @auth_wrapper = Discogs::Wrapper.new('Harmony', user_token: ENV['DISCOGS_TOKEN'])
  end

  # DiscogsApiService.new.update_vinyl_infos(Vinyl.last)
  def update_vinyl_infos(vinyl)
    discogs_vinyl = @auth_wrapper.search(
      vinyl.title,
      artist: vinyl.artist_name,
      year: vinyl.year
    ).results.first

    return unless discogs_vinyl

    resource_url = discogs_vinyl.resource_url

    return unless resource_url

    main_release_url = fetch_main_release_url(resource_url)[:main_release_url]
    master_id = fetch_main_release_url(resource_url)[:master_id]

    return unless main_release_url

    data = fetch_data(main_release_url)

    return unless data

    @tracks = fetch_tracklist(data)

    @album_name = fetch_album_name(data)
    @artist_name = fetch_artist_name(data)
    @genres = fetch_genres(data)
    @image = fetch_image(master_id)

    vinyl.update(
      title: @album_name,
      artist_name: @artist_name,
      genres: @genres,
      image: @image,
      tracklist: @tracks
    )
    @tracks.each do |track|
      Track.create(vinyl: vinyl, title: track['title'], duration: track['duration'], position: track['position'])
    end
  end

  def fetch_genres(data)
    data['genres'][0]
  end

  def fetch_tracklist(data)
    data['tracklist']
  end

  def fetch_album_name(data)
    data['title']
  end

  def fetch_artist_name(data)
    data['artists'][0]['name']
  end

  def fetch_image(master_id)
    uri = URI.parse("https://api.discogs.com/masters/#{master_id}?key=HGHIIftFnwvcnLhUSrfj&secret=ONgzBXNSiNqgIWwoluOGoNOMvhBVnWMr")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.code == '200'
      # Parser les données JSON
      data = JSON.parse(response.body)

      data['images'][0]['uri']
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
      { main_release_url: data['main_release_url'], master_id: data['id'] }
    else
      puts "La requête a échoué avec le code : #{response.code}"
      nil
    end
  end

  def fetch_data(main_release_url)
    uri = URI.parse(main_release_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    if response.code == '200'
      # Parser les données JSON
      data = JSON.parse(response.body)
      # Extraction du titre de l'album
      data
    else
      puts "La requête a échoué avec le code : #{response.code}"
      return nil
    end
  end
end
