class CandlesticksController < ApplicationController
  include Request
  before_action :selected_from_dddl#, only: [:add_candles, :slots, ]

  def slots
    @slots   = Candlestick.slots
  end

  def index
    @dotcoms = Dotcom.active
    @pairs   = @dotcom.present? ? @dotcom.pairs.active : Pair.active.order(:status).order(:code)
    @slots   = Candlestick.slots
   
    if @dotcom.present? and @pair.present? and @slot.present?
      @api = Api.find_by dotcom: @dotcom, mode: 'public_api'

      case @dotcom.name
      when 'binance'
        @call = Call.find_by name: 'klines'
        interval = @slots.key(@slot)  # @slot is a hash element value
        options = {symbol: @pair.code.sub('/', ''), interval: interval, limit: 50}
        request = GetRequest.new(dotcom: @dotcom, api: @api, call: @call, options: options)
        response = request.send
  
      when 'cexio'
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
        response = {'code': 'ZEX', 'msg': "#{@dotcom.name}} is not allowed"}
      end 
      @data, @error_msg = request_error_check response

      # Get or create Candlestick
      if @error_msg.blank?
        @candlestick = Candlestick.find_by dotcom: @dotcom, pair: @pair, slot: @slot
        if @candlestick.nil?
          @candlestick = Candlestick.create dotcom: @dotcom, pair: @pair, slot: @slot
        end

        if @data.present?
          candle_model=(@dotcom.name.capitalize + 'Candle').constantize 
          @data.each do |datum|
            candle = Candle.new(
              candlestick: @candlestick, 
              start_stamp: @dotcom.name == 'binance' ? datum[0]/1000 : datum[0].to_i,
              open:        datum[1],
              high:        datum[2],
              low:         datum[3],
              close:       datum[4],
              volume:      datum[5],
              candleable:  candle_model.new
            )
            if candle.candleable_type == 'BinanceCandle'
              candle.candleable.quote_volume = datum[7]
              candle.candleable.trades = datum[8]
              candle.candleable.taker_base_volume = datum[9]
              candle.candleable.taker_quote_volume = datum[10]
            end
            candle.save!
          end
        end
      end
    end
  end
end
