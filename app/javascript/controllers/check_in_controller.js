import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-in"
export default class extends Controller {
  connect() {
  }

  toggle(event) {
    event.preventDefault()
    const targetElement = event.target.parentElement
    let stepId = parseInt(targetElement.id.slice(-1), 10)
    const nextElement = document.querySelector(`#step${stepId + 1}`)
    targetElement.classList.toggle("d-none")
    nextElement.classList.toggle("d-none")
  }
}
