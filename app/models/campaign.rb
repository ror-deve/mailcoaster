# frozen_string_literal: true

class Campaign < ApplicationRecord
  # associations
  belongs_to :account
  # belongs_to :content_history, dependent: :delete, validate: false
  belongs_to :content, validate: false
  has_many :campaign_opens
  has_many :campaign_clicks
  has_many :campaign_sends
  has_many :campaign_bounces,       dependent: :delete_all
  has_many :campaign_unsubscribes,  dependent: :delete_all
  # attributes
  attr_accessor :save_and_next
end
