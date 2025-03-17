# frozen_string_literal: true

require "date_api_engine/version"
require "date_api_engine/engine"
require "date_api_engine/configuration"

module DateApiEngine
  class << self
    attr_writer :configuration
    
    def configuration
      @configuration ||= Configuration.new
    end
    
    def configure
      yield(configuration)
    end
    
    def reset
      @configuration = Configuration.new
    end
  end
end