class SpotifyService < ApplicationService
    def initialize(vinyl)
        @vinyl = vinyl
    end

    def call
        @vinyl.tracks.each do |track|
            track.update(preview_url: fetch_preview_url(track))
        end
    end

    def fetch_preview_url(track, track_title)
        track_title = "In the end"
        uri = URI.parse("https://api.spotify.com/v1/search?q=#{track_title}%20artist%3ALinkin%20Park&type=track&limit=2")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'
        request = Net::HTTP::Get.new(uri)
        request['Authorization'] = "Bearer BQCtbA5myblZ7HNxpRFYri0NvbljrFvBP2XBdpQ5LJDG3F_cz81cAXhxOkRZ6ZPX01Q6po0CQHF-_pfNm6p197u2waOhnbxSnkTc858BeQqcQpvB8Ss"
        response = http.request(request)
        puts response.body
    if response.code == "200"
        response_url = JSON.parse(response.body)
        tracks = response_url['tracks']['items']
        tracks.each do |track|
        name = track['name']
        preview_url = track['preview_url']
        puts "#{preview_url}"
    else
        puts "La requête a échoué avec le code : #{response.code}"
        return nil
        end
end

#recupérer l'ID, je demande à spotify les infos du track et je récup l'URL 