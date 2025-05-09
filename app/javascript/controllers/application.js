import { Application } from "@hotwired/stimulus"
import CategorySelectController from "./controllers/category_select_controller"
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
Stimulus.register("category-select", CategorySelectController)
export { application }
