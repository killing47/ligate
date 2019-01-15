class Cd < ApplicationRecord

  belongs_to :user
  has_many :musics, dependent: :destroy, inverse_of: :cd
  accepts_nested_attributes_for :audios, allow_destroy: true
  attachment :cd
end
