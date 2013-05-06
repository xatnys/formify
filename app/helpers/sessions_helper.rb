module SessionsHelper
	@current_user = nil

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by(session_token: cookies[:token])
	end

	def current_user?(user)
		@current_user == user
	end

	def sign_in(user)
		cookies[:token] = { :value => user.session_token, :expires => 1.hour.from_now }
		self.current_user = user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:token)
	end

	def signed_in?
		!current_user.nil?
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

	def verify_signed_in
		unless signed_in?
			store_location
			redirect_to login_path, notice: "Please log in."
		end
	end

	def verify_not_signed_in
		if signed_in?
			store_location
			redirect_to manage_path, notice: "You're already logged in as #{current_user.username}."
		end
	end

	def verify_default_admin
		if default_admin?
			redirect_to profile_path, notice: "You've logged in using the default
				admin password. This password must be changed."
		end
	end

	def default_admin?
		return current_user.admin? && current_user.authenticate("admin")
	end
end
