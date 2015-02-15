$(document).ready ->

  $('form').submit (event) ->
    event.preventDefault()
    # Return if name or message are blank
    return if $('#name').val() == "" or $('#text').val() == ""
    # POST the form
    $.ajax
      type: 'post'
      url: $(this).attr('action')
      data: $(this).serialize()
      dataType: 'json'
      success: (json) ->
        # Clear the message from text input
        $('#text').val ""
        # Format the message
        message = "<p><b>" + json.name + "</b> [" + json.time + "]: " + json.text + "</p>"
        # Add the new message to #messages and highlight
        $(message).appendTo('#messages').effect('highlight')
