FactoryGirl.define do

	factory :user do
		sequence(:username) { |n| "foo#{n}@bar.com" }
		sequence(:first_name) { |n| "Fizz #{n}" }
		sequence(:last_name) { |n| "Buzz #{n}" }
		password "foobar"
		password_confirmation "foobar"

		sequence(:priv_view_cust) { true }
		sequence(:priv_search_cust) { true }

		factory :default_admin do
			username 'admin'
			password 'admin'
			password_confirmation 'admin'
			sequence(:privileges) { 127 }
			sequence(:admin) { true }
			factory :admin do
				password 'password'
				password_confirmation 'password'
			end
		end
	end

	
end