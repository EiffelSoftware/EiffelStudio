note
	description:	"Log Writer that writes to stderr"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	LOG_WRITER_STDERR

inherit
	LOG_WRITER

feature {LOG_LOGGING_FACILITY} -- Initialization

	initialize
			-- Initialize this LOG_WRITER_STDERR instance
		do
			is_initialized := not io.error.is_closed
		end

feature {LOG_LOGGING_FACILITY} -- Output

	write (priority: INTEGER; msg: STRING)
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
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (See http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone 0044-208-742-3422 Fax 0044-208-742-3468
					Website http://www.itpassion.com
					Customer Support http://powerdesk.itpassion.com
				]"

end
