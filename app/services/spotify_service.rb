class SpotifyService < ApplicationService
    def initialize(vinyl)
        @vinyl = vinyl
    end

    def encode_spotify_query(value)
        # Encodage des noms de tracks et d'artistes pour éviter les erreurs de requête et les problèmes de caractères spéciaux
        URI.encode_www_form_component(value)
        # query_string = "q=#{encoded_track_name}%2520track%3A#{encoded_artist_name}&type=track&limit=#{limit}"
    end

    def call
        @vinyl.tracks.each do |track|
            track.update(preview_url: fetch_preview_url(track))
        end
    end

    def fetch_preview_url(track)
        uri = URI.parse("https://api.spotify.com/v1/search?q=q=#{encode_spotify_query(track[:title])}artist:#{encode_spotify_query(track[:artist_name])}&type=track&limit=1")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'
        request = Net::HTTP::Get.new(uri)
        request['Authorization'] = "Bearer #{get_token}"
        response = http.request(request)
        puts response.body
        
        if response.code == "200"
            response_url = JSON.parse(response.body)
            tracks = response_url['tracks']['items']
            return tracks.first['preview_url']
        else
            puts "La requête a échoué avec le code : #{response.code}"
            return "not found"
        end
    end

    def get_token
        url = URI("https://accounts.spotify.com/api/token")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/x-www-form-urlencoded"
        request.body = "grant_type=client_credentials&client_id=#{ENV['CLIENT_ID_TOKEN']}&client_secret=#{ENV['CLIENT_SECRET_TOKEN']}"

        response = http.request(request)
        response_hash = JSON.parse(response.read_body)
        return response_hash["access_token"]
    end
end

#recupérer l'ID, je demande à spotify les infos du track et je récup l'URL 