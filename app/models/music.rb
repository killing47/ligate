class Music < ApplicationRecord

  belongs_to :cd
  attachment :music, extension: ["mp3", "mp4", "m4a", "aif", "wav"]
end
