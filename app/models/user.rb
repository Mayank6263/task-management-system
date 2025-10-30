class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :posts, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # def self.search(user_name)
  #   # if user_name
  #     user_name.downcase!
  #   #   where('LOWER(name) LIKE ?', "%#{name}%")
  #   # else
  #   #   all
  #   # end
  #   where(['name LIKE ?', "%#{user_name}%"])
  # end
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
