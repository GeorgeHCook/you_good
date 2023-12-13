import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";
export default class extends Controller {
  static values = { chatroomId: Number };
  static targets = ["messages"];
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: data => this.insertMessageAndScrollDown(data),
      }
    );
    // Fetch initial messages from the server
    this.fetchMessages().then(() => {
      // Scroll to the bottom after fetching messages
      this.scrollToBottom();
      console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`);
    });
  }
  // Private method to fetch messages from the server
  async fetchMessages() {
    try {
      const response = await fetch(`/chatrooms/${this.chatroomIdValue}/messages`);
      const data = await response.json();
      // Insert messages into the DOM
      data.messages.forEach(message => {
        this.insertMessageAndScrollDown(message);
      });
    } catch (error) {
      console.error("Error fetching messages:", error);
    }
  }
  // Private method to insert a new message, scroll to the bottom, and reset the form
  insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    this.scrollToBottom();
  }
  // Private method to scroll to the bottom
  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }
  // Reset the form when submitting a message
  resetForm(event) {
    event.target.reset();
  }
  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
