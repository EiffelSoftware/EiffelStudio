note
	description: "[
		The error command response that occurs if a invalid command was to be executed on an unmanaged webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_INVALID_CMD_UNMANAGED

inherit
	XCCR_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initialization for `Current'.
		require
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name ~ a_name
		end

feature -- Access

	name: STRING

	description: STRING
			-- Describes the error
		do
			Result := "This command cannot be executed on the unmanaged webapp '" + name + "'."
		end

invariant
	name_attached: name /= Void
end

