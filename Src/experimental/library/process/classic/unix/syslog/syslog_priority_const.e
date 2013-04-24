note
	description: "Unix-specific syslog facility abstraction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SYSLOG_PRIORITY_CONST

feature {NONE} -- Constants

	Log_emerg: INTEGER
			-- System is unusable
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_EMERG;"
		end

	Log_alert: INTEGER
			-- Action must be taken immediately
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_ALERT;"
		end

	Log_crit: INTEGER
			-- Critical conditions
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_CRIT;"
		end

	Log_err: INTEGER
			-- Error conditions
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_ERR;"
		end

	Log_warning: INTEGER
			-- Warning conditions
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_WARNING;"
		end

	Log_notice: INTEGER
			-- Normal but significant condition
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_NOTICE;"
		end

	Log_info: INTEGER
			-- Informational
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_INFO;"
		end

	Log_debug: INTEGER
			-- Debug-level messages
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_DEBUG;"
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
