$(document).ready ->

  $('form').submit (event) ->
    event.preventDefault()
    $.ajax
      type: 'post'
      url: $(this).attr('action')
      data: $(this).serialize()
      dataType: 'json'
      success: (json) ->
        message = "<p>" + json.name + " [" + json.time + "]: " + json.text + "</p>"
        # Add the new message to .messages and highlight
        $(message).appendTo('.messages').effect('highlight')
