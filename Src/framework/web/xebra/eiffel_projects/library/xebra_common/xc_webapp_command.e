note
	description: "[
		Interface for server commands.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_WEBAPP_COMMAND

inherit
	XC_COMMAND
	redefine
		execute
	end



feature -- Basic operations

	execute (a_webapp: XC_WEBAPP_INTERFACE): XC_COMMAND_RESPONSE
			-- <Precursor>
		deferred
		end
end
