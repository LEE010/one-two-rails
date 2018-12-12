require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     "#{ENV['AWS_KEY']}",                        # required unless using use_iam_profile
    aws_secret_access_key: "#{ENV['AWS_SECRET']}",                        # required unless using use_iam_profile
    use_iam_profile:       true,                         # optional, defaults to false
    region:                'ap-northeast-2',                  # optional, defaults to 'us-east-1'
   
  }
  config.fog_directory  = 'one-two-test'                                      # required
 
end