note
	description: "[
		Interface for server commands.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_SERVER_COMMAND

inherit
	XC_COMMAND
		redefine
			execute
		end

feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>
		deferred
		end
end
