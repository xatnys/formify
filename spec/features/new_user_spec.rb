require 'spec_helper'

feature 'Visiting the new operator page' do
	let (:op) { FactoryGirl.create(:user) }
	let (:admin) { FactoryGirl.create(:admin) }
	context 'when logged in' do
		context 'as an admin' do
			before do
				log_in admin
				visit new_user_path
			end
			scenario 'show new op form' do
				expect(page).to have_content("New user")
				fields = %w[username first_name last_name password password_confirmation]
				fields.each do |f|
					expect(page).to have_field("user_#{f}")
				end
			end
			context 'adding a new operator' do
				context "with valid information" do
					before do
						fill_in 'user_username', with: 'foo@bar.com'
						fill_in 'user_password', with: 'foobar'
						fill_in 'user_password_confirmation', with: 'foobar'
						fill_in 'user_first_name', with: 'John'
						fill_in 'user_last_name', with: 'Doe'
						
					end
					scenario 'adds a new user to the db' do
						expect { click_button 'Add user' }.to change(User, :count).by(1)
					end
				end

				context "with invalid information" do
					# stub
				end
			end
		end
		context 'as a non-admin' do
			before { visit new_user_path }
			scenario 'show manage page with error denying access' do
				expect(page).to have_content('You do not have permission')
			end
		end
	end
end