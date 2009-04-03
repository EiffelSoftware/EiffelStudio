note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	MY_RESERVATION

create
	make

feature {NONE} -- Initialization

	make (	a_name: STRING;
	a_date:  STRING;
	a_persons: INTEGER)
			-- Initialization for `Current'.
		do
			name := a_name
			date:=  a_date
			persons:= a_persons.out
			descripion:= "LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONG TEXT"
		end

feature -- Access
	name: STRING
	date:  STRING
	persons: STRING
	descripion: STRING
feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
