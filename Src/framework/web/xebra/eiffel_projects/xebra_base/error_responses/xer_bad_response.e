note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_BAD_RESPONSE

inherit
	X_ERROR_RESPONSE

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			Result := "Cannot recieve response from web application '" + arg + "'"
		end

end
