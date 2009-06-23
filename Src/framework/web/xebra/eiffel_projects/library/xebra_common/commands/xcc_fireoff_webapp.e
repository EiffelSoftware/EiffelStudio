note
	description: "[
		Sends shutdown signal even if the webapp process is not owned by the server.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_FIREOFF_WEBAPP

inherit
	XS_PARAMETER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Sends shutdown signal even if the webapp process is not owned by the server."
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

