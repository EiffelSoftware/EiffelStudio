note
	description: "Unix-specific syslog facility abstraction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SYSLOG_OPTION_CONST

feature {NONE} -- Constants

	Log_pid: INTEGER
			-- Log the pid with each message
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_PID;"
		end

	Log_cons: INTEGER
			-- Log on the console if errors in sending
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_CONS;"
		end

	Log_odelay: INTEGER
			-- Delay open until first call to `sys_log' (default)
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_ODELAY;"
		end

	Log_ndelay: INTEGER
			-- Don't delay open
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_NDELAY;"
		end

	Log_nowait: INTEGER
			-- Don't wait for console forks: DEPRECATED
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_NOWAIT;"
		end

	Log_perror: INTEGER
			-- Log to stderr as well
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_PERROR;"
		end

note
	copyright:	"Copyright (c) 2010, ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 %
				%(see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, UK
					Telephone 44-800-678-3248 Fax 44-208-742-3468
					Website http://www.itpassion.com
					Customer support https://powerdesk.itpassion.com
				]"

end
