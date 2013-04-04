FactoryGirl.define do

	factory :user do
		sequence(:email) { |n| "foo#{n}@bar.com" }
		sequence(:first_name) { |n| "Fizz #{n}" }
		sequence(:last_name) { |n| "Buzz #{n}" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	
end