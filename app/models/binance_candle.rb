################################################################################
# Model:  BinanceCandle
#
# Purpose: Candle with specific Binance attributes
#
# BinanceCandle attributes:
#   quote_volume        - decimal
#   trades              - integer
#   taker_base_volume   - decimal
#   taker_quote_volume  - decimal
#    
#  14.06.2022 ZT
################################################################################
class BinanceCandle < ApplicationRecord
  include Candleable
end
