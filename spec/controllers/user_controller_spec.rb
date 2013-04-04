require 'spec_helper'

describe UserController do
	describe 'GET register_path' do
		before { get :new }
		it "responds successfully" do
			expect(response).to be_success
			expect(response.code).to eq(200)	
		end

		it 'renders registration template' do
			expect(response).to render_template('new')
		end

		it 'has a reference to a new User' do
			expect(assigns(:user)).to be
		end
	end

	describe 'POST user#create' do
		
	end
end
