class ManageController < ApplicationController
	before_action :verify_signed_in
	before_action :verify_default_admin
	def index
	end
	def admin
		@user = User.new
		@users = User.all
	end
end
