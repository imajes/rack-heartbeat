module Rack

  class HeartBeatRailtie < Rails::Railtie
    require 'middleware'

    initializer "heartbeat.initializer" do |app|
      app.middleware.insert_before('Rack::Lock', 'Rack::Heartbeat')
    end
  end

end
