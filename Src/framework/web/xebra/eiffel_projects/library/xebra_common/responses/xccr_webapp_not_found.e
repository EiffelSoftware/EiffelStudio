note
	description: "[
		The error command response that occurs if the server cannot find a given webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_WEBAPP_NOT_FOUND

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
			Result := "Webapp '" + name + "' could not be found."
		end

invariant
	name_attached: name /= Void
end

