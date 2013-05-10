class SessionsController < ApplicationController
	before_action :verify_not_signed_in, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.find_by(username: params[:username])
		
		if @user && @user.authenticate(params[:password])
			sign_in @user
			redirect_to manage_path
		else
			flash[:error] = "Error: unrecognized username or password."
			render :new
		end
	end

	def destroy
		if signed_in?
			sign_out
		end
		redirect_to root_path
	end
end
