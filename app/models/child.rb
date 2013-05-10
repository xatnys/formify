class Child < ActiveRecord::Base
	belongs_to :parent
	validates :first_name, presence: true
	validates :last_name, presence: true
end
