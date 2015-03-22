# Rack::Heartbeat

A tiny gem that installs a Rack middleware to respond to heartbeat requests.  This saves you all the trouble of creating custom controllers, routes, and static files, and prevents your logs from bloating.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-heartbeat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-heartbeat

## Usage

Once the gem is installed, you're done.  Just browse to localhost:300/heartbeat to get a text response with "OK".

If you want to customize the url for any reason, you can configure that, too:

```ruby
#config/initializers/rack_heartbeat.rb
Rack::Heartbeat.setup do |config|
  config.heartbeat_path = 'health-check.txt'
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
* [Steve Mitchell](http://github.com/theSteveMitchell)
