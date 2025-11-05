class Like < ApplicationRecord
  validate :prevent_multiple_likes
  belongs_to :likeable, polymorphic: true, counter_cache: true, primary_key: :uuid, foreign_key: :likeable_uuid
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid

  def prevent_multiple_likes
     return unless likeable.likes.exists?(user_id: user_id)

     errors.add(:base, "You already liked #{likeable_type}")
  end
end
