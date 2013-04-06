require 'spec_helper'

describe SessionsController do
	describe 'GET sessions#new' do
		describe "when not signed in" do
			before { get :new }
			it "responds successfully" do
				expect(response).to be_success
				expect(response.code).to eq("200")
			end

			it 'renders signin template' do
				expect(response).to render_template('new')
			end

			it 'holds a reference to a current_user' do
				expect(assigns(:current_user)).to be
			end

			it 'determines current_user to be false' do
				expect(assigns(:current_User)).to be_false
			end

			it 'has a reference to a new User' do
				expect(assigns(:user)).to be
			end
		end
	end
end
