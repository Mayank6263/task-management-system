class User < ApplicationRecord
	has_secure_password
	validates :username, :uniqueness, presence: :true
	validates :email, :uniqueness, presence: :true
	vaidates :password, presence: :true
	has_one :profile

	enum gender: {
    male: 0,
    female: 1,
    other: 2 
  }
end
