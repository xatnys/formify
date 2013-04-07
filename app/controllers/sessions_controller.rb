class SessionsController < ApplicationController
	before_action :verify_not_signed_in, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: params[:user][:email])
		if @user.authenticate(params[:user][:password])
			sign_in @user
			redirect_to root_path
		end
	end

	def destroy
		if signed_in?
			signout_user
		end
		redirect_to root_path
	end
end
