################################################################################
# Model:  Coin
#
# Coin attributes:
#   name      - string,  not NULL, unique
#   code      - string
#   kind      - enum { crypto (0) | fiat (1) }
#   unicode   - string
#   status    - enum { active (0) | archived (1) }
#
#   avatar    - ActiveStorage image
#
#   23.05.2022 ZT
################################################################################
class Coin < ApplicationRecord
  include Avatarable
  
  has_many :coin_nicknames, dependent: :destroy
  has_many :based_pairs,  class_name: 'Pair', foreign_key: 'base_id',  dependent: :destroy
  has_many :quoted_pairs, class_name: 'Pair', foreign_key: 'quote_id', dependent: :destroy
  
  enum kind:   %w(crypto fiat)
  enum status: %w(active archived)
  
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
