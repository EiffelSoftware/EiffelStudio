note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_name: STRING; a_password: STRING; a_is_admin: BOOLEAN)
			-- Initialization for `Current'.
		do
			id := a_id
			name:= a_name
			password:= a_password
			is_admin:= a_is_admin
		end

feature -- Access

	id: INTEGER
	name: STRING
	password: STRING
	is_admin: BOOLEAN


end
