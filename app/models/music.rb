class Music < ApplicationRecord

  belongs_to :cd
  attachment :audio, extension: ["mp3", "mp4", "m4a", "aif", "wav"]

  validates :audio_id, presence: true
  validates :music_title, presence: true, length: { maximum:20 }
  
end
