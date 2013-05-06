class Phone < ActiveRecord::Base

	module PhoneType
		HOME = 0
		MOBILE = 1
		WORK = 2
	end

  has_one :parent, :inverse_of => :phone

  validates :parent, presence: true
  validates :number, presence: true, length: { minimum: 7 }

  PHONE_TYPES = [ PhoneType::HOME PhoneType::MOBILE PhoneType::WORK ]
  validates :phone_type, presence: true, 
  	:inclusion => { :in => PHONE_TYPES, :message => "invalid phone type (expected home, mobile, or work)" }
  	
end
