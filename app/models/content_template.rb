# frozen_string_literal: true

class ContentTemplate < ApplicationRecord
  # associations
  belongs_to :account

  # validations
  validates :name, presence: true, uniqueness: { scope: :account_id, message: "must be unique within the account." }
  validates :tag_name, uniqueness: { scope: :account_id }, format: { with: /\A[0-9a-z_]+\z/ }, if: -> { tag_name.present? }
  validates :account_id, presence: true

  # callbacks
  before_validation do
    self.name = name.strip if name.present?
  end

#pagination
  self.per_page = 5
  
  # before_save do
  #   self.editor_ids = editor_ids.map(&:to_i) if editor_ids
  #   content = Content.new(html_part: self.html_part)
  #   # self.html_part = content.escape_special_chars_in_liquid
  # end

  # after_save :replace_urls
  
  # serializers
  serialize :editor_ids
  
  # accessors 
  attr_accessor :read_only

  # validate do
  #   begin
  #     Liquid::Template.parse(html_part)
  #   rescue Exception => e
  #     errors.add(:html_part, e.message)
  #   end
  # end

  # def replace_urls
  #   content = Content.new
  #   content.account_id = account_id
  #   content.html_part = html_part
  #   update_column(:html_part, content.default_replace_urls)
  # end


  # class methods
  def self.get_templates_hash(account_id)
    ContentTemplate.where(account_id: account_id).where('tag_name is not null').pluck(:tag_name, :html_part).to_h
  end

  # object methods
  def is_read_only?(user_id)
    !editor_ids.include?(user_id)
  end

  def is_owner?(user_id)
    owner_id == user_id || account.try(:owner_id) == user_id
  end

  def editor_ids
    if self[:editor_ids].class != Array
      return [owner_id, account.try(:owner_id)]
    else
      return self[:editor_ids] + [owner_id, account.try(:owner_id)]
    end
  end

end
