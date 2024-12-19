import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["minPrice", "maxPrice", "selectedRange"];

  connect() {
    this.updatePrice();
    this.addEventListeners();
  }

  addEventListeners() {
    this.minPriceTarget.addEventListener("input", () => this.updatePrice());
    this.maxPriceTarget.addEventListener("input", () => this.updatePrice());
  }

  updatePrice() {
    const minPrice = this.minPriceTarget.value;
    const maxPrice = this.maxPriceTarget.value;
    this.selectedRangeTarget.textContent = `${minPrice} - ${maxPrice}`;
  }
}
