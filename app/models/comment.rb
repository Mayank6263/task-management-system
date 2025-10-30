class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable
  # has_many :likes, as: :likeable
  validates :user_id, presence: true
end
