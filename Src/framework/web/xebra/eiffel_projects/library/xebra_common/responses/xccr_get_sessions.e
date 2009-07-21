note
	description: "[
		The command response that contains the number of sessions.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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

