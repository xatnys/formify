require 'spec_helper'

describe "routing" do
  describe "GET /" do
    specify { { get: '/' }.should route_to('static#home') }
  end

  describe "GET /manage/users/new" do
 		specify { { get: '/manage/users/new' }.should route_to('users#new') }
  end

  describe "GET /manage/profile" do
  	specify { { get: '/manage/profile' }.should route_to('users#edit') }
  end

  describe "GET /manage" do
  	specify { { get: '/manage' }.should route_to('manage#index') }
  end
end
