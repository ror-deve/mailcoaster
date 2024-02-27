class DkimSetting < ApplicationRecord
  # NOTE: This table is shared with Pigeon(MTA), before making any changes to schema
  # or data storage/validation etc. ensure that this won't break Pigeon
  belongs_to :dns_record
  belongs_to :account

  after_commit :delete_key_from_s3, on: :destroy

  private
    def delete_key_from_s3
      begin
        S3_CLIENT.delete_object({
          bucket: Rails.configuration.x.aws.bucket, 
          key: self.private_key_path, 
        })
      rescue => e
        Rails.logger.error("Failed to delete s3 file: #{e.message}")
      end
    end
end
