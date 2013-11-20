note
	description: "Log Facilities determine where the messages are logged"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LOG_FACILITY_CONSTANTS

feature {NONE} -- Unix Constants

	Log_kern: INTEGER
			-- Kernel Messages
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_KERN"
		end

	Log_user: INTEGER
			-- Random user-level messages
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_USER"
		end

	Log_mail: INTEGER
			-- Mail system
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_MAIL"
		end

	Log_daemon: INTEGER
			-- System daemons
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_DAEMON"
		end

	Log_auth: INTEGER
			-- Security/Authorization messages
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_AUTH"
		end

	Log_syslog: INTEGER
			-- Messages generated internally by syslogd
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_SYSLOG"
		end

	Log_lpr: INTEGER
			-- Line printer subsystem
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LPR"
		end

	Log_news: INTEGER
			-- Network news subsystem
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_NEWS"
		end

	Log_uucp: INTEGER
			-- UUCP subsystem
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_UUCP"
		end

	Log_cron: INTEGER
			-- Clock daemon
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_CRON"
		end

	Log_authpriv: INTEGER
			-- Security/Authorization message (private)
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_AUTHPRIV"
		end

	Log_ftp: INTEGER
			-- FTP daemon
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_FTP"
		end

	Log_local0: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL0"
		end

	Log_local1: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL1"
		end

	Log_local2: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL2"
		end

	Log_local3: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL3"
		end

	Log_local4: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL4"
		end

	Log_local5: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL5"
		end

	Log_local6: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL6"
		end

	Log_local7: INTEGER
			-- Reserved for local use
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_LOCAL7"
		end

feature {NONE} -- Windows Constants

	Log_application_event_log: INTEGER = 1
			-- Application Event Log

	Log_security_event_log: INTEGER = 2
			-- Security Event Log

	Log_system_event_log: INTEGER = 4
			-- System Event Log

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
