indexing
	description: "Error handler that manages warning and error messages."
	date: "$Date$"
	revision: "$Revision $"

class
	ERROR_HANDLER

create {SHARED_ERROR_HANDLER}
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
		end

feature {EIFFEL_PARSER} -- Error handling primitives

	insert_warning (w: SYNTAX_WARNING) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
		end

end -- class ERROR_HANDLER
