# Replace the 'config_from_url' string value below with your
# product environment's credentials, available from your Cloudinary console.
# =====================================================

require 'cloudinary'

Cloudinary.config_from_url("cloudinary://149662327939614:XZgq5ZxC3xAoFxMDTQpA6BNZqoU@hzodm3yak")
Cloudinary.config do |config|
  config.secure = true
end