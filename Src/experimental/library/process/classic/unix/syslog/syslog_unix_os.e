note
	description: "Unix-specific syslog abstraction with automatic closing of open syslog connections"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SYSLOG_UNIX_OS

inherit
	DISPOSABLE
		export
			{NONE} all
		end

	SYSLOG_FACILITY_CONST

	SYSLOG_OPTION_CONST

	SYSLOG_PRIORITY_CONST

create
	open_log

feature {NONE} -- Creation

	open_log (identifier: STRING; option: INTEGER; facility: INTEGER)
			-- Open the system log for program `identifier', with `option', for
			-- logging into `facility'
		require
			valid_identifier: identifier /= Void and then not identifier.is_empty
			valid_facility: facility >= Log_kern and then facility <= Log_local7
			valid_option: option >= Log_pid and then option <= Log_perror
		local
			l_c_string: C_STRING
		do
			create l_c_string.make (identifier)
			c_open_log (l_c_string.item, option, facility)
		end

feature {NONE} -- Access

	sys_log (priority: INTEGER; log_string: STRING)
			-- Log `log_string' in the system's logging facility using
			-- `priority'
		require
			valid_log_string: log_string /= Void and then not log_string.is_empty
		local
			l_c_string: C_STRING
		do
			create l_c_string.make (log_string)
			c_sys_log (priority, l_c_string.item)
		end

feature {NONE} -- Removal

	dispose
			-- Close the system logger
		do
			c_close_log
		end

feature {NONE} -- Externals

	c_close_log
			-- External C Call to `closelog'
		external
			"C inline use <syslog.h>"
		alias
			"closelog();"
		end

	c_open_log (identifier: POINTER; option: INTEGER; facility: INTEGER)
			-- External C Call to `openlog'
		external
			"C inline use <syslog.h>"
		alias
			"openlog((const char *) $identifier, $option, $facility);"
		end

	c_sys_log (priority: INTEGER; format: POINTER)
			-- External C Call to `syslog'
		external
			"C inline use <syslog.h>"
		alias
			"syslog($priority, %"%%s%", (const char *) $format);"
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
