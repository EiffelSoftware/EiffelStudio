note
	description: "[
		Disables a webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_DISABLE_WEBAPP

inherit
	XC_SERVER_COMMAND
		rename
			make as make_no_parameter
		end
	XC_PARAMETER_CONTAINER

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Disables a webapp."
		end

	parameter_description: STRING
			-- <Precursor>
		do
			Result := "name"
		end

feature -- Status Change


feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.disable_webapp (parameter.value)
		end

end

