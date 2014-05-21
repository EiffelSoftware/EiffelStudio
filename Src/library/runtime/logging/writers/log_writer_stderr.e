note
	description: "Log Writer that writes to stderr"
	legal: "See note at the end of this class"
	status: "See notice at the end of this class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_WRITER_STDERR

inherit
	LOG_WRITER
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Create system logger.
		do
			log_level := Log_error
		ensure then
			default_log_level_set: log_level = Log_error
		end

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize this LOG_WRITER_STDERR instance
		do
			is_initialized := not io.error.is_closed
		end

feature {LOG_LOGGING_FACILITY} -- Output

	do_write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to `io.error' also noting the current date and time,
			-- and adding a newline character if needed
		do
			date_time.make_now_utc

			io.error.putstring (date_time.out)
			io.error.putstring (space_dash_space)
			io.error.putstring (priority_tag (priority))
			io.error.putstring (space_dash_space)
			io.error.putstring (msg)
			if msg [msg.count] /= '%N' then
					-- Append a new line if not present.
				io.error.put_character ('%N')
			end
			io.error.flush
		end

feature {NONE} -- Implementation

	space_dash_space: STRING = " - "
		-- " - " constant for writing log data.

	date_time: DATE_TIME
			-- Date/time object that is reseeded to now every time `write' is called
		once
			create Result.make_now_utc
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
