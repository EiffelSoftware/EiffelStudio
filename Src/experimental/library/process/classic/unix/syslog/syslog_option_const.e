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
			"C inline use <syslog.h>"
		alias
			"return LOG_PID;"
		end

	Log_cons: INTEGER
			-- Log on the console if errors in sending
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_CONS;"
		end

	Log_odelay: INTEGER
			-- Delay open until first call to `sys_log' (default)
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_ODELAY;"
		end

	Log_ndelay: INTEGER
			-- Don't delay open
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_NDELAY;"
		end

	Log_nowait: INTEGER
			-- Don't wait for console forks: DEPRECATED
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_NOWAIT;"
		end

	Log_perror: INTEGER
			-- Log to stderr as well
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_PERROR;"
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
