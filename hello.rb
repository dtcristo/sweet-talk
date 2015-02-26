class Hello
  def incoming(message, callback)
    unless message['channel'] == '/foo'
      return callback.call(message)
    end

    save_message message['data']

    callback.call(message)
  end
end
