note
	description:	"Notion of a class that can do something"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	SOME_CLASS

inherit
	GLOBAL

create
	make

feature {NONE} -- Initialization

	make (i: INTEGER)
			-- Create `i'-th object
		do
			object_no := i
			log.suspend_all_logs
			log.resume_i_th_log (object_no + 1)
			log.write_information ("SOME_CLASS instantiated object no " + object_no.out)
			log.resume_all_logs
		end

feature -- Access

	do_something
		do
			log.suspend_all_logs
			log.resume_i_th_log (object_no + 1)
			log.write_information ("Object " + object_no.out + " - Running a lengthy operation")
			log.resume_all_logs
		end

feature {NONE} -- Attributes

	object_no: INTEGER;
			-- Object Number

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
