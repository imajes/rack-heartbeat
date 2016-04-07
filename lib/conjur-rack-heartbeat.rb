require 'rack/heartbeat'

if defined?(Rails)
  require 'rack/heartbeat/railtie'
elsif defined?(Sinatra)
  require 'rack/heartbeat/sinatra'
end

