note
	description:	"Notion of a class that can do something"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	SOME_CLASS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create log.make
			log.enable_default_file_log
			log.default_log_writer_file.enable_debug_log_level
			log.write_information ("SOME_CLASS instantiated")
		end

feature -- Access

	do_something
		do
			log.write_information ("Running a lengthy operation")
		end

feature {NONE} -- Attributes

	log: LOG_LOGGING_FACILITY;

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
