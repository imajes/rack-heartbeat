module Rack
  # A heartbeat mechanism for the server. This will add a _/heartbeat_ endpoint
  # that returns status 200 and content OK when executed.

  class Heartbeat
    @@heartbeat_path = 'heartbeat'
    @@heartbeat_response = 'OK'
    @@heartbeat_headers = {"Content-Type" => "text/plain"}

    class << self
      def heartbeat_path
        @@heartbeat_path
      end

      def heartbeat_response
        @@heartbeat_response
      end

      def heartbeat_headers
        @@heartbeat_headers
      end

      def heartbeat_path=(path)
        @@heartbeat_path = path
      end

      def heartbeat_response=(response)
        @@heartbeat_response = response
      end

      def heartbeat_headers=(headers_hash)
        @@heartbeat_headers = headers_hash
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == "/#{heartbeat_path}"
        NewRelic::Agent.ignore_transaction if defined? NewRelic
        [200, heartbeat_headers, [heartbeat_response]]
      else
        @app.call(env)
      end
    end

    def heartbeat_path
      self.class.heartbeat_path
    end

    def heartbeat_response
      self.class.heartbeat_response
    end

    def heartbeat_headers
      self.class.heartbeat_headers
    end

    def self.setup
      yield self
    end
  end
end
