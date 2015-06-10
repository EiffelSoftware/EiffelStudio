note
	description: "Summary description for {SHARED_ORDER_VALIDATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ORDER_VALIDATION

feature
	order_validation : ORDER_VALIDATION
		once
			create Result
		end

note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
