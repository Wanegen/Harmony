import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable";

// Connects to data-controller="scan-subscription"
export default class extends Controller {
  static values = {scanId: Number}
  static targets = ["scans"]


  connect() {
    console.log("coucou");
    this.channel= createConsumer().subscriptions.create(
      {channel: "ScanChannel", id: this.scanIdValue},
      { received: data => console.log("salut") })
  }
  displayScan(data) {
    console.log(data);
  }
}



// this.displayScan(data)
