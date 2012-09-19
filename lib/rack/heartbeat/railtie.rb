module Rack

  class Heartbeat::Railtie < Rails::Railtie
    require 'middleware'

    initializer "rack.heartbeat.initializer" do |app|
      app.middleware.insert_before('Rack::Lock', 'Rack::Heartbeat')
    end
  end

end
