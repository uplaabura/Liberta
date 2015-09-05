class Crew < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable,
          :recoverable,  
          :registerable,
          :rememberable, 
          :trackable, 
          :validatable,

          :omniauthable, :omniauth_providers => [:facebook]

  #def self.koala(auth)
    #access_token = auth['token']
    #facebook = Koala::Facebook::API.new(access_token)
    #facebook.get_object("me?fields=email,name,picture")
  #end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |crew| #first_or_create is a rails method
      crew.email = auth.info.email
      crew.password = Devise.friendly_token[0,20]
      #crew.name = auth.info.name   # assuming the user model has a name
      #crew.image = auth.info.image # assuming the user model has an image
    end
  end

  #def self.new_with_session(params, session)
    #super.tap do |crew|
      #if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        #crew.email = data["email"] if crew.email.blank?
      #end
    #end
  #end

end
