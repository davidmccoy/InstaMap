require 'instagram'

Instagram.configure do |config|
  config.client_id = ENV["IM_INSTAGRAM_CLIENT_ID"]
  config.client_secret = ENV["IM_INSTAGRAM_CLIENT_SECRET"]
end