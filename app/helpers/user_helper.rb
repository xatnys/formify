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
		arr
	end
end
