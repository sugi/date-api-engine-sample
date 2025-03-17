# frozen_string_literal: true

require 'tzinfo'
require 'active_support/core_ext/time'

module DateApiEngine
  class DateFormatter
    attr_reader :format, :timezone
    
    def initialize(format = nil, timezone = nil)
      @format = format || DateApiEngine.configuration.default_format
      @timezone = timezone || DateApiEngine.configuration.default_timezone
      
      validate!
    end
    
    def format
      time_in_zone = Time.now.in_time_zone(@timezone)
      
      case @format
      when "iso8601"
        time_in_zone.iso8601
      when "rfc3339"
        time_in_zone.rfc3339
      when "rfc2822"
        time_in_zone.rfc2822
      when "long"
        time_in_zone.to_s(:long)
      when "short"
        time_in_zone.to_s(:short)
      when "db"
        time_in_zone.to_s(:db)
      else
        time_in_zone.iso8601
      end
    end
    
    def valid?
      valid_format?(@format) && valid_timezone?(@timezone)
    end
    
    def valid_format?(format)
      DateApiEngine.configuration.supported_formats.include?(format)
    end
    
    def valid_timezone?(timezone)
      ActiveSupport::TimeZone.all.map(&:name).include?(timezone)
    end
    
    private
    
    def validate!
      unless valid_format?(@format)
        raise ArgumentError, "Invalid format: #{@format}. Supported formats: #{DateApiEngine.configuration.supported_formats.join(', ')}"
      end
      
      unless valid_timezone?(@timezone)
        raise ArgumentError, "Invalid timezone: #{@timezone}"
      end
    end
  end
end