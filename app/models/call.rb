################################################################################
# Model:  Call
#
# Purpose: API calls for a definite Dotcom
#
# Call attributes:
#   api_id    - FK
#   name      - call name:           string,  not NULL, unique
#   title     - call title:          string,  not NULL
#   link      - link to description: string
#   status    - enum { active (0) | archived (1) }
#
#   content   - Active Text attachement
#
#  03.06.2022 ZT
################################################################################
class Call < ApplicationRecord
  has_rich_text :content
  belongs_to :api, required: true

  enum status: %w(active archived)

  validates :api,   presence: true
  validates :name,  presence: true, uniqueness: true
  validates :title, presence: true
end
