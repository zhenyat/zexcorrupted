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
#  03.06.2022 ZT
################################################################################
class Candlestick < ApplicationRecord
  belongs_to :dotcom, required: true
  belongs_to :pair, required: true

  has_many :candles
  
  enum slot:   %w(1m 3m 5m 15m 30m 1h 2h 4h 6h 8h 12h 1d 3d 1w 1M)
  enum status: %w(active archived)

  validates :dotcom, presence: true
  validates :pair,  uniqueness: { scope: :slot }
end
