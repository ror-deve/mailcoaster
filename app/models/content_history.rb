# frozen_string_literal: true

class ContentHistory < ApplicationRecord
  # associations
  # has_one :campaign
  belongs_to :content
  belongs_to :account
  belongs_to :footer

  # validations
  validates :name, presence: true
end
