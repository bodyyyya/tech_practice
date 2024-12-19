import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["shippingAddress", "errorDiv"];

  connect() {
    this.emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    this.shippingAddressTarget.addEventListener("input", this.validateEmail.bind(this));
  }

  validateEmail() {
    if (this.emailRegex.test(this.shippingAddressTarget.value)) {
      this.errorDivTarget.style.display = "none";
    } else {
      this.errorDivTarget.style.display = "block";
    }
  }
}
