class DemoController < ApplicationController
  include Request
  before_action :selected_from_dddl, only: [:api_calls, :candlesticks]

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
    @pairs   = Pair.active.order(:status).order(:code)

    if @pair.present?
      if @dotcom.present? and @dotcom.name == 'binance'
        @api = Api.find_by dotcom: @dotcom, mode: 'demo_api'
        @call = Call.find_by name: 'klines'
        options = {symbol: @pair.code.sub('/', ''), interval: '1h', limit: 50}
        request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, options: options)
        @klines = request.send

      elsif  @dotcom.present? and @dotcom.name == 'cexio'
        @api = Api.find_by dotcom: @dotcom, mode: 'demo_api'
        @call = Call.find_by name: 'ohlcv'
        extension = "hd/#{(Time.now-1.day).strftime("%Y%m%d")}/#{@pair.code}"
        request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, extension: extension)
        ohlcv = request.send
        if ohlcv.present?
          strings_array = ohlcv["data1h"].gsub('],[', ';').gsub('[','').gsub(']','').split(';')
          @candles = []
          strings_array.each do |s|
            @candles << s.split(',')
          end
        end

      else
        # Do nothing now...
      end
    end
  end

  def trades
    @pair   = Pair.active.find_by   code: 'BTC/USDT'
    @dotcom = Dotcom.active.find_by name: 'binance'
    @api    = @dotcom.apis.find_by   mode: 'demo_api'
    @call   = demo_calls(@dotcom).find_by name: 'trades'

    options = { symbol: @pair.symbol(dotcom_name: @dotcom.name), limit: 50 }
    request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, options: options)
    @trades  = request.send
    
  end
end
