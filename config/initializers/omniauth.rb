Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret, :scope => 'email,user_birthday,read_stream,publish_actions,user_likes', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}
end


# OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
#   if Rails.env.development?
#     OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#     provider :facebook, 'DEV_APP_ID', 'DEV_APP_SEVRET'
#   else
#     provider :facebook, 'DEPLOY_APP_ID', 'DEPLOY_APP_SECRET'
#   end
# end