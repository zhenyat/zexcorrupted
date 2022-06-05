class DemoController < ApplicationController
  include Request
  before_action :selected_from_dddl, only: [:api_calls, :candlesticks, :trades]

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
    @dotcoms = Dotcom.active
    @pairs   = @dotcom.present? ? @dotcom.pairs : Pair.active.order(:status).order(:code)

    if @pair.present?
      if @dotcom.present?
        if @dotcom.name == 'binance'
          @api = Api.find_by dotcom: @dotcom, mode: 'demo_api'
          @call = Call.find_by name: 'klines'
          options = {symbol: @pair.code.sub('/', ''), interval: '1h', limit: 50}
          request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, options: options)
          response = request.send
        elsif @dotcom.name == 'cexio'
          @api = Api.find_by dotcom: @dotcom, mode: 'demo_api'
          @call = Call.find_by name: 'ohlcv'
          extension = "hd/#{(Time.now-1.day).strftime("%Y%m%d")}/#{@pair.code}"
          request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, extension: extension)
          ohlcv = request.send
          if ohlcv["data1h"].present?
            strings_array = ohlcv["data1h"].gsub('],[', ';').gsub('[','').gsub(']','').split(';')
            response = []
            strings_array.each do |s|
              response << s.split(',')
            end
          end
        else
          response = {'code': 'ZEX', 'msg': "#{@dotcom.name}} not allowed"}
        end
        # Classify the response
        if response.is_a? Hash
          @error_msg = response
          @candles = []
        else
          @candles = response
          @error_msg = {}
        end
      end
    end
  end


  def trades
    @dotcoms = Dotcom.active
    # @pairs = Pair.active.order(:status).order(:code)
    @pairs   = @dotcom.present? ? @dotcom.pairs : Pair.active.order(:status).order(:code)

    if @pair.present?
      if @dotcom.present?
        if @dotcom.name == 'binance'
          # One way
          @api = Api.find_by dotcom: @dotcom, mode: 'demo_api'
          @call = Call.find_by name: 'trades'

          # An other way - extra SELECT...
          # @api = @dotcom.apis.find_by mode: 'demo_api'
          # @call = demo_calls(@dotcom).find_by name: 'trades'

          options = { symbol: @pair.symbol(dotcom_name: @dotcom.name), limit: 50 }
          request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, options: options)
          response = request.send

        elsif @dotcom.name == 'cexio'
          @api = Api.find_by dotcom: @dotcom, mode: 'demo_api'
          @call = Call.find_by name: 'trade_history'
          extension = "#{@pair.symbol(dotcom_name: @dotcom.name)}"
          request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, extension: extension)
          response = request.send
        else
          response = {'code': 'ZEX', 'msg': "#{@dotcom.name}} not allowed"}
        end
      end
      # Classify the response
      if response.is_a? Hash
        @error_msg = response
        @trades = []
      else
        @trades = response
        @error_msg = {}
      end
    end
  end
end
