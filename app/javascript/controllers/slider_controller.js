import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets=["input","label"]
  connect() {
    this.inputTarget.addEventListener("input", event => {
      const value = Number(this.inputTarget.value) / 100;
      this.inputTarget.style.setProperty('--r', `${value * 0}deg`);
      this.labelTarget.innerHTML = Math.round(value * 50);
    });
  }
}
