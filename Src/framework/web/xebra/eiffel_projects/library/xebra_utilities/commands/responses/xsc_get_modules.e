note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_GET_MODULES

inherit
	XS_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Displays the available modules."
		end


feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE): XS_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.get_modules
		end

end

