module Rack

  class Heartbeat::Railtie < Rails::Railtie
    initializer "rack.heartbeat.initializer" do |app|
      app.middleware.insert 0, Rack::Heartbeat
    end
  end

end
