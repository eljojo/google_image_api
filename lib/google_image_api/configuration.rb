require 'singleton'

module GoogleImageApi
  class Configuration
    include Singleton

    attr_accessor :user_agent
  end
end
