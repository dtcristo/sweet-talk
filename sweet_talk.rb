require 'sinatra'
require 'sinatra/json'
require 'sinatra-websocket'
require 'coffee-script'
require 'haml'
require 'json'

set :bind, '0.0.0.0'
set :server, 'thin'
set :sockets, []

$messages = [{ "name" => "David", "text" => "Hello Lisa!", "time" => 1424397388},
             { "name" => "Lisa", "text" => "Hello David!", "time" => 1424397411}]

# Handle conversion of CoffeeScript to JavaScript
get '/coffee/*.js' do
  filename = params[:splat].first
  coffee "../public/coffee/#{filename}".to_sym
end

get '/' do
  if !request.websocket?
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        settings.sockets << ws
      end
      ws.onmessage do |query_string|
        # Build message from the query_string
        message = Rack::Utils.parse_nested_query query_string
        # Add timestamp
        message["time"] = Time.now.to_i
        # Save the message
        save_message message
        # Push the message out to users
        push_message message
      end
      ws.onclose do
        settings.sockets.delete ws
      end
    end
  end
end

def save_message(message)
  # Save the message into the array
  $messages << message
end

def push_message(message)
  EM.next_tick do
    settings.sockets.each do |ws|
      # Send the message as JSON to the WebSockets
      puts json(message)
      ws.send json(message)
    end
  end
end
