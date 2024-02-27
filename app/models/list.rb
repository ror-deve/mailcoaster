class List < ApplicationRecord
  enum language: {english: "en",spanish: "sp",french: "fr",german: "ge" }
  enum list_type: {normal: "Normal",suppressed: "Suppressed"}
  enum unsubscribe: {yes: true,no: false}
  belongs_to :account

  validates :account_id,    presence: true
  validates :name,          presence: true, uniqueness: { scope: :account_id }
  validates :language,      presence: true
  validates :address,       presence: true
  validates :from_email, format: { with: /\A[A-Za-z0-9.=_%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }, if: proc { from_email.present? }
  validates :reply_to_email, format: { with: /\A[A-Za-z0-9.=_%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }, if: proc { reply_to_email.present? }

  def self.read_and_save_file(account_id, list_id, file)
    key = "tmp_uploads/#{Time.now.strftime("%Y-%m-%d-%H:%M:%S")}_#{account_id}_#{list_id}_#{file.original_filename}"
    File.open(file, 'rb') do |file|
      S3_CLIENT.put_object(body: file, bucket: Rails.configuration.x.aws.bucket, key: key)
    end
    return key
  end

  def self.csv_or_txt?(content_type)
    content_type.in?(%w[text/csv text/plain])
  end

  def self.validate_file(file)
    return [false, "CSV file not present"] if file.nil?
    return [false, "You are not uploading a CSV file."] unless List.csv_or_txt?(file.content_type)
  
    max_file_size_bytes = 100 * 1024 * 1024 # 100 MB in bytes
    if file.size > max_file_size_bytes
      return [false, "File size exceeds the maximum allowed limit (100 MB)!"]
    end
  
    [true, "File is valid."]
  end
end
