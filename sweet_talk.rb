require 'sinatra'
require 'coffee-script'
require 'haml'
require 'json'

# Store all messages here
$messages = []

use Rack::Auth::Basic do |username, password|
  username == ENV['SWEET_TALK_USERNAME'] &&
    password == ENV['SWEET_TALK_PASSWORD']
end

# Handle conversion of CoffeeScript to JavaScript
get '/index.js' do
  coffee :'../public/index'
end

get '/' do
  haml :index
end

def process_message(message)
  # Easter egg
  message['text'] = 'Nice try!' if message['text'].include? '<script>'

  # Strip unwanted params and escape HTML
  message = { 'name' => CGI.escapeHTML(message['name']),
              'text' => CGI.escapeHTML(message['text']) }
  # Add timestamp
  message['time'] = Time.now.to_i
  # Save the message
  save_message message
end

def save_message(message)
  # Log the message
  puts 'Saved: ' + message.inspect
  # Save the message into the array
  $messages << message
end
