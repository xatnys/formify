require 'spec_helper'

feature 'Visiting the registration page' do
	context 'when not logging in' do
		scenario 'show registration form' do
			visit register_path
			expect(page).to have_content("Register")
			expect(page).to have_form('user#create', post)
		end
	end
end