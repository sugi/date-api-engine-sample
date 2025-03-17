# date_api_engine/example/config/routes.rb

Rails.application.routes.draw do
  # Mount the Date API Engine at the root path
  mount DateApiEngine::Engine, at: '/'
  
  # You can also mount it at a specific path if needed
  # mount DateApiEngine::Engine, at: '/date-api'
  
  # Root route to redirect to API documentation if available
  root to: redirect('/api-docs') if defined?(Rswag)
end