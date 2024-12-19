import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["quantityInput"];

  connect() {
    this.quantityInputTargets.forEach(input => {
      input.addEventListener("change", this.handleQuantityChange.bind(this));
    });
  }

  handleQuantityChange(event) {
    const form = event.target.closest("form");
    if (form) {
      form.submit();
    }
  }
}