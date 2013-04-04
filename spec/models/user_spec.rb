require 'spec_helper'

describe User do
  
  let(:blank_user) { User.new }
	let(:user) { FactoryGirl.create(:user) }
  
  describe "email validation" do
	  it { should validate_presence_of(:email) }
	  let(:bad_email) { %w[@cOM foo b,@r fizz@buh..com bad@mail+addr.com not@so_fast.com be@punctual. me_at_nospam.net bah ] }
	  it "fails on invalid emails" do
	  	bad_email.each do |addr|
	  		user.email = addr
	  		expect(user).to be_invalid
	  	end
	  end

	  let(:mixed_case) { "mIxED@EMAIL.net" }
	  it "stores email as lowercase" do
	  	user.email = mixed_case
	  	user.save!
	  	expect(user.email).to eq(mixed_case.downcase)
	  end
	end

	describe "name validation" do
  	it { should validate_presence_of(:first_name) }
  	it { should validate_presence_of(:last_name) }
	end

	describe "password validation" do
		
		it { should validate_presence_of(:password) }
  	it { should validate_presence_of(:password_confirmation) }

  	# from has_secure_password helper
  	it { should validate_presence_of(:password_digest) }
  	specify { expect(user).to respond_to(:authenticate) }

  	it "fails when password != password_confirmation" do
  		user.password_confirmation = 'blah'
  		expect(user).to be_invalid
  	end
  end

  describe "session_token upon creation" do
  	specify { expect(user.session_token).to be }
  end

  it "can be an admin" do
  	expect(FactoryGirl.create(:admin)).to be_admin
  end

end
