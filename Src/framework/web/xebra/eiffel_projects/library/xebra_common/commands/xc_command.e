note
	description: "[
		Interface for commands.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_COMMAND

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

	description: STRING
			-- Describes the command
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	execute (a_server: XC_SERVER_INTERFACE): XC_COMMAND_RESPONSE
			-- Executes the command.
		require
			a_server_attached: a_server /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end
end
