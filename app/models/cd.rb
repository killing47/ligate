class Cd < ApplicationRecord

  enum status: {gest: 0,contribution: 1,unsubscribe: 2}
  belongs_to :user
  has_many :musics, dependent: :destroy, inverse_of: :cd
  accepts_nested_attributes_for :musics, allow_destroy: true
  attachment :cd

end
