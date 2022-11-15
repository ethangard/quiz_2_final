class Idea < ApplicationRecord

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :title, :description, presence: true

end
