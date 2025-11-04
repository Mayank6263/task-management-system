class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, counter_cache: true
  # belongs_to :post,
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable, dependent: :destroy
end
