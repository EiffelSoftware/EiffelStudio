indexing
	description: "Constants for `tty'."
	date: "$Date$"
	revision: "$Revision$"

class TTY_CONSTANTS

feature -- Access

	warning_messages: WARNING_MESSAGES is
			-- Access to warning messages.
		once
			create Result
		ensure
			warning_message_not_void: warning_messages /= Void
		end

end -- class TTY_CONSTANTS
