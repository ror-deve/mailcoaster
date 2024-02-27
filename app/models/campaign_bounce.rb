class CampaignBounce < ApplicationRecord
  belongs_to :campaign
  belongs_to :account

  scope :unique,        -> { select(:contact_id).uniq }
  scope :soft,          -> { where(hard_bounce: false) }
  scope :soft_unique,   -> { where(hard_bounce: false).select(:contact_id).uniq }
  scope :hard,          -> { where(hard_bounce: true) }
  scope :hard_unique,   -> { where(hard_bounce: true).select(:contact_id).uniq }
  scope :blocks,        -> { where(blocked: true) }

  validates :campaign_id, presence: true
  validates :contact_id, presence: true
  validates :smtp_error, presence: true
end
