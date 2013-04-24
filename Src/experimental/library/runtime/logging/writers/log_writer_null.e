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

	write (priority: INTEGER; msg: STRING)
			-- <Precursor>
		do
			-- Ignore logging calls.
		end

end
