class Phone < ActiveRecord::Base

	HOME = 1
	MOBILE = 2
	WORK = 3

  def self.PhoneTypes
    { "Home" => HOME, "Mobile" => MOBILE, "Work" => WORK }
  end

  def self.resolve_type(type)
    types = Phone.PhoneTypes.invert
    return types[type]
  end
  belongs_to :parent

  validates :number, presence: true, length: { minimum: 7 }

  PHONE_TYPES = [ HOME, MOBILE, WORK ]
  validates :phone_type, presence: true, 
  	:inclusion => { 
  		:in => PHONE_TYPES, 
  		:message => "invalid phone type (expected home, mobile, or work)" 
  	}

  	
end
