class Delegation < ActiveRecord::Base
	
	belongs_to :parent
	scope :incomplete, where(:status => false)
end
