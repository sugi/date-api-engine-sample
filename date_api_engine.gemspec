# frozen_string_literal: true

require_relative "lib/date_api_engine/version"

Gem::Specification.new do |spec|
  spec.name        = "date_api_engine"
  spec.version     = DateApiEngine::VERSION
  spec.authors     = ["Date API Engine Team"]
  spec.email       = ["info@dateapiengine.com"]
  spec.homepage    = "https://github.com/dateapiengine/date_api_engine"
  spec.summary     = "Rails engine for date API."
  spec.description = "A mountable Rails engine that provides a RESTful API for date information."
  spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7.1.0"
  spec.add_dependency "tzinfo", "~> 2.0"
  
  # API documentation
  spec.add_dependency "rswag-api", "~> 2.9"
  spec.add_dependency "rswag-ui", "~> 2.9"
  
  # OpenAPI validation
  spec.add_dependency "committee", "~> 5.0"
  
  # Development dependencies
  spec.add_development_dependency "rspec-rails", "~> 6.0"
  spec.add_development_dependency "rswag-specs", "~> 2.9"
  spec.add_development_dependency "sqlite3", "~> 1.4"
end