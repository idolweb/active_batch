$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_batch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_batch"
  s.version     = ActiveBatch::VERSION
  s.authors     = ["adrien"]
  s.email       = ["adrien.montfort@gmail.com"]
  s.homepage    = "https://github.com/idolweb/active_batch"
  s.summary     = "Batch of ActiveJobs"
  s.description = "Allows handling batch of ActiveJobs"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
