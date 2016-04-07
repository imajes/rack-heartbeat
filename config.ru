require 'conjur-rack-heartbeat'

run Rack::Heartbeat.new(proc{ raise "Method not handled"})