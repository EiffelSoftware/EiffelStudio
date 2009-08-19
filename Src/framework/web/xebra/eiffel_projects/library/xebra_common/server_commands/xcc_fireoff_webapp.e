note
	description: "[
		Sends shutdown signal even if the webapp process is not owned by the server.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_FIREOFF_WEBAPP

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
			Result := "Sends shutdown signal directly to webapp."
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
			Result := a_server.fire_off_webapp (parameter.value)
		end

end

