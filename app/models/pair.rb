################################################################################
# Model:  Pair
#
# Pair attributes:
#   base_id         - FK
#   quote_id        - FK
#   code            - string,  not NULL, unique
#   level           - Liquidity Level: enum { Major (0) | Minor (1) | Exotic (2)}
#   decimal_places  - integer
#   min_price       - decimal
#   max_price       - decimal
#   min_amount      - decimal
#   hidden          - boolean, default: false
#   fee             - decimal
#   status          - enum { active (0) | archived (1) }
#
#  03.06.2022 ZT
################################################################################
class Pair < ApplicationRecord  
  belongs_to :base,  class_name: 'Coin'
  belongs_to :quote, class_name: 'Coin'

  has_many :pair_nicknames, dependent: :destroy

  # has_many   :trades

  enum level:  %w(Major Minor Exotic)
  enum status: %w(active archived)

  validates :base,  presence: true
  validates :quote, presence: true, comparison: {other_than: :base, message: "must differ from the Base"} 
  validates :code,  presence: true, uniqueness: true

  def name
    "#{base.code.downcase}_#{quote.code.downcase}"
  end

  def base_ordered
    base.order(:code)
  end
end
