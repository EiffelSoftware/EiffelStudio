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
			create error_list.make
			create warning_list.make
		end

feature -- Properties		

	error_list: LINKED_LIST [SYNTAX_ERROR]
			-- Error list

	warning_list: LINKED_LIST [SYNTAX_WARNING]
			-- Warning list

feature -- Error handling primitives

	insert_error (e: SYNTAX_ERROR) is
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
			error_list.extend (e)
			error_list.finish
		end

	insert_warning (w: SYNTAX_WARNING) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
			warning_list.extend (w)
			warning_list.finish
		end

	raise_error is
		do
		end

	wipe_out is
			-- Empty `error_list' and `warning_list'.
		do
			error_list.wipe_out
			warning_list.wipe_out
		end

feature -- Status

	has_error: BOOLEAN is
			-- Has error handler detected an error so far?
		do
			Result := not error_list.is_empty
		end

	has_warning: BOOLEAN is
			-- Has error handler detected a warning so far?
		do
			Result := not warning_list.is_empty
		end


end -- class ERROR_HANDLER
