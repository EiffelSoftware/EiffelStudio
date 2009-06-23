note
	description: "[
		Re-launches a server module.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_RELAUNCH_MOD

inherit
	XS_PARAMETER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Re-launches a server module."
		end

	parameter_description: STRING
			-- <Precursor>
		do
			Result := "name"
		end


feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.relaunch_module (parameter.value)
		end

end

