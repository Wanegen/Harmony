import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spotify"
export default class extends Controller {
  static targets = ["tracklist"];
  connect() {
  // console.log("Connected to Spotify controller");
}

playTrack(event) {
  const trackURI = event.currentTarget.dataset.trackUri;
  this.player.pause();
  this.player.play({ uris: [trackURI] });
}

get player() {
  if (this.player) {
    const myToken = ENV['SPOTIFY_TOKEN'];
    this.player = new Spotify.Player({
      name: 'Track player',
      getOAuthToken: cb => { cb(myToken); },
    
    });

    this.player.connect().then(success => {
      if (success) {
        console.log('Connected to Spotify Web Playback SDK');
      }
    }).catch(error => {
      console.error('Failed to connect to Spotify Web Playback SDK', error);
    });
  }
  return this.player;
}
};
