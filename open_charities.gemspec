require File.expand_path('../lib/open_charities/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec', '~> 2.9.0'
  gem.add_development_dependency 'mocha', '~> 0.10.5'
  gem.add_development_dependency 'webmock', '~> 1.8.8'

  gem.add_runtime_dependency "faraday", "~> 0.8.4"
  gem.add_runtime_dependency "json"

  gem.name = 'open-charities'
  gem.summary = "A wrapper around Open Charities API"
  gem.version = OpenCharities::VERSION.dup
  gem.authors = ['Karl Sutt']
  gem.email = ['karl@gocardless.com']
  gem.homepage = 'https://github.com/gocardless/open-charities'
  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec/*`.split("\n")
end
