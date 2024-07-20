# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version       = '0.3.0'
  gem.name          = 'omniauth-kerberos'
  gem.authors       = ['Jan Graichen']
  gem.email         = ['jan.graichen@altimos.de']
  gem.description   = 'An OmniAuth strategy for Kerberos.'
  gem.summary       = 'An OmniAuth strategy for Kerberos.'
  gem.homepage      = 'https://github.com/jgraichen/omniauth-kerberos'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.add_dependency 'timfel-krb5-auth', '~> 0.8'
  gem.add_dependency 'omniauth-multipassword', '~> 2.0'
end
