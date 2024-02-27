class CampaignOpen < ApplicationRecord
  belongs_to :campaign
  belongs_to :account

  scope :unique, -> { select(:contact_id).uniq }

  validates :campaign_id, presence: true
  validates :contact_id, presence: true
end
