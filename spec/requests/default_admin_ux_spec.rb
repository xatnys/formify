require "spec_helper"

describe "default admin account log in" do
	let(:admin) { FactoryGirl.create(:default_admin) }
	it "prevents admin from proceeding until changing the default password" do
		cookies[:token] = admin.session_token # programatically log in
		
		get "/manage"
		
		expect(response).to redirect_to profile_path
		follow_redirect!

		expect(response).to render_template :edit
		expect(response).to render_template :partial => '_edit_pw'
	end
end