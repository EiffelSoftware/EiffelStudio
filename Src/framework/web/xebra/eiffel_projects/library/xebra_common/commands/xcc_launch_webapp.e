note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_LAUNCH_WEBAPP

inherit
	XS_PARAMETER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "(Re)-Translates, compiles and launches a webapp."
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
			Result := a_server.launch_webapp (parameter.value)
		end

end
