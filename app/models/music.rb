class Music < ApplicationRecord

  belongs_to :cd
  has_one_attached :audio

  validates :music_title, presence: true, length: { maximum:20 }
  
end
