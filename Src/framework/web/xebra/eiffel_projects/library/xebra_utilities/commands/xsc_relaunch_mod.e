note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_RELAUNCH_MOD

inherit
	XS_PARAMETER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Relaunches a server module."
		end

	parameter_description: STRING
			-- <Precursor>
		do
			Result := "name"
		end


feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE): XS_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.relaunch_module (parameter.value)
		end

end

