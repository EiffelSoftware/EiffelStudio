note
	description: "[
		Interface for commands.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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
			-- Describes the command.
		deferred
		ensure
			result_attached: Result /= Void
		end

	has_response: BOOLEAN
			-- Defines whether this command expects a response
		do
			Result := True
		end

feature -- Basic operations

	execute (a_platform: ANY): XC_COMMAND_RESPONSE
			-- Executes the command.
		require
			a_platform_attached: a_platform /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end


end

