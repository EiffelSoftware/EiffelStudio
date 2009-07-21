note
	description: "[
		Empty command that does nothing.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCWC_EMPTY

inherit
	XC_WEBAPP_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Does nothing"
		end

feature -- Basic operations

	execute (a_webapp: XC_WEBAPP_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := create {XCCR_OK}
		end
end
