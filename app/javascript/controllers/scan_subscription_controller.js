import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

// Connects to data-controller="scan-subscription"
export default class extends Controller {
  static values = { scanId: Number };
  static targets = ["scans", "vinylTitle", "vinylArtistName", "vinylYear", "submitBtn"];

  connect() {
    this.channel = createConsumer().subscriptions.create(
      {
        channel: "ScanChannel",
        id: this.scanIdValue,
      },
      {
        // received: data =>
        received: data => this.displayScan(data)
      }
    );
  }
  displayScan(data) {
    console.log(data);
    const scan = data.scan.ai_response;

    const partial = `
      <h2>${scan.title}</h2>
      <p>
        ${scan.artist_name}
      </p>
      <p>${scan.year}</p>`

    console.log(partial);
    this.scansTarget.innerHTML = partial;
    this.vinylTitleTarget.value = scan.title;
    this.vinylArtistNameTarget.value = scan.artist_name;
    this.vinylYearTarget.value = scan.year;
    this.submitBtnTarget.disabled = false;
  }
}
