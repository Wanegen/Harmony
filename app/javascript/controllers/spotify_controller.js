import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spotify"
export default class extends Controller {
  static targets = ["tracks"];
  connect() {
  console.log("Connected to Spotify controller");
  this.initializeplayer();
}
// playTrack(event) {
//   const trackURI = event.currentTarget.dataset.trackUri;
//   console.log("Lecture de la piste :", trackURI);

initializeplayer() {
  window.onSpotifyWebPlaybackSDKReady = () => {
    const myToken = ENV['SPOTIFY_TOKEN'];
    const player = new Spotify.Player({
      name: 'Player',
      getOAuthToken: cb => { cb(myToken); },
    });


    player.connect().then(success => {
      if (success) {
        console.log('Connected to Spotify Web Playback SDK');
      }
    }).catch(error => {
      console.error('Failed to connect to Spotify Web Playback SDK', error);
    });

    player.addListener('ready', ({ device_id }) => {
      console.log('Connecté avec', device_id);

  });}
}};
