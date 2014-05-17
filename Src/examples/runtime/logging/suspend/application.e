note
	description:	"[
						Example application that illustrates how one can use multiple classes to
						write to the same log writers at the same time
					]"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	APPLICATION

inherit
	GLOBAL

create
	make

feature {NONE} -- Initialization

	make
			-- Make an instance of APPLICATION, and run the application
		local
			something_1: SOME_CLASS
			something_2: SOME_CLASS
			file_name_1: PATH
			file_name_2: PATH
			log_file_1: LOG_WRITER_FILE
			log_file_2: LOG_WRITER_FILE
		do
				--| Enable stderr log output
			log.enable_default_stderr_log

				--| Write an informational message
			log.write_information ("The application is starting up...")

				--| Initialize some log writers

			create file_name_1.make_from_string ("something_1.log")
			create log_file_1.make_at_location (file_name_1)
			log_file_1.enable_debug_log_level
			create file_name_2.make_from_string ("something_2.log")
			create log_file_2.make_at_location (file_name_2)
			log_file_2.enable_debug_log_level
			log.register_log_writer (log_file_1)
			log.register_log_writer (log_file_2)

			log.write_information ("Starting to process application data...")

				--| Do something sensible (from an application perspective, that is)
			create something_1.make (1)
			create something_2.make (2)
			something_1.do_something
			something_2.do_something

				--| Wait here, so the user can see the generated output
			io.readline
		end

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
