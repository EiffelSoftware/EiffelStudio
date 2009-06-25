note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_GET_SESSIONS

inherit
	XC_COMMAND_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_sessions: NATURAL)
			-- Initialization for `Current'.
		do
			sessions := a_sessions
		end

feature -- Access

	sessions: NATURAL


end

