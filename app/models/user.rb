class User < ActiveRecord::Base
	
	before_save { self.email.downcase! }
	before_save { new_session_token }

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	
	validates :first_name, presence: true
	validates :last_name, presence: true, length: { minimum: 2 }

	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
	has_secure_password

	private
		def new_session_token
			self.session_token = SecureRandom.urlsafe_base64
		end
end
