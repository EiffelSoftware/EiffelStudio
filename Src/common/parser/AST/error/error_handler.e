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

feature -- Error handling primitives

	insert_error (e: SYNTAX_ERROR) is
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
		end

	raise_error is
		do
		end

	insert_warning (w: SYNTAX_WARNING) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
		end

end -- class ERROR_HANDLER
