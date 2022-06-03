################################################################################
# Model:  CoinNickname
#
# CoinNickname attributes:
#   coin_id   - FK
#   name      - string,  not NULL, unique
#   status    - enum { active (0) | archived (1) }
#
#  03.06.2022 ZT
################################################################################
class CoinNickname < ApplicationRecord
  belongs_to :coin, required: true

  enum status: %w(active archived)

  validates :coin, presence: true
  validates :name, presence: true, uniqueness: true
end
