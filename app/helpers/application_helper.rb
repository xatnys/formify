module ApplicationHelper
	def sensible_error(err_array, label)
		if err_array.any?
			if err_array.include?("can't be blank")
				err_array.reject! { |x| x != "can't be blank" }
			end
			err_array.push(label)
			render 'users/field_error', object: err_array.uniq
		end
	end
end
