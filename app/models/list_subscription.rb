class ListSubscription < ApplicationRecord
  STATUSES = ['Ok', 'Soft-Bounced', 'Hard-Bounced', 'Complained', 'Cleansed', 'Workflow']

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :unsubscribed, -> { where(active: false, status: 0) }
  scope :hard_bounced, -> { where(status: 2, active: false) }
  scope :soft_bounced, -> { where(status: 1, active: false) }
  scope :complained, -> { where(status: 3, active: false) }
  scope :cleansed, -> { where(status: 4, active: false) }

  validates :contact_id, presence: true
  validates :account_id, :presence => true
  validates :list_id, presence: true
end
