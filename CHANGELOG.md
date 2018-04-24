# 2.2.0

- Use a symbol when loading `Rack::Heartbeat` into the app's middleware. This change means we can support Rails 5.2+. From upstream https://github.com/imajes/rack-heartbeat/commit/cac635cd29a61afd23899128b674443176295ad5

# 2.1.0

- Add Sinatra support [#1](https://github.com/conjurinc/rack-heartbeat/pull/1)

# 2.0.0

- Adapted to provide `OPTIONS /` as a heartbeat URL, for Conjur

# 1.0.1

- Forked from https://github.com/imajes/rack-heartbeat
