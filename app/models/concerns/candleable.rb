################################################################################
#   Handles Dotcoms candles via ActiveRecord::DelegatedType
################################################################################
module Candleable
  extend ActiveSupport::Concern

  included do
    has_one :candle, as: :candleable, touch: true, dependent: :destroy

    def average
      (candle.high + candle.low + candle.close) / 3
    end
    
    def body
      (candle.close - candle.open).abs
    end
    
    def color
      (candle.open >= candle.close) ? 'red' : 'green'
    end
  end
end
