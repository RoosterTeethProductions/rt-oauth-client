$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rt_oauth_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rt-oauth-client"
  s.version     = RtOauthClient::VERSION
  s.authors     = ["Mike Quinn"]
  s.email       = ["mike.quinn@roosterteeth.com"]
  s.summary       = %q{Adds oauth client functionality}
  s.description   = %q{Adds oauth client functionality}
  s.homepage      = "http://roosterteeth.com"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "oauth2", "~> 1.0"

  s.add_development_dependency "bundler", "~> 1.15"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "webmock", "~> 3.0"
  s.add_development_dependency "factory_girl", "~> 4.7.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.7.0"
end