note
	description:	"[
						Example application that illustrates the basic behavior of LOG_ROLLING_WRITER_FILE
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
			l_my_file_log_writer: LOG_ROLLING_WRITER_FILE
			i: INTEGER
		do
				--| Initialize the logging facility
			create log.make

			create l_my_file_log_writer.make_at_location ((create {PATH}.make_current).extended("test.log"))
			l_my_file_log_writer.set_max_file_size ({NATURAL_64}256*256)
			l_my_file_log_writer.set_max_backup_count (2)
				-- Enable this line to log at DEBUG level, log by default at ERROR level.			
				-- l_my_file_log_writer.enable_debug_log_level
			log.register_log_writer (l_my_file_log_writer)
			from
				i := 10000
			until
				i = 0
			loop
				log.write_emergency ("[
									Example application that illustrates the basic behavior of LOG_ROLLING_WRITER_FILE  and how to use it  
									]" + " Index: " + i.out)
				log.write_error ("[
									Example application that illustrates the basic behavior of LOG_ROLLING_WRITER_FILE  and how to use it  
									]" + " Index: " + i.out)
				
				log.write_information ("[
						Example application that illustrates the basic behavior of LOG_ROLLING_WRITER_FILE  and how to use it
						]" + " Index: " + i.out)
				log.write_debug ("[
						Example application that illustrates the basic behavior of LOG_ROLLING_WRITER_FILE  and how to use it 
						]" + " Index: " + i.out)

				i := i - 1
			end

		end

feature {NONE} -- Attributes

	log: LOG_LOGGING_FACILITY;
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
