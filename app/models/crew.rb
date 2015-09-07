class Crew < ActiveRecord::Base

  # Include default devise modules. 
  devise  :database_authenticatable,
          #:confirmable,
          #:recoverable,  
          #:registerable,
          #:rememberable, 
          :trackable, 
          #:timeoutable,
          #:validatable,
          #:lockable,

          :omniauthable, :omniauth_providers => [:facebook]

          
  #def self.koala(auth)
    #access_token = auth['token']
    #facebook = Koala::Facebook::API.new(access_token)
    #facebook.get_object("me?fields=email,name,picture")
  #end

  def self.find_info_from_omniauth_facebook(auth) #find record then update or create from omniauth_facebook
    if the_crew = Crew.where({:provider => auth.provider, :uid => auth.uid,}).first
      Crew.update( #.update is an ActiveRecord::Relation method, requires .update(id, attributes)
        the_crew[:id],
        { :email => auth.info.email, 
          :name => auth.info.name, 
          :image => auth.info.image
        }
      )
      return the_crew
    else # Create a user with a stub password. 
      Crew.create(
        { :provider => auth.provider,
          :uid => auth.uid,
          :email => auth.info.email, 
          :name => auth.info.name, 
          :image => auth.info.image,
          :password => Devise.friendly_token[0,20]
        }
      )
    end
  end

  #def self.find_record_from_omniauth_facebook(auth) #find record or create from omniauth_facebook
    #where({:provider => auth.provider, :uid => auth.uid}).first_or_create do |create_crew| #first_or_create is a ActiveRecord::relative method
      #create_crew.email = auth.info.email
      #create_crew.password = Devise.friendly_token[0,20]
      #create_crew.name = auth.info.name   
      #create_crew.image = auth.info.image 
    #end
  #end

  #def self.new_with_session(params, session)    
    #super.tap do |crew_info|
      #if crew_info = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        #crew_info.email = crew_info["email"] if crew.email.blank?
      #end
    #end

    #super.tap do |crew_info|
      #if hash_from_facebook = session["devise.facebook_data"]
        #crew_info.email = hash_from_facebook.info.email
        #crew_info.name = hash_from_facebook.info.name
        #crew_info.image = hash_from_facebook.info.image
      #end
    #end
  
  #end

  #But when is this method used? 
  #It's used by Devise when something goes wrong when creating your user. 
  #Imagine that the authentication provider doesn't give you an email
  #Well, you can redirect the user to your sign up page where he can complete the signup process. 
  #But if you redirect the user, you lose the data received by the oauth. 
  #The solution is to put this data into the session.
  #So in controller
  ##session["devise.facebook_data"] = env["omniauth.auth"]


end
