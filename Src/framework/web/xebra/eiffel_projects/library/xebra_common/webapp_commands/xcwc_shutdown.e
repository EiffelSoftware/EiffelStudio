note
	description: "[
		Shuts down a webapp.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCWC_SHUTDOWN
inherit
	XC_WEBAPP_COMMAND
		redefine
			has_response
		end
create
	make

feature -- Access

	has_response: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end


	description: STRING
			-- <Precursor>
		do
			Result := "Shuts down a webapp."
		end

feature -- Basic operations

	execute (a_webapp: XC_WEBAPP_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_webapp.shutdown
		end
end

