note
	description: "[
		Retrieves the number of sessions.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCWC_GET_SESSIONS

inherit
	XC_WEBAPP_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Retrieves the number of sessions of a webapp."
		end

feature -- Basic operations

	execute (a_webapp: XC_WEBAPP_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_webapp.get_sessions
		end

end

