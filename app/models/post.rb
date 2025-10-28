class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  has_many :comments, as: :commentable
end
