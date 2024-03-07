import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

// Connects to data-controller="scan-subscription"
export default class extends Controller {
  static values = { scanId: Number };
  static targets = ["scans"];

  connect() {
    console.log("coucou");
    console.log(this.scanIdValue);
    this.channel = createConsumer().subscriptions.create(
      {
        channel: "ScanChannel",
        id: this.scanIdValue,
      },
      {
        received: (data) => this.displayScan(data),
        connected: () => console.log("connected"),
      }
    );
    console.log(this.channel);
  }
  displayScan(data) {
    console.log(data);
  }
}
