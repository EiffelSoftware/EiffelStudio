note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_WEBAPP_NOT_FOUND

inherit
	XCCR_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initialization for `Current'.
		require
			
		do
			name := a_name
		ensure
			name_set: equal (name, a_name)
		end

feature -- Access

	name: STRING

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

