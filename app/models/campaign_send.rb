class CampaignSend < ApplicationRecord
  belongs_to :campaign
  belongs_to :account

  validates :campaign_id,         presence: true, unless: proc { transactional == true }
  validates :contact_id,          presence: true
end
