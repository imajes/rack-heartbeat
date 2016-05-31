# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["James Cox"]
  gem.email         = ["james@imaj.es"]
  gem.description   = %q{provides a simple endpoint for your rails app for a heartbeat client to connect to}
  gem.summary       = %q{provides a simple endpoint for your rails app for a heartbeat client to connect to}
  gem.homepage      = "https://github.com/imajes/rack-heartbeat"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-heartbeat"
  gem.require_paths = ["lib"]
  gem.version       = '1.0.2'

  gem.add_development_dependency('minitest')
  gem.add_development_dependency('rack-test')
  gem.add_runtime_dependency('rack')
end
