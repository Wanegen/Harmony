import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="scan"
export default class extends Controller {
  connect() {
    console.log(this.element);
  }

  submit() {
    this.element.submit();
  }
}
