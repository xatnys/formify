class Parent < ActiveRecord::Base
	CONFIRM_CONFIRMED = 1
	CONFIRM_PENDING = 0
	CONFIRM_DENIED = -1

	# registration methods
	FROM_SYSTEM = 0
	FROM_EMAIL = 1
	FROM_PHONE = 2
	FROM_KIOSK = 3

	include ActiveModel::Validations
	class AlphaValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			record.errors.add attribute, "must be alphanumeric" unless value =~ /[a-zA-Z\d_-]+/i
		end
	end

	has_many :phones, :dependent => :destroy
	accepts_nested_attributes_for :phones, :allow_destroy => true
	validates :phones, :presence => true

	has_many :children, :dependent => :destroy
	accepts_nested_attributes_for :children, :allow_destroy => true
	validates :children, :presence => true

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :title, :inclusion => { :in => %w(mr mrs ms sr none) }
	# require at least 1 phone number
	

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	before_save { self.email.downcase! }

	# should be :unless there is a guardee/guardian relationship
	validates :addr, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true, length: { maximum: 12 }

	REG_METHODS = [ FROM_SYSTEM, FROM_PHONE, FROM_EMAIL, FROM_KIOSK ]
	validates :reg_method, presence: true, 
		:inclusion => { 
			:in => [0, 1, 2, 3], 
			:message => "%{value} is not a valid registration method." 
		}

	validates :confirmed_status, presence: true, :inclusion => { :in => [CONFIRM_DENIED, CONFIRM_PENDING, CONFIRM_CONFIRMED] }

	after_save :delegate

	private
		def delegate
			if self.confirmed_status.to_i == CONFIRM_PENDING
				u = User.offset(rand(User.count)).first
				delegation = u.delegations.build
				delegation.parent_id = self.id
				if delegation.save
					puts "delegated #{self.first_name} to #{u.first_name}"
				else
					puts "delegation failed"
				end
				return true
			end
		end
end
