# frozen_string_literal: true

class Content < ApplicationRecord
  # associations
  belongs_to :account
  # belongs_to :footer // will generate footer model then uncomment this
  has_many :content_history
  has_many :campaigns
  validates :name, presence: true, uniqueness: { scope: :account_id, message: "must be unique." }

  #pagination
  self.per_page = 5
end
