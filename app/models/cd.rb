class Cd < ApplicationRecord

  belongs_to :user
  has_many :musics
  
end
