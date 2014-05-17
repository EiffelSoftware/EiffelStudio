note
	description:	"[
						Example application that illustrates how one can use multiple threads each
						having their own LOG_LOGGING_FACILITY
					]"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	APPLICATION

inherit
	THREAD_CONTROL

create
	make

feature {NONE} -- Initialization

	make
			-- Make an instance of APPLICATION, and run the application
		local
			thread1: THREAD1
			thread2: THREAD2
			log: LOG_LOGGING_FACILITY
		do
				--| Enable stderr log output
			create log.make
			log.enable_default_file_log
			log.default_log_writer_file.enable_debug_log_level

				--| Write an informational message
			log.write_information ("The application is starting up...")

				--| Do something sensible (from an application perspective, that is)
			create thread1.make
			create thread2.make
			thread1.launch
			thread2.launch
			join_all
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
