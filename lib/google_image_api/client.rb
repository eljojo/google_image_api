module GoogleImageApi
  class Client
    BASE_URL = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0"

    def initialize
    end

    def find( query, options = {} )
      query = Url.new(query).title rescue query
      Result.new( request_image( query, options ) )
    end

    def request( options )
      require 'open-uri'
      URI.parse( url_for( options ) ).read( "User-Agent" => config_options.user_agent )
    end

    def request_image( query, options = {} )
      request({:q => query}.merge( options ) )
    end

    protected
      def config_options
        Configuration.instance
      end

      def url_for( options = {} )
        url = BASE_URL.dup
        options.each do |key, val|
          value = urlify_value( val )
          if url.include?( ":#{key}" )
            url.sub! ":#{key}", value
          else
            url << "&#{key}=#{value}"
          end
        end
        url
      end

      def urlify_value( val )
        case val
        when Array
          encode( val.flatten.join( '|' ) )
        else
          encode( val )
        end
      end

      def encode( val )
        case val
        when String
          URI.encode( val ).gsub( '&', '%26' )
        else
          val
        end
      end
  end
end
