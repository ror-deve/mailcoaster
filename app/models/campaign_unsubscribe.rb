class CampaignUnsubscribe < ApplicationRecord
  REASONS = %w(A B W I S C T)

  belongs_to :account
  belongs_to :campaign
  belongs_to :list

  validates :list_id, presence: true, unless: proc { transactional == true }
  validates :account_id, presence: true
  validates :contact_id, presence: true
  validates :reason, presence: true, inclusion: { in: REASONS }
end
