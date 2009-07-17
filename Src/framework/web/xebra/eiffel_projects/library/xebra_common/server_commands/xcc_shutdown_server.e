note
	description: "[
		Shuts down the server.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCC_SHUTDOWN_SERVER

inherit
	XC_SERVER_COMMAND

create
	make

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Shuts down the server."
		end

feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			Result := a_server.shutdown_server
		end
end
