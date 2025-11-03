class Like < ApplicationRecord
  validate :prevent_multiple_likes
  belongs_to :likeable, polymorphic: true, counter_cache: true
  belongs_to :user

  def prevent_multiple_likes
     return unless likeable.likes.exists?(user_id: user_id)

     errors.add(:base, "You already liked #{likeable_type}")
  end
end
