indexing

	description: 
		"Displays warning and error messages from Error handler%
		%during a compilation.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ERROR_DISPLAYER

feature -- Output

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		require
			non_void_handler: handler /= Void;
			not_empty_warnings: not handler.warning_list.is_empty
		deferred
		end;

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		require
			non_void_handler: handler /= Void;
			not_empty_errors: not handler.error_list.is_empty
		deferred
		end;

	force_display is
			-- Make sure the user can see the messages we send.
		deferred
		end

end -- class ERROR_DISPLAYER
