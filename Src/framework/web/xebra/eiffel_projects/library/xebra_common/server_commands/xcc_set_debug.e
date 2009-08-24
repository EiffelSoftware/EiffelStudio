note
	description: "[
		Sets a debug level to the server.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"
class
	XCC_SET_DEBUG

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
			Result := "Sets a debug level (overrides debug level from arguments)."
		end

	parameter_description: STRING
			-- <Precursor>
		do
			Result := "debug_level"
		end

feature -- Status Change


feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.set_debug_level (parameter.value)
		end

end

