# Saves messages and pushes them to all users
class MessageExtension
  def incoming(message, callback)
    return callback.call(message) unless message['channel'] == '/foo'
    save_message message['data']
    callback.call(message)
  end
end
