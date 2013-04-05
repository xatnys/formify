require 'spec_helper'

feature 'Visiting the registration page' do
	
	context 'when not logged in' do
		before { visit register_path }
		scenario 'show registration form' do
			expect(page).to have_content("Register")
			fields = %w[email first_name last_name password password_confirmation]
			fields.each do |f|
				expect(page).to have_field("user_#{f}")
			end
		end
		context 'registering a new user' do
			context "with valid information" do
				before do
					fill_in 'user_email', with: 'foo@bar.com'
					fill_in 'user_password', with: 'foobar'
					fill_in 'user_password_confirmation', with: 'foobar'
					fill_in 'user_first_name', with: 'John'
					fill_in 'user_last_name', with: 'Doe'
					
				end
				scenario 'adds a new user to the db' do
					expect { click_button 'Register' }.to change(User, :count).by(1)
				end
			end

			context "with invalid information" do
				# stub
			end
		end
	end
end