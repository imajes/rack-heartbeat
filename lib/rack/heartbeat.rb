module Rack
  # A heartbeat mechanism for the server. This will add a _/heartbeat_ endpoint
  # that returns status 200 and content OK when executed.

  class Heartbeat
    @@heartbeat_path = 'heartbeat'

    class << self
      def heartbeat_path
        @@heartbeat_path
      end

      def heartbeat_path=(path)
        @@heartbeat_path = path
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == "/#{heartbeat_path}"
        NewRelic::Agent.ignore_transaction if defined? NewRelic
        [200, {"Content-Type" => "text/plain"}, ["OK"]]
      else
        @app.call(env)
      end
    end

    def heartbeat_path
      self.class.heartbeat_path
    end

    def self.setup
      yield self
    end
  end
end
