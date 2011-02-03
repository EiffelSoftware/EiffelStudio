note
	description:	"[
						Example application that illustrates the default FILE_LOG_WRITER and how
						one can simply override the default log file name in a new class, in this
						case MY_FILE_LOG_WRITER
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
			l_my_file_log_writer: LOG_WRITER_FILE
			claptrap: FILE_NAME
		do
				--| Initialize the logging facility
			create log.make

				--| Enable log output to go to the default file
			log.enable_default_file_log

				--| Write an informational message
			log.write_information ("The application is starting up...")

			create claptrap.make_from_string ("no_joy.log")
			create l_my_file_log_writer
			l_my_file_log_writer.set_file_name (claptrap)
			log.register_log_writer (l_my_file_log_writer)
			if l_my_file_log_writer.has_errors then
				log.enable_default_stderr_log
				log.write_emergency ("Cannot open log file '" + claptrap + "'%N")
			else
				log.write_information ("The application now uses this log file as well...%N")
			end
		end

feature {NONE} -- Attributes

	log: attached LOG_LOGGING_FACILITY;
			-- The general logging facility

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
