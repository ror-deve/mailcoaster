# frozen_string_literal: true

class ContentImage < ApplicationRecord
  # associations
  belongs_to :account
  belongs_to :folder, optional: true

  # active storage
  has_one_attached :image

  # validations
  validates :image, presence: true

  # scopes
  scope :sorted, -> { order('created_at DESC') }
  scope :without_folder, -> { where(folder_id: nil) }
  scope :with_folder, -> (folder_id) { where(folder_id: folder_id) }
  
  # accessors
  attr_accessor :folder_depth

end
