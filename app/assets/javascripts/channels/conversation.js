App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
 
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
 
  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
  
    // check if under the data window we pass a partial
    if (data['window'] !== undefined) {
      var conversation_visible = conversation.is(':visible');
  
      if (conversation_visible) {
        var messages_visible = (conversation).find('.card-body').is(':visible');
  
        if (!messages_visible) {
          conversation.addClass('card--screaming');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#conversations-list').append(data['window']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        conversation.find('.card-body').toggle();
      }
    }
    else {
      conversation.find('ul').append(data['message']);
    }
  
    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});
$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});