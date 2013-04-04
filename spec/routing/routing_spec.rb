require 'spec_helper'

describe "routing" do
  describe "GET /" do
    it "shows static#home" do
 			{ get: root_path }.should route_to('static#home')
    end
  end
  describe "GET /register" do
  	it 'shows users#new' do
  		{ get: register_path }.should route_to('user#new')
  	end
  end
end
