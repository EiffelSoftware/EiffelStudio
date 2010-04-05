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
			"C [macro <syslog.h>]"
		alias
			"return LOG_EMERG;"
		end

	Log_alert: INTEGER
			-- Action must be taken immediately
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_ALERT;"
		end

	Log_crit: INTEGER
			-- Critical conditions
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_CRIT;"
		end

	Log_err: INTEGER
			-- Error conditions
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_ERR;"
		end

	Log_warning: INTEGER
			-- Warning conditions
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_WARNING;"
		end

	Log_notice: INTEGER
			-- Normal but significant condition
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_NOTICE;"
		end

	Log_info: INTEGER
			-- Informational
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_INFO;"
		end

	Log_debug: INTEGER
			-- Debug-level messages
		external
			"C [macro <syslog.h>]"
		alias
			"return LOG_DEBUG;"
		end

note
	copyright:	"Copyright (c) 2010, ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, UK
					Telephone 44-800-678-3248 Fax 44-208-742-3468
					Website http://www.itpassion.com
					Customer support https://powerdesk.itpassion.com
				]"

end
