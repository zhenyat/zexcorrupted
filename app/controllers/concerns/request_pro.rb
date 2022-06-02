module RequestPro
  extend ActiveSupport::Concern

  class  PublicApi
    def initialize dotcom:, method:, extension: nil, options: {}
      @dotcom     = dotcom
      @method     = method
      @extension  = extension
      @options    = options
      # raise "\nError: unavailbale method '#{@method}' for #{@dotcom.name} - pls update the YAML file" unless method_available? @method
    end

    def dotcom
      @dotcom
    end

    def method
      @method
    end

    def options
      @options
    end
  end

  class PublicApiGet < PublicApi
    # HTTP request
    def request
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
      url = @dotcom.endpoint + "/#{@method}"
      url << "/#{@extension}" unless @extension.nil?
      uri = URI url
      uri.query = URI.encode_www_form(options) unless options.empty?
      uri
    end
  end

  private
    def find_dotocom_api_method
      @dotcom      = Dotcom.find_by(id: params[:dotcom].presence)  # object.present? ? object : nil, 
      @api         = Api.find_by(id: params[:api].presence)
      @api_method  = ApiMethod.find_by(id: params[:api_method].presence)
    end
end