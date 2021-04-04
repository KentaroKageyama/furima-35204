import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const text = `<p>${data.message.content}</p>`;
    const createdAt = `<p>${data.message.created_at.slice(0,19).replace( /T/g , " " ).replace( /-/g , "/" )}</p>`;
    const nickName = `<p>${data.user.nickname}</p>`;
    const html = `
      <div class="message-container">
        <div class="message-nickname">
          <p>${nickName}</p>
        </div>
        <div class="message-box">
          <div class="message-text">
            <p>${text}</p>
          </div>
          <div class="message-created-at">
            <p>${createdAt}</p>
          </div>
        </div>
      </div>`
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_text');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
  }
});
