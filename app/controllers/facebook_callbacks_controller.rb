class FacebookCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        
      # Koala approach
      ##@crew = Crew.koala(request.env['omniauth.auth']['credentials'])
      ##sign_in_and_redirect @crew

      # Omniauth approach
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @crew = Crew.from_omniauth(request.env['omniauth.auth'])
      # Hash content in request.env['omniauth.auth'] refer to evernote "omniauth_facebook"

      if @crew.persisted?
        sign_in_and_redirect @crew, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
      else
        session['devise.facebook_data'] = request.env['omniauth.auth']
        redirect_to new_crew_registration_path
      end

      # Simple omniauth approach
      #@crew = Crew.from_omniauth(request.env["omniauth.auth"])
      #sign_in_and_redirect @crew

      #if request.env["omniauth.auth"].info.email.blank?
          #redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email" 
      #end
    end
      
end