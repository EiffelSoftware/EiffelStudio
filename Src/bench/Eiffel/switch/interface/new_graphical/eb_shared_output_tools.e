indexing
	description: "Shared output signs"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_OUTPUT_TOOLS

feature -- Access

	error_window: OUTPUT_WINDOW is
			-- Error window that displays error message
		once
			Result := init_error_window
		end

feature {NONE} -- Implementation

	init_error_window: OUTPUT_WINDOW is
			-- error window. this function is redefined for graphic mode
		do
			Result := term_window
		end

	term_window: TERM_WINDOW is
			-- terminal output. Used in text mode
		once
			create Result
		end

end -- class EB_SHARED_OUTPUT_TOOLS
