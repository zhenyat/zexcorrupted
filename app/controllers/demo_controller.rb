class DemoController < ApplicationController
  include RequestPro
  before_action :find_dotocom_api_method, only: :public_api
  def index
  end

  def public_api
    @dotcoms  = Dotcom.active
    @apis = @dotcom&.apis || []               # ActiveRecord::Associations::CollectionProxy of Apis
    if not @api.nil? and @api.mode == 'demo_api'
      api = Api.find_by dotcom: @dotcom, mode: 'public_api'
      @api_methods = api.api_methods
    else
      @api_methods  = @api&.api_methods || []   # ActiveRecord::Associations::CollectionProxy of ApiMethods
    end
  end

  def candlesticks
  end

  # private
    # def find_dotocom_api_method
    #   @dotcom      = Dotcom.find_by(id: params[:dotcom].presence)  # object.present? ? object : nil, 
    #   @api         = Api.find_by(id: params[:api].presence)
    #   @api_method  = ApiMethod.find_by(id: params[:api_method].presence)
    # end
end
