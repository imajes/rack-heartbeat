module Rack::Heartbeat

  class HeartBeatRailtie < Rails::Railtie
    initializer "heartbeat.initializer" do |app|
      app.middleware.insert_before('Rack::Lock', 'Rack::Heartbeat')
    end
  end

end
