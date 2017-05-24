CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      ENV['AWS_ACCESS_KEY'],
    aws_secret_access_key:  ENV['AWS_SECRET_KEY'],
    region:                 'us-west-2'                  # optional, defaults to 'us-east-1'
  }

  config.fog_directory  = ENV['AWS_S3_BUCKET']
  config.asset_host     = ENV['AWS_ASSET_HOST']

  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

# For aws-sdk
ENV['AWS_ACCESS_KEY_ID'] = ENV['AWS_ACCESS_KEY']
ENV['AWS_SECRET_ACCESS_KEY'] = ENV['AWS_SECRET_KEY']
ENV['AWS_REGION'] = 'us-west-2'
