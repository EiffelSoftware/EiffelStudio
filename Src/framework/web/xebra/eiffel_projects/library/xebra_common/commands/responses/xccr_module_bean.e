note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_MODULE_BEAN

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_launched: BOOLEAN; a_running: BOOLEAN)
			-- Initialization for `Current'.
		do
			name := a_name
			launched := a_launched
			running := a_running
		end

feature -- Access
	name: STRING
	launched: BOOLEAN
	running: BOOLEAN

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

