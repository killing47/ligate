class Cd < ApplicationRecord

  belongs_to :user
  has_many :musics, dependent: :destroy, inverse_of: :cd
  has_many :favorites, dependent: :destroy
  accepts_nested_attributes_for :musics, allow_destroy: true
  attachment :cd_image

  validates :cd_title, presence: true, length: { maximum:20 }
  validates :cd_genre, presence: true, length: { maximum:10 }

  def favorited_by?(user) #いいねしているかどうか
    favorites.where(user_id: user.id).exists?
  end

end
