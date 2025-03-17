# Date API Engine

A mountable Rails engine that provides a RESTful API for date information. This engine is designed 
to be easily integrated into any Rails 7.1.x application.

## Features

- RESTful API endpoint to return the current date as a string
- Support for various date formats (ISO8601, RFC3339, RFC2822, etc.)
- Support for different timezones
- API documentation using rswag
- Request validation using committee gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'date_api_engine'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install date_api_engine
```

## Mounting the Engine

In your Rails application's `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  mount DateApiEngine::Engine, at: '/'
  # Rest of your routes...
end
```

## Configuration

Create an initializer in your host app to configure the engine:

```ruby
# config/initializers/date_api_engine.rb

DateApiEngine.configure do |config|
  # Set the default date format
  config.default_format = 'iso8601' # Default: 'iso8601'
  
  # Set the default timezone
  config.default_timezone = 'UTC' # Default: 'UTC'
end
```

## API Usage

### Get Current Date

```
GET /api/v1/date
```

Query Parameters:
- `format` (optional) - The format of date string. Supported values: 'iso8601', 'rfc3339', 'rfc2822', 'long', 'short', 'db'
- `timezone` (optional) - The timezone for the date. Any valid ActiveSupport::TimeZone name.

Example Response:

```json
{
  "date": "2023-03-16T12:34:56Z",
  "format": "iso8601",
  "timezone": "UTC"
}
```

## API Documentation

API documentation is available using Swagger UI at `/api-docs` when the engine is mounted.

## Development

To run the test suite:

```bash
$ bundle exec rake spec
```

To generate Swagger documentation:

```bash
$ bundle exec rake date_api_engine:generate_swagger
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
