require 'dotenv'
require 'faye'
require_relative 'message_extension'
require_relative 'sweet_talk'

# Load environment variables
Dotenv.load

use Faye::RackAdapter, mount: '/faye', timeout: 25 do |faye|
  faye.add_extension(MessageExtension.new)
end

run Sinatra::Application
