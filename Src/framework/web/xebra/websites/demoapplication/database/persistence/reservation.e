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

	make (a_id: INTEGER; a_name: STRING;	a_date:  STRING; a_persons: INTEGER; a_description: STRING)
			-- Initialization for `Current'.
		do
			id := a_id
			name := a_name
			date:=  a_date
			persons:= a_persons
			description:= a_description
		end

feature -- Access

	id: INTEGER
	name: STRING
	date:  STRING
	persons: INTEGER
	description: STRING


end
