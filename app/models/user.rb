class User < ApplicationRecord

  enum status: {gest: 0,contribution: 1,unsubscribe: 2}
  has_many :cds, dependent: :destroy
  has_many :load_music, dependent: :destroy
  attachment :image

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
     user.provider = auth.provider
     user.uid = auth.uid
     user.name = auth.info.name
     user.email = auth.info.email
     user.user_image = auth.info.image
     user.oauth_token = auth.credentials.token
     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
     return user
   end
  end
  
end
