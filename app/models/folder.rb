# frozen_string_literal: true

class Folder < ApplicationRecord
  has_ancestry

  # constants
  FOLDER_TYPES = ["campaign", "content_image", "content_template", "list"]

  # associations
  has_many :content_images, dependent: :destroy
  belongs_to :account

  # validations
  validates :name, presence: true, length: { maximum: 36 }
  
  # serialize attr
  serialize :editor_ids
  serialize :owner_ids

  # scops
  scope :non_permission_folders, -> { where.not('editor_ids IS NULL OR editor_ids = ? ',  "") }
  scope :campaign_folders, -> { where(folder_type: 'campaign') }
  scope :content_folders, -> { where(folder_type: 'content') }
  scope :content_image_folders, -> { where(folder_type: 'content_image') }
  scope :content_template_folders, -> { where(folder_type: 'content_template') }
  scope :sorted, -> { order('created_at DESC') }

  # attrs
  attr_accessor :privacy, :object_class, :folder_depth

  # callbacks
  before_save do
    if self.folder_type.present?
      if self.privacy == true
        self.editor_ids = editor_ids.map(&:to_i).uniq if editor_ids.present?
        self.owner_ids = owner_ids.map(&:to_i).uniq if owner_ids.present?
      end
    else
      self.folder_type = nil
    end
  end

  after_save :update_folder_permissions
  before_destroy :check_for_root_folder
  before_update :check_root_folder_name

  # class methods
  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      {:name => node.name, :id => node.id, :children => Folder.json_tree(sub_nodes).compact}
    end
  end

  def self.folder_with_associate_data(account, folder_id, modal_class)
    data = modal_class.where(account_id: account.id, folder_id: folder_id)
    modal_scope = (modal_class.name.underscore + "_folders").to_sym
    folders = account.folders.method(modal_scope).call
    return [folders, data]
  end
 
  # object methods
  def folder_list_data(modal_class)
    modal_scope = (modal_class.name.underscore + "_folders").to_sym
    if modal_class.name.underscore == 'content_image'
      root? ? account.folders.method(modal_scope).call.roots.sorted : parent.children.sorted
    else
      account.folders.method(modal_scope).call
    end
  end

  def folder_owner?(user_id, owner_id)
    if owner_ids.present? && owner_id != user_id
      owner_ids.include?(user_id)
    elsif owner_id == user_id
      return true
    else
      return true
    end
  end

  def read_only_folder?(user_id, email, owner_id)
    if email.present?
      return false
    elsif (owner_ids.present? && owner_id != user_id) && editor_ids.present?
      !editor_ids.include?(user_id)
    else
      return false
    end
  end

  def update_folder_permissions
    if folder_type.present? && descendants.present? && privacy == true
      descendants.each do |child|
        if editor_access.present? && owner_access.present?
          child.update_attributes(owner_ids: owner_ids, editor_ids: editor_ids)
        elsif owner_access.present?
          child.update_attributes(owner_ids: owner_ids)
        elsif editor_access.present?
          child.update_attributes(editor_ids: editor_ids)
        end
      end
    end
  end

  private
  def check_for_root_folder
    if self.id == self.account.folders.take.try(:id)
      errors.add(:base, "You can not delete the root folder...!")
      throw :abort
    end  
  end

  def check_root_folder_name
    if self.id == self.account.folders.take.try(:id)
      errors.add(:base, "You can not edit root folder...!")
      throw :abort
    end  
  end
end
