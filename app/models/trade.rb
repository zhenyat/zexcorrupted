################################################################################
# Model:  Trade
#
# Purpose:  Trades collected from Dotcom
#
# Run attributes:
#   dotcom     - Foreign key
#   pair       - Foreign key
#   kind       - Trade type                     enum {sell (0)| buy (1)}
#   price      - Price to be bought / sold at   decimal
#   amount     - Amount to be bought / sold     decimal
#   tid        - WEX Trade ID                   integer
#   timestamp  - Trade timestamp                integer
#      
#   04.06.2022  ZT
################################################################################
class Trade < ApplicationRecord
  belongs_to :dotcom, required: true
  belongs_to :pair,   required: true
  
  enum kind: %w(sell buy)

  validates :dotcom, presence: true
  validates :pair,   presence: true

#  where(id: ARRAY_CANDLESTICK.map(&:id))
# => MyModel.where(id: arr.map(&:id))
end
