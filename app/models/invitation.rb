# frozen_string_literal: true

class Invitation < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :account

  validates :email,         presence: true
  validates :user_id,       presence: true, exclusion: { in: proc { |i| [i.account.owner_id] } }
  validates :account_id,    presence: true, uniqueness: { scope: :user_id, unless: proc { user_id == 0 } }

  # callbacks
  before_validation do
    self.email = user.email if user
  end

  # serializers
  serialize :roles

end
