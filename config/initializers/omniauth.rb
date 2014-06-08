Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret, :scope => 'email,user_birthday,read_stream,publish_actions,user_likes'
end
