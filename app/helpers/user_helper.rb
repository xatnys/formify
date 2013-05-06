module UserHelper
	def sensible_error(arr, label)
		if arr.any?
			error_message_sanitize(arr)
			arr.push(label)
			render 'users/field_error', object: arr
		end
	end

	def error_message_sanitize(arr)
		arr = arr.uniq
		if arr.include?("can't be blank")
			arr.reject! { |x| x != "can't be blank" }
		end
		return arr
	end

	def verify_privilege( *privs )
		if signed_in?
			verified = true
			privs.each do |priv|
				verified &= current_user.__send__ priv
			end
		end
		unless verified
			redirect_to manage_path, error: "You don't have access to this function"
		end
	end

end
