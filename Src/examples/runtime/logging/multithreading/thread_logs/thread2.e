note
	description:	"Notion of a class that can do something"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	THREAD2

inherit
	THREAD
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		local
			filename: PATH
			lw_file: LOG_WRITER_FILE
		do
			Precursor
			create log.make
			create filename.make_from_string ("thread2.log")
			create lw_file.make_at_location (filename)
			lw_file.enable_debug_log_level
			log.register_log_writer (lw_file)
			log.write_information ("THREAD2 instantiated")
		end

feature -- Access

	execute
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = 100
			loop
				log.write_information ("Running a lengthy operation in THREAD2")
				i := i + 1
			end
			log.write_information ("THREAD2 is finished")
		end

feature {NONE} -- Attributes

	log: LOG_LOGGING_FACILITY;
			-- This threads logging facility

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
