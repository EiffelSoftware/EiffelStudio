note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_CANNOT_FIND_PAGE

inherit
	X_ERROR_RESPONSE
	XER_APP

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			if arg.is_empty then
				arg := " "
			end
			Result := "Cannot find page '" + arg + "' "
		end

end
