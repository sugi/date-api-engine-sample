# frozen_string_literal: true

if defined?(Committee)
  # This initializer configures the Committee gem for request validation
  # against OpenAPI specifications. It's used to validate both requests and responses.
  
  DateApiEngine::Engine.config.middleware.use Committee::Middleware::RequestValidation,
    schema_path: File.join(DateApiEngine::Engine.root, 'swagger', 'v1', 'swagger.yaml'),
    strict: true,
    error_handler: -> (ex) {
      { 
        status: 400, 
        headers: { 'Content-Type' => 'application/json' }, 
        body: JSON.dump(error: ex.message) 
      }
    }
  
  # Optional: Response validation can be enabled in development/test environments
  if Rails.env.development? || Rails.env.test?
    DateApiEngine::Engine.config.middleware.use Committee::Middleware::ResponseValidation,
      schema_path: File.join(DateApiEngine::Engine.root, 'swagger', 'v1', 'swagger.yaml'),
      strict: true
  end
end