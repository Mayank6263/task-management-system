class User < ApplicationRecord
	has_secure_password
	validates :username, uniqueness: :true, presence: :true
	validates :email, uniqueness: :true, presence: :true
	# vaidates :password, presence: :true
	has_one :profile

end
