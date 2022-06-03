class DemoController < ApplicationController
  include Request
  before_action :select_dotcom_api_call, only: :api_calls

  def index
  end

  # NB!  demo calls are public calls
  def api_calls
    @dotcoms  = Dotcom.active
    @apis = @dotcom&.apis || []     # ActiveRecord::Associations::CollectionProxy of Apis
    if not @api.nil? and @api.mode == 'demo_api'
      api = Api.find_by dotcom: @dotcom, mode: 'public_api'
      @calls = api.calls
    else
      @calls  = @api&.calls || []   # ActiveRecord::Associations::CollectionProxy of ApiMethods
    end

    request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call)
    @response = request.send
  end

  def candlesticks
  end
end
