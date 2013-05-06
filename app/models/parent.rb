class Parent < ActiveRecord::Base
	include ActiveModel::Validations
	class AlphaValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "must be alphanumeric" unless value =~ /[a-zA-Z\d_-]+/i
		end
	end

	module RegMethod
		FROM_SYSTEM = 0
		FROM_EMAIL = 1
		FROM_PHONE = 2
		FROM_KIOSK = 3
	end

	has_many :phones, :inverse_of => :parent, :depends => :destroy

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :title, :inclusion => { :in => %w(mr mrs ms sr)}
	# require at least 1 phone number
	validates :phones, :presence => true

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	before_save { self.email.downcase! }

	# should be :unless there is a guardee/guardian relationship
	validates :addr, presence: true
	validates :state, presence: true
	validates :zip, presence: true, limit: { maximum: 12 }

	REG_METHODS = [ RegMethod::FROM_SYSTEM RegMethod::FROM_PHONE RegMethod::FROM_EMAIL RegMethod::FROM_KIOSK ]
	validates :reg_method, presence: true, 
		:inclusion => { :in => REG_METHODS, :message => "%{value} is not a valid registration method." }


end
