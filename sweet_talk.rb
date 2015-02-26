require 'sinatra'
require 'coffee-script'
require 'haml'
require 'json'

# Store all messages here
$messages = []

# Handle conversion of CoffeeScript to JavaScript
get '/index.js' do
  coffee :'../public/index'
end

get '/' do
  haml :index
end

def process_message(message)
  # Easter egg
  if message['text'].include? '<script>'
    message['text'] = 'Nice try!'
  end
  # Strip unwanted params and escape HTML
  message = {'name' => CGI::escapeHTML(message['name']), 'text' => CGI::escapeHTML(message['text'])}
  # Add timestamp
  message['time'] = Time.now.to_i
  # Save the message
  save_message message
end

def save_message(message)
  # Log the message
  puts "Saved: " + message.inspect
  # Save the message into the array
  $messages << message
end
