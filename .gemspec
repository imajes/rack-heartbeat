# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["James Cox"]
  gem.email         = ["james@imaj.es"]
  gem.description   = %q{a stupid simple endpoint for returning a 200 OK for your app when hitting /heartbeat}
  gem.summary       = %q{health monitoring endpoint for your app}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-heartbeat"
  gem.require_paths = ["lib"]
  gem.version       = "0.5"
  gem.add_dependency('rack')
end
