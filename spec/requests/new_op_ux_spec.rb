require "spec_helper"

describe 'manage users page' do
	describe 'as an admin' do
		let(:admin) { FactoryGirl.create(:admin) }
		before do
			cookies[:token] = admin.session_token
			get '/manage/users'
		end
		it 'shows the manage users index' do
			expect(response).to render_template :index
		end
		it 'provides an interface to add new users' do
			expect(response).to render_template :partial => '_user_form'
		end
		it 'provides a view of all users' do
			expect(response).to render_template :partial => '_user_list'
		end
	end
end
