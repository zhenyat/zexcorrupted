module Request
  extend ActiveSupport::Concern

  class  Request
    def initialize dotcom:, api:, call:, extension: nil, options: {}
      @dotcom    = dotcom
      @api       = api
      @call      = call
      @extension = extension
      @options   = options
    end

    def dotcom
      @dotcom.presence
    end

    def api
      @api.presence
    end

    def extension
      @extension.presence
    end

    def call
      @call.presence
    end

    def options
      @options.presence
    end
  end

  class GetRequest < Request
    def send
      begin
        response = Net::HTTP.get(self.uri)
      rescue StandardError => e
        {:success => 0, :error => e}
      else
        begin 
          JSON.parse response     # => Hash
        rescue
          "HTTP.get(#{self.uri}) failed" 
        end
      end
    end

    def uri
      url = @api.endpoint + "/" + @call.name
      url << "/#{@extension}" unless @extension.nil?
      uri = URI url
      uri.query = URI.encode_www_form(options) unless options.nil?
      uri
    end
  end

  private

    ##############################################################################
    # Checks whether response is an error message aka:
    #   {"success":0, "error":"Invalid method"}
    #   {"error":"Invalid Symbols Pair"}
    #   {"code":-1102,"msg":"Mandatory parameter 'interval' was not sent, was empty/null, or malformed."}
    #
    # If error: returns empty hash, otherwise: returns response
    # 
    # caller_locations(1,1)[0].label - the calling method
    #
    #   06.06.2022
    ##############################################################################
    def request_error_check response
      if response.is_a? Hash
        error_msg = response
        error_msg[:called_by] = caller_locations(1,1)[0].label
        response = []
      else
        error_msg = {}
      end
      return response, error_msg
    end

    # Clones public_api calls to demo_api
    def demo_calls(dotcom)
      Api.find_by( dotcom: dotcom, mode: 'public_api').calls
    end

    # # Selects instances from DDDLs - obsolete? (cause of an extra SELECT)
    # def selected_from_dddl
    #   @dotcom  = Dotcom.find_by(id: params[:dotcom].presence)  # object.present? ? object : nil, 
    #   @api     = Api.find_by(id: params[:api].presence)
    #   @call    = Call.find_by(id: params[:call].presence)
    #   @pair    = Pair.find_by(id: params[:pair].presence)
    #   @slot    = Candlestick.slots[params[:slot].presence] # this is a value (0,1,2...)
    #                                                        # params[:slot] is a key: '1m', '3m',...
    # end

    # def timestamp
    #   Time.now.strftime('%Y-%m-%d %H:%M:%S')
    # end
end