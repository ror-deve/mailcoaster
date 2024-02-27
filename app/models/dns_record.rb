class DnsRecord < ApplicationRecord
  belongs_to :domain
  has_one :dkim_setting, dependent: :destroy
    
  enum :record_type, { txt: 0, cname: 1, mx: 2 }

  validates :record_type, presence: true
  validates :hostname, presence: true
  validates :value, presence: true

end
