import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-in"
export default class extends Controller {
  connect() {
  }

  next(event) {
    console.log(event)
    event.preventDefault()
    const targetElement = event.currentTarget.parentElement.parentElement
    let stepId = parseInt(targetElement.id.slice(-1), 10)
    const nextElement = document.querySelector(`#step${stepId + 1}`)
    targetElement.classList.toggle("d-none")
    nextElement.classList.toggle("d-none")
  }
  previous(event) {
    console.log(event)
    event.preventDefault()
    const targetElement = event.currentTarget.parentElement
    let stepId = parseInt(targetElement.id.slice(-1), 10)
    const nextElement = document.querySelector(`#step${stepId - 1}`)
    targetElement.classList.toggle("d-none")
    nextElement.classList.toggle("d-none")
  }
}
