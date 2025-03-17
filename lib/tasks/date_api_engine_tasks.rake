# frozen_string_literal: true

namespace :date_api_engine do
  desc "Generate Swagger API documentation"
  task :generate_swagger => :environment do
    require 'rswag/specs/swagger_formatter'
    
    puts "Generating Swagger documentation..."
    
    # Path to swagger files
    swagger_root = File.join(DateApiEngine::Engine.root, 'swagger')
    swagger_file = File.join(swagger_root, 'v1', 'swagger.yaml')
    
    # Create directory if it doesn't exist
    FileUtils.mkdir_p(File.dirname(swagger_file))
    
    # Initialize basic swagger structure if file doesn't exist
    unless File.exist?(swagger_file)
      basic_swagger = {
        swagger: '2.0',
        info: {
          title: 'Date API Engine',
          version: DateApiEngine::VERSION,
          description: 'A mountable Rails engine that provides a RESTful API for date information'
        },
        paths: {
          '/api/v1/date': {
            get: {
              summary: 'Get current date',
              parameters: [
                {
                  in: 'query',
                  name: 'format',
                  type: 'string',
                  description: 'Format of the date string',
                  required: false
                },
                {
                  in: 'query',
                  name: 'timezone',
                  type: 'string',
                  description: 'Timezone for the date',
                  required: false
                }
              ],
              responses: {
                200: {
                  description: 'Success',
                  schema: {
                    type: 'object',
                    properties: {
                      date: {
                        type: 'string',
                        example: '2023-03-16T12:34:56Z'
                      },
                      format: {
                        type: 'string',
                        example: 'iso8601'
                      },
                      timezone: {
                        type: 'string',
                        example: 'UTC'
                      }
                    }
                  }
                },
                400: {
                  description: 'Bad Request',
                  schema: {
                    type: 'object',
                    properties: {
                      error: {
                        type: 'string'
                      }
                    }
                  }
                },
                500: {
                  description: 'Internal Server Error',
                  schema: {
                    type: 'object',
                    properties: {
                      error: {
                        type: 'string'
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      
      File.open(swagger_file, 'w') { |f| f.write(basic_swagger.to_yaml) }
      puts "Created basic Swagger file at: #{swagger_file}"
    else
      puts "Swagger file already exists at: #{swagger_file}"
    end
    
    puts "Swagger documentation generation complete."
  end
  
  desc "Install migrations from DateApiEngine"
  task :install_migrations => :environment do
    # No database migrations in this engine, but keeping the task for consistency
    puts "No migrations to install for DateApiEngine."
  end
  
  desc "Setup test environment for DateApiEngine"
  task :setup_test_env => :environment do
    puts "Setting up test environment for DateApiEngine..."
    
    # Setup RSpec if available
    if defined?(RSpec)
      require 'rspec/core/rake_task'
      
      RSpec::Core::RakeTask.new(:spec) do |t|
        t.pattern = File.join(DateApiEngine::Engine.root, 'spec', '**', '*_spec.rb')
      end
      
      puts "RSpec tasks set up successfully."
    else
      puts "RSpec not available, skipping spec task setup."
    end
    
    puts "Test environment setup complete."
  end
end