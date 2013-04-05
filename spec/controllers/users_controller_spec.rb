require 'spec_helper'

describe UsersController do
	describe 'GET user#new' do
		before { get :new }
		it "responds successfully" do
			expect(response).to be_success
			expect(response.code).to eq("200")
		end

		it 'renders registration template' do
			expect(response).to render_template('new')
		end

		it 'has a reference to a new User' do
			expect(assigns(:user)).to be
		end
	end

	describe 'POST user#create' do
		before { User.delete_all }
		describe "with valid information" do
			let :params do
				{ :email => 'foo@bar.com', 
					:password => 'foobar', 
					:password_confirmation => 'foobar',
					:first_name => 'Fizz',	:last_name => 'Buzz' }
				
			end

			subject(:req) { post :create, { :user => params } }
			it 'responds successfully' do
				post :create, { :user => params }
				expect(response).to redirect_to root_path
				expect(response.code).to eq("302") #signal redirect
			end
			it 'holds a reference to a new User with params' do
				post :create, { :user => params }
				expect(assigns(:user).password).to be
			end
			it 'creates a new user' do
				expect { req }.to change(User, :count).by(1)
			end
		end
	end
end
