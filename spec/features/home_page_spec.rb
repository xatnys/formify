require 'spec_helper'

feature 'Visiting the home page' do
	context 'without logging in' do
		scenario 'welcomes the user' do
			visit root_path
			expect(page).to have_content("Welcome")
		end
	end
end