class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, counter_cache: true, primary_key: :uuid, foreign_key: :commentable_uuid
  belongs_to :user, primary_key: :uuid, foreign_key: :commentable_uuid
  has_many :comments, as: :commentable, primary_key: :uuid, foreign_key: :commentable_uuid
  has_many :likes, as: :likeable, dependent: :destroy, primary_key: :uuid, foreign_key: :likeable_uuid
end
