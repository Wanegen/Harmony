import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["vinyl", "audio"];
  connect() {
    console.log("coucou");
    console.log(this.vinylTarget);
    this.vinylTarget.style.animationPlayState = "paused";
    this.audioElement = new Audio("/audio/scratch.mp3");
  }

  stop() {
    this.vinylTarget.style.animationPlayState = "paused";
  }

  play() {
    this.vinylTarget.style.animationDelay = "0s";
    this.vinylTarget.style.animationPlayState = "running";
  }

  scratch() {
    console.log(this.audioTarget);
    this.audioTarget.pause();
    this.audioElement.play();
    setTimeout(() => {
      this.audioTarget.play();
    }, 300);

    this.vinylTarget.animate(
      {
        transform: [
          "rotate(0deg)",
          "rotate(-10deg)",
          "rotate(10deg)",
          "rotate(0deg)",
        ],
      },
      {
        duration: 500,
        iterations: 1,
      }
    );
  }
}
