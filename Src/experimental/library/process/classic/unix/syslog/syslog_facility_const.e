note
	description: "Unix-specific syslog facility abstraction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SYSLOG_FACILITY_CONST

feature {NONE} -- Constants

	Log_kern: INTEGER
			-- Kernel Messages
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_KERN;"
		end

	Log_user: INTEGER
			-- Random user-level messages
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_USER;"
		end

	Log_mail: INTEGER
			-- Mail system
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_MAIL;"
		end

	Log_daemon: INTEGER
			-- System daemons
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_DAEMON;"
		end

	Log_auth: INTEGER
			-- Security/Authorization messages
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_AUTH;"
		end

	Log_syslog: INTEGER
			-- Messages generated internally by syslogd
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_SYSLOG;"
		end

	Log_lpr: INTEGER
			-- Line printer subsystem
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LPR;"
		end

	Log_news: INTEGER
			-- Network news subsystem
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_NEWS;"
		end

	Log_uucp: INTEGER
			-- UUCP subsystem
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_UUCP;"
		end

	Log_cron: INTEGER
			-- Clock daemon
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_CRON;"
		end

	Log_authpriv: INTEGER
			-- Security/Authorization message (private)
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_AUTHPRIV;"
		end

	Log_ftp: INTEGER
			-- FTP daemon
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_FTP;"
		end

	Log_local0: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL0;"
		end

	Log_local1: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL1;"
		end

	Log_local2: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL2;"
		end

	Log_local3: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL3;"
		end

	Log_local4: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL4;"
		end

	Log_local5: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL5;"
		end

	Log_local6: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL6;"
		end

	Log_local7: INTEGER
			-- Reserved for local use
		external
			"C inline use <syslog.h>"
		alias
			"return LOG_LOCAL7;"
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
