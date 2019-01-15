class User < ApplicationRecord

  has_many :cds, dependent: :destroy
  has_many :load_music, dependent: :destroy
  attachment :user
end
