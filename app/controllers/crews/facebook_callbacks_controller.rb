class Crews::FacebookCallbacksController < Devise::OmniauthCallbacksController
  def facebook # The name of the method should match the name of the provider.
      
    # Hash content in request.env['omniauth.auth'] refer to evernote "omniauth_facebook" or by the code:
    ##render :text => "<pre>" + env["omniauth.auth"].to_yaml and return

    
    # Koala approach
    ##@crew = Crew.koala(request.env['omniauth.auth']['credentials'])

    # Check if no email get from facebook    
    if request.env["omniauth.auth"].info.email.blank?
        redirect_to "/crews/auth/facebook?auth_type=rerequest&scope=email"
    end

    # Omniauth approach
    # You need to implement the method below in your model (e.g. app/models/crew.rb)
    @crew_info = Crew.find_record_from_omniauth_facebook(request.env['omniauth.auth'])

    if @crew_info.persisted? # persisted? is a ActiveRecord::persistence method      
      ##render :text => "<pre>" + @crew_info.to_yaml and return
      ##render :text => "<pre>" + @crew_info[:id].to_s and return
      ##render :text => "<pre>" + @crew_info[:name].to_s and return

      ##sign_in @crew_info
      ##redirect_to root_path(@crew_info)
      sign_in_and_redirect(@crew_info) #:event => :authentication # This will throw if @user is not activated
                                        #sign_in_and_redirect is a Devise controller helper method
      set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']  # This is for fast autofilling reg form?
                                                                      # This is for session auto clean up?
      ##redirect_to new_crew_registration_path
      redirect_to new_crew_session_path
    end

    # Simple omniauth approach
    ##@crew_info = Crew.from_omniauth(request.env["omniauth.auth"])
    ##sign_in_and_redirect @crew_info


    
    
  end
      
end