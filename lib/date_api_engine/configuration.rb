# frozen_string_literal: true

module DateApiEngine
  class Configuration
    attr_accessor :default_format, :default_timezone
    
    def initialize
      @default_format = "iso8601"
      @default_timezone = "UTC"
    end
    
    def supported_formats
      [
        "iso8601",       # 2023-03-16T12:34:56Z
        "rfc3339",       # 2023-03-16T12:34:56+00:00
        "rfc2822",       # Thu, 16 Mar 2023 12:34:56 +0000
        "long",          # March 16, 2023 12:34:56 +0000
        "short",         # 16 Mar 12:34
        "db"             # 2023-03-16 12:34:56
      ]
    end
    
    def supported_timezones
      ActiveSupport::TimeZone.all.map(&:name)
    end
  end
end