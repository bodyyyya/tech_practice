import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "properties"]

  load() {
    const id = this.selectTarget.value
    if (!id) {
      this.propertiesTarget.innerHTML = ""
      return
    }

    const url = new URL(`/categories/${id}/properties_form`, window.location.origin)
    if (this.data.has("productId")) {
      url.searchParams.append("product_id", this.data.get("productId"))
    }

    fetch(url, { headers: { "Accept": "text/html" } })
      .then(r => r.text())
      .then(html => {
        this.propertiesTarget.innerHTML = html
      })
  }
}
