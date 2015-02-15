require 'sinatra'
require 'sinatra/json'
require 'coffee-script'
require 'haml'
require 'json'

$messages = [{ time: "earlier", name: "David", message: "Hello Lisa!" },
             { time: "later", name: "Lisa", message: "Hello David!" }]

# Handle conversion of CoffeeScript to JavaScript
get '/coffee/*.js' do
  filename = params[:splat].first
  coffee "../public/coffee/#{filename}".to_sym
end

get '/' do
  erb :index
end

get '/messages' do
  json $messages
end

post '/messages' do
  time = Time.now.strftime "%Y-%m-%d %H:%M:%S"
  name = params[:name]
  text = params[:text]
  message = { time: time, name: name, text: text }
  $messages << message

  # Return the new message as JSON
  json message
end
