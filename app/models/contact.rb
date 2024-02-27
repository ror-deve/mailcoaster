class Contact < ApplicationRecord
  validates :account_id, presence: true
  validates :email, presence: true, format: { with: /\A[a-zA-Z0-9\'_\-\.=%+]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
end
