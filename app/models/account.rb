# frozen_string_literal: true

class Account < ApplicationRecord
  # constants
  TYPE_OPTIONS = %w(dedicated shared hybrid)
  ACCOUNT_SUBSCRIPTION = %w(monthly yearly)

  # associations
  has_many :folders,              dependent: :destroy
  has_many :invitations,          dependent: :destroy
  has_many :users,                through: :invitations
  has_many :campaigns,            dependent: :destroy
  has_many :contents,             dependent: :destroy
  has_many :content_histories,    dependent: :destroy
  has_many :content_images,       dependent: :destroy
  has_many :content_templates,    dependent: :destroy

  has_many :campaign_opens
  has_many :campaign_clicks
  has_many :campaign_sends
  has_many :campaign_bounces
  has_many :campaign_unsubscribes
  has_many :lists,                dependent: :destroy
  has_many :contacts,             dependent: :destroy
  has_many :list_subscriptions,   dependent: :destroy
  has_many :domains,              dependent: :destroy
  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'

  # callbacks
  after_save do
    # NOTE: this needs to be in a global cache as it will be used by different processes and there is no way of knowing when account has changed.
    Rails.cache.write("cached_account_#{self.id}", self, expires_in: 12.hours)
  end
  
  # class methods
  def self.from_cache account_id
    account = Rails.cache.fetch("cached_account_#{account_id}", expires_in: 12.hours) { Account.find_by(id: account_id) }
    if account.nil?
      raise "Account with id #{account_id} doesn't exist"
    else
      return account
    end
  end
end
