class TracksController < ApplicationController
    def preview
        track_title = params[:title]
        artist_name = params[:artist_name]
        #fetch_preview_url pour obtenir l'URL de prévisualisation depuis l'API Spotify
        preview_url = SpotifyService.new.fetch_preview_url(track_title, artist_name)
        render json: { preview_url: preview_url }
end
