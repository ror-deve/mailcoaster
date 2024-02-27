require 'aws-sdk-s3'

Aws.config.update({
  region: Rails.configuration.x.aws.region,
  credentials: Aws::Credentials.new(
    Rails.configuration.x.aws.access_key_id, Rails.configuration.x.aws.secret_access_key
  )
})

s3_options = {
  force_path_style: true,
}

if Rails.env.development? && Rails.configuration.x.aws.s3_endpoint.present?
  s3_options[:endpoint] = Rails.configuration.x.aws.s3_endpoint
end

S3_CLIENT = Aws::S3::Client.new(s3_options)

if Rails.env.development?
  resp = S3_CLIENT.list_buckets({})
  if resp.buckets.length == 0
    S3_CLIENT.create_bucket({bucket: Rails.configuration.x.aws.bucket})
  end
end
