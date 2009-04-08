note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	RESERVATION

create
	make

feature {NONE} -- Initialization

	make (a_id: STRING; a_name: STRING;	a_date:  STRING; a_persons: STRING; a_description: STRING)
			-- Initialization for `Current'.
		do
			id := a_id
			name := a_name
			date:=  a_date
			persons:= a_persons.out
			descripion:= a_description
		end

feature -- Access

	id: STRING
	name: STRING
	date:  STRING
	persons: STRING
	descripion: STRING


end
