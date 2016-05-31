# Rack::Heartbeat

A tiny gem that installs a Rack middleware to respond to heartbeat requests. This saves you all the trouble of creating custom controllers, routes, and static files, and prevents your logs from bloating.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-heartbeat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-heartbeat

## Usage

Once the gem is installed, you're done.  Just browse to http://localhost:3000/heartbeat to get a text response with "OK".

If you want to customize the url for any reason, you can configure that, too:

```ruby
# config/initializers/rack_heartbeat.rb
Rack::Heartbeat.setup do |config|
  config.heartbeat_path = 'health-check.txt'
end
```

You can also customize headers and response, for example if you want to do the cross-domain request, you can
either set the CORS headers, or just send an image:

```ruby
# config/initializers/rack_heartbeat.rb
Rack::Heartbeat.setup do |config|
  config.heartbeat_response = Base64.decode64('R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
  config.heartbeat_headers = {'Content-Type' => 'image/gif'}
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contributors

* [James Cox](https://github.com/imajes)
* [Steve Mitchell](https://github.com/theSteveMitchell)
* [Igor Rzegocki](https://github.com/ajgon)
