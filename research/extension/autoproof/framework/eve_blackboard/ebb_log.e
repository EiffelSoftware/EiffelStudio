note
	description: "Summary description for {EBB_LOGGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_LOG

feature -- Basic operations

	put_line (a_line: STRING)
			-- Put `a_line' into log.
		do
			io.put_string (a_line)
			io.put_new_line
		end

	put_visible_line (a_line: STRING)
			-- Make `a_line' visible to user.
			-- This is usually achieved by putting the line into the status bar of the active window.
		do
				-- Default implementation, just put it into log normally
			put_line (a_line)
		end

end
