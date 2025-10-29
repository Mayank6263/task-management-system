class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentables
  # has_many :likes, as: :likeable
  validates :image, presence: true
end

