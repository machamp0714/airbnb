$(() ->
  App.notifications = App.cable.subscriptions.create { "NotificationsChannel", id: $("#user_id").val() },
  received: (data) ->
    $("#number_of_unread").html(data.unread)
    $("#notifications").prepend(data.message)
)
