note
	description: "Dummy log writer used as a null implementation for performance testing"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_WRITER_NULL

inherit
	LOG_WRITER

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize the {LOG_WRITER_NULL}.
		do
			is_initialized := True
		end

feature {LOG_LOGGING_FACILITY} -- Output

	do_write (priority: INTEGER; msg: STRING)
			-- <Precursor>
		do
			-- Ignore logging calls.
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
