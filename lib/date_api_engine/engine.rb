# frozen_string_literal: true

module DateApiEngine
  class Engine < ::Rails::Engine
    isolate_namespace DateApiEngine
    
    config.generators do |g|
      g.test_framework :rspec
      g.assets false
      g.helper false
    end
    
    initializer "date_api_engine.assets" do |app|
      # No asset compilation needed for API-only engine
    end
    
    initializer "date_api_engine.middleware" do |app|
      # Add middleware for request validation if needed
      if defined?(Committee) && app.config.middleware
        # Committee middleware configuration can be added here if needed
      end
    end
    
    config.to_prepare do
      # Any code that needs to run when the engine is loaded
    end
  end
end