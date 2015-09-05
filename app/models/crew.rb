class Crew < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable,
          :recoverable,  
          :registerable,
          :rememberable, 
          :trackable, 
          :validatable#,

          #:omniauthable, :omniauth_providers => [:facebook]

  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    facebook.get_object("me?fields=name,picture")
  end
end
