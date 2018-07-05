require 'carrierwave'

CarrierWave.configure do |config|
  if Rails.env.production?
    # TODO Configure S3 before releasing to production
    config.storage = :file
  else
    config.storage = :file
    config.enable_processing = false
  end
end
