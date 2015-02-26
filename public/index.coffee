$(document).ready ->
  # Create a Faye client to handle server push
  faye = new Faye.Client 'http://' + window.location.host + ':' + window.location.port + '/faye'

  subscription = faye.subscribe '/foo', (message) ->
    # Format the message HTML
    messageHtml = '<p><b>' + message.name + ':</b> ' + message.text + '</p>'
    # Add the new message to div#messages and highlight
    $(messageHtml).appendTo('#messages').effect('highlight')
    # Scroll div#messages to bottom
    $('#messages').scrollTop($('#messages').prop('scrollHeight'))
    return

  # Scroll div#messages to bottom
  $('#messages').scrollTop($('#messages').prop('scrollHeight'))

  $('form').submit (event) ->
    event.preventDefault()
    name = $('#name').val()
    text = $('#text').val()
    # Return if name or message are blank
    return if name == '' or text == ''
    # Publish the form data as JSON
    faye.publish('/foo', {name: name, text: text})
    # Clear the value from text input
    $('#text').val ''
    # Set focus to text input
    $('#text').focus()
    return
