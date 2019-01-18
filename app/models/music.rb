class Music < ApplicationRecord

  belongs_to :cd
  attachment :audio, extension: ["mp3", "mp4", "m4a", "aif", "wav"]
  attachment :cd_image


end
