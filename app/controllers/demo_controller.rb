class DemoController < ApplicationController
  require 'csv'

  include ChartsPro
  include Request

  before_action :selected_from_dddl#, only: [:api_calls, :api_candlesticks, :api_trades]

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

  def api_candlesticks
    @dotcoms = Dotcom.active
    @pairs   = @dotcom.present? ? @dotcom.pairs.active : Pair.active.order(:code)

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
        @candles, @error_msg = request_error_check response
      end
    end
  end


  def api_trades
    @dotcoms = Dotcom.active
    # @pairs = Pair.active.order(:status).order(:code)
    @pairs   = @dotcom.present? ? @dotcom.pairs.active : Pair.active.order(:code)

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
      @trades, @error_msg = request_error_check response
    end
  end

  def chart
    @binance_data = apex_charts_data BinanceCandle.last(500)
    # @cexio_data   = apex_charts_data CexioCandle.all
  end

  def import
    @time_elapsed = []

    dotcom = Dotcom.find_by name: 'binance'
    candle_model=(dotcom.name.capitalize + 'Candle').constantize
     
    pair = Pair.find_by code: 'BTC/USDT'
    slot = '3m'
    candlestick = Candlestick.find_by dotcom: dotcom, pair: pair, slot: slot

    file = "tmp/data/Binance/BTCUSDT-3m-2022-01.csv"
    data = CSV.read(file)
    puts "======", data.count, candlestick.inspect
    t_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    data.each do  |datum|
      candle = Candle.new(
        candlestick: candlestick, 
        start_stamp: dotcom.name == 'binance' ? datum[0].to_i/1000 : datum[0].to_i,
        open:        datum[1].to_f,
        high:        datum[2].to_f,
        low:         datum[3].to_f,
        close:       datum[4].to_f,
        volume:      datum[5].to_f,
        candleable:  candle_model.new
      )
      if candle.candleable_type == 'BinanceCandle'
        candle.candleable.quote_volume = datum[7].to_f
        candle.candleable.trades = datum[8].to_i
        candle.candleable.taker_base_volume = datum[9].to_f
        candle.candleable.taker_quote_volume = datum[10].to_f
      end
      candle.save!
    end
    t_finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @time_elapsed = (t_finish - t_start).round(2)
  end
end
