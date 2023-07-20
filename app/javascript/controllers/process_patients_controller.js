import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";

// Connects to data-controller="process-patients"
export default class extends Controller {
  static targets = ["progress", "status", "message"];

  connect() {
    consumer.subscriptions.create("PatientImportChannel", {
      received: (data) => {
        this.progressTarget.style.width = `${data.progress}%`;
        this.progressTarget.setAttribute("aria-valuenow", data.progress);
        this.statusTarget.className = `alert alert-${data.status}`;
        this.messageTarget.innerText = data.message;
      },
    });
  }
}
