note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_CANNOT_FIND_APP

inherit
	X_ERROR_RESPONSE

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			if arg.is_empty then
				arg := " "
			end
			Result := "Cannot find web application '" + arg + "' "
		end
end
