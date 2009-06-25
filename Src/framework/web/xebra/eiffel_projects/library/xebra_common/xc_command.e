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
			-- Describes the command.
		deferred
		ensure
			result_attached: Result /= Void
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

