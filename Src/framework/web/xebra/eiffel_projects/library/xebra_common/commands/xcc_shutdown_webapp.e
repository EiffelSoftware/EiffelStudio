note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_SHUTDOWN_WEBAPP

inherit
	XS_PARAMETER_COMMAND

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
			Result := "webapp_name"
		end

feature -- Status Change


feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.shutdown_webapp (parameter.value)
		end

end

