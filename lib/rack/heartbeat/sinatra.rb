require 'rack/heartbeat'

module Conjur
  module Rack
    module Heartbeat
      module Sinatra
        
        def self.extended cls
          cls.module_eval do
            
            configure do
              use ::Rack::Heartbeat
            end

          end
        end
      end
    end
  end
end
