################################################################################
# Model:  Candlestick
#
# Purpose: Candles collection
#
# Candlestick attributes:
#   dotcom_id   - FK
#   pair_id     - FK
#   slot        - candles slot:
#                 enum {1m|3m|5m|15m|30m|1h|2h|4h|6h|8h|12h|1d|3d|1w|1M}
#   status      - enum { active (0) | archived (1) }
#
#  05.06.2022 ZT
################################################################################
class Candlestick < ApplicationRecord
  belongs_to :dotcom, required: true
  belongs_to :pair, required: true

  has_many :candles
  
  enum slot:   %w(1m 3m 5m 15m 30m 1h 2h 4h 6h 8h 12h 1d 3d 1w 1M)
  enum status: %w(active archived)

  validates :dotcom, presence: true
  validates :pair,   uniqueness: { scope: :slot }

  # Candle interval in seconds
  def interval slot 
    unit = slot.last
    case unit
    when 'm'
      slot.chop.to_i * 60
    when 'h'
      slot.chop.to_i * 3600
    when 'd'
      slot.chop.to_i * 3600 * 24
    when 'w'
      slot.chop.to_i * 3600 * 24 * 7
    else  # 1 Month
      slot.chop.to_i * 3600 * 24 * 7 * 4
    end
  end
end
