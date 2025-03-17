# frozen_string_literal: true

DateApiEngine::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'date', to: 'date#index'
    end
  end

  # Mount Swagger UI if using rswag
  if defined?(Rswag)
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end
end