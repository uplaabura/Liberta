Rails.application.config.middleware.use OmniAuth::Builder do
  
  # Load ENV var FACEBOOK_CONFIG from facebook.yml
  ##FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
  # Pass provider to RACK
  ##provider :facebook, 
    # Retrive info in ENV variables
    ##FACEBOOK_CONFIG['app_id'], 
    ##FACEBOOK_CONFIG['secret'],

    # request permissions from facebook
    # https://developers.facebook.com/docs/facebook-login/permissions/v2.4#reference
    ##{ :scope => 'public_profile, email' }

end