note
	description: "Log Options determine how the messages are logged"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LOG_OPTION_CONSTANTS

feature {NONE} -- Constants

	Log_pid: INTEGER
			-- Log the pid with each message
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_PID"
		end

	Log_cons: INTEGER
			-- Log on the console if errors in sending
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_CONS"
		end

	Log_odelay: INTEGER
			-- Delay open until first call to `sys_log' (default)
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_ODELAY"
		end

	Log_ndelay: INTEGER
			-- Don't delay open
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_NDELAY"
		end

	Log_nowait: INTEGER
			-- Don't wait for console forks: DEPRECATED
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_NOWAIT"
		end

note
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (See http://www.eiffel.com/licensing/forum.txt"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone 0044-208-742-3422 Fax 0044-208-742-3468
					Website http://www.itpassion.com
					Customer Support http://powerdesk.itpassion.com
				]"

end
