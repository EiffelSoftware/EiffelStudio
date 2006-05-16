indexing
	description: "Shared error handler for Eiffel Query Language"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_ERROR_HANDLER

feature -- Access

	error_handler: QL_ERROR_HANDLER is
			-- Shared Error handler
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

end
