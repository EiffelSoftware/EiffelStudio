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
			-- Initialize this FILE_LOG_WRITER instance
		do
			is_initialized := not io.error.is_closed
		end

feature {LOG_LOGGING_FACILITY} -- Output

	write (priority: INTEGER; msg: STRING)
			-- Write `msg' under `priority' to `io.error' also noting the current date and time,
			-- and adding a newline character if needed
		local
			l_has_newline: BOOLEAN
		do
			date_time.make_now_utc
			l_has_newline := (msg.index_of ('%N', 1) = msg.count)
			if not l_has_newline then
				io.error.putstring (date_time.out + " - " + priority_tag (priority) + " - " + msg +
					"%N")
			else
				io.error.putstring (date_time.out + " - " + priority_tag (priority) + " - " + msg)
			end
			io.error.flush
		end

feature {NONE} -- Attributes

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
