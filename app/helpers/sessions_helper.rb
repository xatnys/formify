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
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def verify_not_signed_in
    if signed_in?
      store_location
      redirect_to root_path, notice: "You're already signed in as #{current_user.email}."
    end
  end
end
