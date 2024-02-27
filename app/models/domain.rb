require 'dkim_generator'
require 'dns_verifier'

class Domain < ApplicationRecord
  REGEX = /\A(?!:\/\/)(?=.{1,255}$)([a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]\.)+[a-zA-Z]{2,}\z/
  MC_CUSTOM_DOMAIN_CNAME = 'cd.mailcoaster.com'

  belongs_to :account
  has_many :dns_records, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :account_id, message: "domain already exists" }
  validates :name, format: { with: REGEX, message: "invalid domain name" }

  after_create :create_dns_records
  after_update :add_dns_records

  def verify
    verifier = DnsVerifier.new
    dns_records.each do |dns_record|
      res = verifier.verify(dns_record.record_type, dns_record.hostname, dns_record.value)
      if res[:error]
        errors.add(:base, "#{dns_record.hostname}: #{res[:error]}")
      else
        dns_record.update!(verified: true)
      end
    end
    if !errors.present? && self.verified == false
      self.update!(verified: true)
    end
  end

  private

    def create_dns_records
      if self.sending_enabled
        create_dkim_dns
      end
      if self.return_path_enabled || self.branded_link_enabled
        create_cname_dns
      end
    end

    def add_dns_records
      # only handle the case when we need to add additional record
      # we don't need to remove any record for now
      if saved_change_to_attribute?(:sending_enabled) && sending_enabled && no_dkim_record_exists
        create_dkim_dns
      end

      if need_cname_record
        create_cname_dns
      end
    end

    def need_cname_record
      (saved_change_to_attribute?(:return_path_enabled) || saved_change_to_attribute?(:branded_link_enabled)) && (
          return_path_enabled || branded_link_enabled ) && no_cname_record_exists
    end

    def create_cname_dns
      DnsRecord.create!({
        domain_id: self.id,
        record_type: :cname,
        hostname: self.name,
        value: MC_CUSTOM_DOMAIN_CNAME
      })
    end

    def create_dkim_dns
      generator = DKIMGenerator.new
      generator.generate

      dkim_dns_record = DnsRecord.create!({
        domain_id: self.id,
        record_type: :txt,
        hostname: 'mc1._domainkey.' + self.name,
        value: generator.dns_value
      })

      dkim_path = save_dkim_key(generator.private_key)
      
      DkimSetting.create!({
        account_id: self.account_id,
        dns_record_id: dkim_dns_record.id,
        domain: self.name,
        selector: "mc1",
        canonicalization: 'relaxed/relaxed',
        private_key_path: dkim_path,
        expires_at: 5.years.from_now # TODO: until we have an automated system to rotate these keys
      })
    end

    def save_dkim_key(key)
      path = "#{self.account_id}/dkim/#{self.id}/#{self.name}"
      resp = S3_CLIENT.put_object({
        body: key, 
        bucket: Rails.configuration.x.aws.bucket, 
        key: path, 
      })
      return path
    end
    
    def no_cname_record_exists
      !DnsRecord.where(domain_id: self.id, record_type: :cname, hostname: self.name).exists?
    end

    def no_dkim_record_exists
      !DnsRecord.where(domain_id: self.id, record_type: :txt, hostname: 'mc1._domainkey.' + self.name).exists?
    end
end
