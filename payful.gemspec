$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payful/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payful"
  s.version     = Payful::VERSION
  s.authors     = ["Alexandre de Oliveira"]
  s.email       = ["chavedomundo@gmail.com"]
  s.homepage    = "https://github.com/kurko/payful"
  s.summary     = "Summary"
  s.description = "Description"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"

  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
end
