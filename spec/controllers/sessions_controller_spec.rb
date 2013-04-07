require 'spec_helper'

describe SessionsController do
	let(:test_user) { FactoryGirl.create(:user) }
	let(:test_user_params) { { :email => test_user.email, :password => test_user.password } }
	let(:cookie_params) { { :value => test_user.session_token, :expires => 1.hour.from_now } }
	describe 'GET sessions#new' do
		describe "when not signed in" do
			before { get :new }
			it "responds successfully" do
				expect(response).to be_success
				expect(response.code).to eq("200")
			end

			it 'renders signin template' do
				expect(response).to render_template(:new)
			end

			it 'determines current_user to be nil' do
				expect(assigns(:current_user)).to be_nil
			end

			it 'has a reference to a new User' do
				expect(assigns(:user).created_at).to eq(nil)
			end
		end
		describe "when signed in" do
			before do
				cookies[:token] = cookie_params
				get :new
			end
			it 'responds with redirect to root_path' do
				expect(response).to redirect_to(root_path)
			end

			it 'determines current_user to exist' do
				expect(assigns(:current_user)).to be
			end
			it 'does not create a reference to new User' do
				expect(assigns(:user)).to be_nil
			end
		end
	end
	describe 'POST sessions#create' do
		describe 'when not signed in' do
			before do
				cookies.delete(:token)
				post :create, :user => test_user_params
			end
			it 'responds successfully' do
				expect(response).to be_success
				expect(response.code).to eq('200')
			end
			it 'holds a reference to an existing user' do
				expect(assigns(:user).email).to eq(test_user.email)
			end
			it 'stores a token in cookieStore' do
				expect(cookies[:token]).to be
			end

		end
	end
end
