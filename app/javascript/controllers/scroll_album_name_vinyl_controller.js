import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["scroll"];

  connect() {
    const scrollers = document.querySelectorAll(".scroller");

    scrollers.forEach((scroller) => {
      const scrollerInner = scroller.querySelector(".scroller-inner");

      const scrollerContent = Array.from(scrollerInner.children);

      scrollerContent.forEach((item) => {
          const duplicatedItem = item.cloneNode(true);
          scrollerInner.appendChild(duplicatedItem);
      });
    });
  }
}
