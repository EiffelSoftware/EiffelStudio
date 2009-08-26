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
			Result := "Sets a debug level (overrides debug level from arguments):%N%T1: Start and stop of overall application" +
														  "%N%T2: Application configuration" +
														  "%N%T3: Start and stop of main components" +
														  "%N%T4: Information about tasks that are performed" +
														  "%N%T5: Information about subtasks that are performed" +
														  "%N%T6: Very verbose information about subtasks that are performed."
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

