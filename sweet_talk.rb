require 'sinatra'
require 'sinatra/json'
require 'sinatra-websocket'
require 'coffee-script'
require 'haml'
require 'json'

# Array holds WebSockets
set :sockets, []

# Store all messages here
$messages = []

# Handle conversion of CoffeeScript to JavaScript
get '/*.js' do
  filename = params[:splat].first
  coffee "../public/#{filename}".to_sym
end

get '/' do
  if !request.websocket?
    haml :index
  else
    request.websocket do |ws|
      ws.onopen do
        settings.sockets << ws
      end
      ws.onmessage do |query_string|
        process_query query_string
      end
      ws.onclose do
        settings.sockets.delete ws
      end
    end
  end
end

def process_query(query_string)
  # Build message from the query_string
  message = Rack::Utils.parse_nested_query query_string
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
  # Push the message out to users
  push_message message
end

def save_message(message)
  # Log the message
  puts message
  # Save the message into the array
  $messages << message
end

def push_message(message)
  EM.next_tick do
    settings.sockets.each do |ws|
      # Send the message as JSON to the WebSockets
      ws.send json(message)
    end
  end
end
