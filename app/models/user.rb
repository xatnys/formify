class User < ActiveRecord::Base

	include ActiveModel::Validations
	class UserValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "cannot start with numbers and - or _" unless value =~ /\A[^-_\d]?/i
			record.errors.add attribute, "must be alphanumeric" unless value =~ /[a-zA-Z\d_-]+/i
		end
	end
	
	def self.priv_list
		{ 1 => :priv_manage_ops, 
			2 => :priv_view_cust , 4 => :priv_search_cust,
			8 => :priv_add_cust_email, 16 => :priv_add_cust_phone, 32 => :priv_add_cust_kiosk,
			64 => :priv_edit_cust }
	end
	
	include Bitfields

	priv_noscope = User.priv_list
	priv_noscope[:scopes] = false
	bitfield :privileges, priv_noscope
 
	# before_save { self.email.downcase! }
	before_save { new_session_token }

	# EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	# validates :email, presence: true, format: { with: EMAIL_REGEX }, 
	# 	uniqueness: { case_sensitive: false }
	validates :username, presence: true, 
		uniqueness: true,
		:user => true

	validates :first_name, presence: true
	validates :last_name, presence: true

	has_secure_password
	validates :password, presence:true, length: { minimum: 5 }
	validates :password_confirmation, presence: true
	validates :password_digest, presence: true


	private
		def new_session_token
			self.session_token = SecureRandom.urlsafe_base64
		end

end
