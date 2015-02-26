require 'faye'
require_relative 'hello'
require_relative 'sweet_talk'

use Faye::RackAdapter, mount: '/faye', timeout: 25 do |faye|
  faye.add_extension(Hello.new)
end

run Sinatra::Application
