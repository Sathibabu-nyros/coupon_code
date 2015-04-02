$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "coupons_code/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "coupons_code"
  s.version     = CouponsCode::VERSION
  s.authors     = ["Sathibabu"]
  s.email       = ["sathibabu"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CouponsCode."
  s.description = "TODO: Description of CouponsCode."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_development_dependency "mysql2"  
  s.add_dependency 'sass-rails'  
  s.add_development_dependency 'bundler' 
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-rails' 
  s.add_development_dependency 'generator_spec'

end
