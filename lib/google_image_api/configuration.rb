require 'singleton'

module GoogleImageApi
  class Configuration
    include Singleton

    attr_accessor :proxies, :user_agent

    def proxy= new_proxy
      self.proxies = [new_proxy]
    end
  end
end
