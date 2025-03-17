# date_api_engine/example/config/initializers/date_api_engine.rb

# Configure the Date API Engine
DateApiEngine.configure do |config|
  # Set the default date format
  # Available options: 'iso8601', 'rfc3339', 'rfc2822', 'long', 'short', 'db'
  config.default_format = 'iso8601'
  
  # Set the default timezone
  # Any valid ActiveSupport::TimeZone name can be used
  config.default_timezone = 'UTC'
  
  # You can add additional configuration options as needed
end