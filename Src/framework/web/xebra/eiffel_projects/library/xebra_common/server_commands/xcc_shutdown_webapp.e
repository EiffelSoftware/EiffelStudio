note
	description: "[
		Shuts down a webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_SHUTDOWN_WEBAPP

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
			Result := "Shuts down a webapp."
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
			Result := a_server.shutdown_webapp (parameter.value)
		end

end

