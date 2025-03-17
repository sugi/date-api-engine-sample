# frozen_string_literal: true

require 'rails_helper'
require 'rswag/specs'

RSpec.describe DateApiEngine::Api::V1::DateController, type: :request do
  path = '/api/v1/date'
  route_name = 'date'

  before do
    # Mock the configuration
    allow(DateApiEngine.configuration).to receive(:default_format).and_return('iso8601')
    allow(DateApiEngine.configuration).to receive(:default_timezone).and_return('UTC')
    
    # Freeze time for consistent test results
    allow(Time).to receive(:now).and_return(Time.new(2023, 3, 16, 12, 34, 56, '+00:00'))
  end

  describe 'GET /api/v1/date' do
    context 'with default parameters' do
      before do
        get path
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the current date in the default format' do
        json_response = JSON.parse(response.body)
        expect(json_response['date']).to eq('2023-03-16T12:34:56Z')
        expect(json_response['format']).to eq('iso8601')
        expect(json_response['timezone']).to eq('UTC')
      end
    end

    context 'with custom parameters' do
      before do
        get path, params: { format: 'rfc3339', timezone: 'America/New_York' }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the current date in the specified format and timezone' do
        json_response = JSON.parse(response.body)
        expect(json_response['format']).to eq('rfc3339')
        expect(json_response['timezone']).to eq('America/New_York')
        # Specific date value test would depend on timezone conversion
      end
    end

    context 'with invalid parameters' do
      before do
        get path, params: { format: 'invalid_format' }
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('Invalid format')
      end
    end

    # Add Swagger documentation metadata (used by rswag-specs)
    swagger_path '/api/v1/date' do
      operation :get do
        key :tags, ['Date']
        key :summary, 'Get current date'
        key :description, 'Returns the current date formatted according to parameters'
        key :operationId, 'getDate'
        
        parameter do
          key :name, :format
          key :in, :query
          key :description, 'Format of the date string'
          key :required, false
          key :schema, { type: :string }
        end
        
        parameter do
          key :name, :timezone
          key :in, :query
          key :description, 'Timezone for the date'
          key :required, false
          key :schema, { type: :string }
        end
        
        response 200 do
          key :description, 'Successful operation'
          content 'application/json' do
            schema do
              key :type, :object
              property :date do
                key :type, :string
                key :example, '2023-03-16T12:34:56Z'
              end
              property :format do
                key :type, :string
                key :example, 'iso8601'
              end
              property :timezone do
                key :type, :string
                key :example, 'UTC'
              end
            end
          end
        end
        
        response 400 do
          key :description, 'Invalid request'
          content 'application/json' do
            schema do
              key :type, :object
              property :error do
                key :type, :string
                key :example, 'Invalid format: xyz'
              end
            end
          end
        end
      end
    end
  end
end