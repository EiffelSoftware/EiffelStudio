indexing

	description:
		"Command to close a PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_QUERY_WINDOW_CMD

inherit
	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_query_window: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `query_window' to `a_query_window'.
		require
			a_query_window_not_void: a_query_window /= Void
		do
			query_window := a_query_window
		ensure
			query_window_set: query_window.is_equal (a_query_window)
		end

feature {NONE} -- Command Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current
		do
			query_window.close
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW

end -- EB_CLOSE_QUERY_WINDOW_CMD
