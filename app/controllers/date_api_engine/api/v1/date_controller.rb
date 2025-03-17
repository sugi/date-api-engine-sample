# frozen_string_literal: true

module DateApiEngine
  module Api
    module V1
      class DateController < DateApiEngine::ApplicationController
        before_action :validate_params, only: [:index]
        
        # GET /api/v1/date
        def index
          formatter = DateApiEngine::DateFormatter.new(format_param, timezone_param)
          
          render json: {
            date: formatter.format,
            format: format_param,
            timezone: timezone_param
          }
        rescue ArgumentError => e
          render json: { error: e.message }, status: :bad_request
        end
        
        private
        
        def format_param
          params[:format] || DateApiEngine.configuration.default_format
        end
        
        def timezone_param
          params[:timezone] || DateApiEngine.configuration.default_timezone
        end
        
        def validate_params
          formatter = DateApiEngine::DateFormatter.new(format_param, timezone_param)
          
          unless formatter.valid?
            error_messages = []
            error_messages << "Invalid format: #{format_param}" unless formatter.valid_format?(format_param)
            error_messages << "Invalid timezone: #{timezone_param}" unless formatter.valid_timezone?(timezone_param)
            
            render json: { error: error_messages.join(", ") }, status: :bad_request
            return false
          end
          
          true
        end
      end
    end
  end
end