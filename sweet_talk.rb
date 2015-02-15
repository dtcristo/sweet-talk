require 'sinatra'
require 'sinatra/json'
require 'coffee-script'
require 'haml'
require 'json'

$messages = [{ time: "15/02/15 22:48:43", name: "David", message: "Hello Lisa!" },
             { time: "15/02/15 22:49:22", name: "Lisa", message: "Hello David!" }]

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
  time = Time.now.strftime "%d/%m/%y %H:%M:%S"
  name = params[:name]
  text = params[:text]
  message = { time: time, name: name, text: text }
  $messages << message

  # Return the new message as JSON
  json message
end
