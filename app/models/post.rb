class Post < ApplicationRecord
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid
  has_many :comments, as: :commentable, dependent: :destroy, primary_key: :uuid, foreign_key: :commentable_uuid
  has_many :likes, as: :likeable, dependent: :destroy, primary_key: :uuid, foreign_key: :likeable_uuid
  validates :image, presence: true
  validates :caption, presence: true
end
