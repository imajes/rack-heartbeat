module Rack
  # A heartbeat mechanism for the server. This will add a _/_ endpoint
  # that responds to OPTIONS, returning status 200 when executed.

  class Heartbeat
    DEFAULT_ALLOW = %w(HEAD GET PUT DELETE OPTIONS)

    attr_accessor :allow
    
    def initialize(app, allow = nil)
      @app = app
      @allow = allow || DEFAULT_ALLOW
    end
    
    def call(env)
      if env['PATH_INFO'] == "/" && (env['REQUEST_METHOD']||'').upcase == 'OPTIONS'
        NewRelic::Agent.ignore_transaction if defined? NewRelic
        [200, {"Content-Type" => "text/plain", "Allow" => @allow.join(',')}, ["OK"]]
      else
        @app.call(env)
      end
    end

    def self.setup
      yield self
    end
  end
end
