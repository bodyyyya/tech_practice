import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "properties"]

  load(event) {
    const categoryId = this.selectTarget.value
    if (!categoryId) return

    fetch(`/categories/${categoryId}/properties_form`)
      .then(res => res.text())
      .then(html => this.propertiesTarget.innerHTML = html)
  }
}
