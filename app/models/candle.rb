################################################################################
# Model:  Candle
#
# Purpose:  Candlestick's Candle with DelegatedType of Dotcoms' candles
#
# Candle attributes:
#   candlestick     - Foreign key
#   candleable_id   - FK
#   candleable_type
#   start_stamp     - Candle's initial timestamp: integer
#   open            - Open price:                 decimal
#   high            - Highest price:              decimal
#   low             - Lowest price:               decimal
#   close           - Closing price               decimal
#   volume          - Total volume(?):            decimal
#
#  14.06.2022 ZT
################################################################################
class Candle < ApplicationRecord
  belongs_to :candlestick, required: true

  delegated_type :candleable, types: Rails.application.config.candle_types
# delegated_type :candleable, types: %w[ Binance Cexio ] # instead of piolymorphic

  validates :candlestick, presence: true
  validates :candleable,  presence: true

  # Use :to_global_id to populate the form if needed
  def candleable_gid
    candleable&.to_global_id
  end

  # Set the :candleable from a Global ID (handles the form submission)
  def candleable_gid=(gid)
    self.candleable = GlobalID::Locator.locate gid
  end
end
