note
	description:	"Notion of a class that can do something"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class
	THREAD1

inherit
	GLOBAL
		undefine
			default_create
		end

	THREAD
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			log.write_information ("THREAD1 instantiated")
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
				log.write_information ("Running a lengthy operation in THREAD1")
				i := i + 1
			end
			log.write_information ("THREAD1 is finished")
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
