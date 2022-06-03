################################################################################
# Model:  Api
#
# Purpose:
#
# Purpose:  Dotcoms' APIs
#
# Api attributes:
#   dotcom_id   - FK
#   mode        - API mode: enum { demo_api (0) | public_api (1) | private_api (2) }
#   path        - path added to endpoint
#   key         - string
#   secret      - string
#   user        - string
#   status      - enum { active (0) | archived (1) }
#
#  02.06.2022 ZT
################################################################################
class Api < ApplicationRecord
  belongs_to :dotcom, required: true
  has_many   :calls, dependent: :destroy

  enum mode:   %w(demo_api public_api private_api)
  enum status: %w(active archived)

  def endpoint
    self.base_url + self.path
  end

  def show_secret
    get_secret
  end

  private
    def get_secret
      Rails.application.credentials.config[self.dotcom.name.to_sym][self.mode.to_sym][:secret]
    end
end
