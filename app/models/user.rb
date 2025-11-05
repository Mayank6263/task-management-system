class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  self.primary_key = :uuid
  has_many :posts, dependent: :destroy, primary_key: :uuid, foreign_key: :user_uuid
  has_many :comments, dependent: :destroy, primary_key: :uuid, foreign_key: :user_uuid
  has_many :likes, dependent: :destroy, primary_key: :uuid, foreign_key: :user_uuid
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
