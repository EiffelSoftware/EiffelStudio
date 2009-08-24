note
	description: "[
		The error command response occuring if the command's parameter is of an invalid type.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_INVALID_PARAM_TYPE

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
			Result := "Parameter '" + name + "' is of an invalid type."
		end

invariant
	name_attached: name /= Void
end

