# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'guard/behat/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Eric Hogue"]
  gem.email         = ["eric@erichogue.ca"]
  gem.description   = %q{Automatically run behat tests}
  gem.summary       = %q{Guard gem for running behat}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "guard-behat"
  gem.require_paths = ["lib"]
  gem.version       = Guard::Behat::VERSION
end
