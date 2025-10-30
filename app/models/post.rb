class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentables
  validates :image, presence: true
  validates :caption, presence: true
  validates :user_id, presence: true
  # self.per_page = 2


end

