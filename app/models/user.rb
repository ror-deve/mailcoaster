# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # accessors
  attr_accessor :current_account, :login

  # associations
  has_many :invitations, dependent: :destroy
  has_many :accounts, through: :invitations
  has_many :owner_accounts, foreign_key: :owner_id, class_name: 'Account'

  has_one_attached :avatar
  
  # validations
  validates_uniqueness_of :username
  after_initialize :set_default_role, :if => :new_record?

  # user roles
  enum role: [:user, :admin]
  serialize :widgets, Array

  # scopes
  scope :all_except, ->(user) { where.not(id: user) }

  # class methods
  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username) = :value OR lower(email) = :value",
      { value: login.strip.downcase}]).first
  end

  def self.get_account_users account_id
    Account.find(account_id).users.order("email ASC")
  end

  # object methods
  def set_default_role
    self.role ||= :user
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def all_accounts
    @all_my_accounts ||= Account.where('id in (?)', all_account_ids).order('name ASC')
  end

  def all_account_ids
    @all_my_account_ids ||= [owner_account_ids, account_ids].flatten
  end

end
