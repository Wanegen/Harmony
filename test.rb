require 'uri'
require 'net/http'
require 'json'

# curl -X POST "https://accounts.spotify.com/api/token" \
#     -H "Content-Type: application/x-www-form-urlencoded" \
#     -d "grant_type=client_credentials&client_id=988a29d6db5149ac8b1b6e139c3d8a4a&client_secret=6d2774bf919c4fdab0938dee6105cc64"


# def fetch_preview_url 
    track_title = "In the end"
    uri = URI.parse("https://api.spotify.com/v1/search?q=#{track_title}%20artist%3ALinkin%20Park&type=track&limit=2")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer BQCtbA5myblZ7HNxpRFYri0NvbljrFvBP2XBdpQ5LJDG3F_cz81cAXhxOkRZ6ZPX01Q6po0CQHF-_pfNm6p197u2waOhnbxSnkTc858BeQqcQpvB8Ss"
    response = http.request(request)
    puts response.body

    response_url = JSON.parse(response.body)
    tracks = response_url['tracks']['items']

# Maintenant, vous pouvez itérer sur chaque piste pour accéder à sa preview_url et afficher les détails de la piste
tracks.each do |track|
  name = track['name']
  preview_url = track['preview_url']
    puts "#{preview_url}"
    
end