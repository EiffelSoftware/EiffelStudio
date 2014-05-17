note
	description:	"[
						Example application that illustrates how one can use multiple LOG_WRITERS
						at the same time
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
		do
				--| Initialize the logging facility
			create log.make

				--| Enable log output to go to the default file and enable the
				--| stderr log output
			log.enable_default_file_log
			log.default_log_writer_file.enable_debug_log_level
			log.enable_default_stderr_log
			log.default_log_writer_stderr.enable_debug_log_level

				--| Write an informational message
			log.write_information ("The application is starting up...")

			io.readline
		end

feature {NONE} -- Attributes

	log: LOG_LOGGING_FACILITY;
			-- General Eiffel log facility

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
