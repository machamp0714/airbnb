$(() -> 
  App.messages = App.cable.subscriptions.create { channel: "MessagesChannel", id: $("#conversation_id").val() },
    received: (data) ->
      $("#chat").prepend data.message
)
