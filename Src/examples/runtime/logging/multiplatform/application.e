note
	description:	"[
						Example application that illustrates how one can use the syslog daemon on
						Unix and the Windows Event Log with one source code
					]"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Make an instance of APPLICATION, and run the application
		local
			l_sys_log: LOG_WRITER_SYSTEM
		do
				--| Initialize the logging facility
			create log.make

				--| TODO This is then the new way, because of void-safety, we can already
				--| access the default_log_writer_system, change it's application name, and
				--| simply use it through enable_default_system_log
--			log.default_log_writer_system.set_application_name ("MultiPlatform")
--			log.enable_default_system_log

				--| Enable system log output
			create l_sys_log
			l_sys_log.enable_debug_log_level
			l_sys_log.set_application_name ("MultiPlatform")
			log.register_log_writer (l_sys_log)

				--| Write an informational message
			log.write_information ("The application is starting up...")
		end

feature {NONE} -- Attributes

	log: LOG_LOGGING_FACILITY;
			-- General Eiffel Logging Facility

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
