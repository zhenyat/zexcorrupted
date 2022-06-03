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
    # Selects instances from DDDLs
    def selected_from_dddl
      @dotcom  = Dotcom.find_by(id: params[:dotcom].presence)  # object.present? ? object : nil, 
      @api     = Api.find_by(id: params[:api].presence)
      @call    = Call.find_by(id: params[:call].presence)
      @pair    = Pair.find_by(id: params[:pair].presence)
    end
end