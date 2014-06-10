module Rack
  # A heartbeat mechanism for the server. This will add a _/heartbeat_ endpoint
  # that returns status 200 and content OK when executed.

  class Heartbeat
    cattr_accessor :heartbeat_path
    @@heartbeat_path = 'heartbeat'
    
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == "/#{heartbeat_path}"
        [200, {"Content-Type" => "text/plain"}, ["OK"]]
      else
        @app.call(env)
      end
    end

    def self.setup
      yield self
    end
  end
end
