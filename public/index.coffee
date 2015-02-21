$(document).ready ->
  # Scroll div#messages to bottom
  $('#messages').scrollTop($('#messages').prop('scrollHeight'))

  # Establish a WebSocket with the server
  ws = new WebSocket('ws://' + window.location.host + window.location.pathname)
  ws.onopen = () ->
    return
  ws.onmessage = (event) ->
    # Parse the JSON string into a message
    message = $.parseJSON event.data
    # Format the message HTML
    messageHtml = "<p><b>" + message.name + ":</b> " + message.text + "</p>"
    # Add the new message to div#messages and highlight
    $(messageHtml).appendTo('#messages').effect('highlight')
    # Scroll div#messages to bottom
    $('#messages').scrollTop($('#messages').prop('scrollHeight'))
    return
  ws.onclose = () ->
    alert("Connection with the server has been lost.")
    return

  $('form').submit (event) ->
    event.preventDefault()
    # Return if name or message are blank
    return if $('#name').val() == "" or $('#text').val() == ""
    # Send the form data on the WebSocket
    ws.send $(this).serialize()
    # Clear the value from text input
    $('#text').val ""
    # Set focus to text input
    $('#text').focus()
    return