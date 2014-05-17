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

	THREAD_CONTROL

create
	make

feature {NONE} -- Initialization

	make
			-- Make an instance of APPLICATION, and run the application
		local
			thread1: THREAD1
			thread2: THREAD2
			filename: PATH
			lw_file: LOG_WRITER_FILE
		do
				--| Enable stderr log output
			log.enable_default_file_log
			log.default_log_writer_file.enable_debug_log_level
			create filename.make_from_string ("thread1.log")
			create lw_file.make_at_location (filename)
			lw_file.enable_debug_log_level
			log.register_log_writer (lw_file)
			create filename.make_from_string ("thread2.log")
			create lw_file.make_at_location (filename)
			lw_file.enable_debug_log_level
			log.register_log_writer (lw_file)

				--| Write an informational message
			log.write_information ("The application is starting up...")

				--| Do something sensible (from an application perspective, that is)
			create thread1.make
			create thread2.make
			thread1.launch
			thread2.launch
			join_all

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
