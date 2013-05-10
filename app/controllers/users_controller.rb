class UsersController < ApplicationController
	before_action :verify_signed_in
	before_action :verify_default_admin, except: [:edit, :update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to manage_admin_path
		else
			@users = User.all unless defined?(@users)
			render :template => 'manage/admin', :locals => { users: @users }
		end
	end

	def edit
		# @user = params[:id] ? User.find_by(id: params[:id]) : current_user
		if request.fullpath == profile_path
			@user = current_user
		end
	end

	def update
		@user = current_user
		if @user.update_attributes(user_params)
			sign_in @user
			redirect_to manage_path
		else
			render :edit
		end

	end
	
	def index
		@user = User.new
		@users = User.all
	end

	private
		def user_params
			params.require(:user).permit(:username,:password,
				:password_confirmation,:first_name,:last_name, User.priv_list.values)
		end
end
