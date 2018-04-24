# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["James Cox", "Kevin Gilpin"]
  gem.email         = ["james@imaj.es", "kgilpin@gmail.com"]
  gem.summary       = %q{Provides OPTIONS / as a heartbeat URL}
  gem.homepage      = "https://github.com/conjurinc/rack-heartbeat"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "conjur-rack-heartbeat"
  gem.require_paths = ["lib"]
  gem.version       = '2.2.0'

  gem.add_development_dependency('minitest')
  gem.add_development_dependency('rack-test')
  gem.add_development_dependency('minitest-junit')
  gem.add_runtime_dependency('rack')
end
