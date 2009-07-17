note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_BAD_RESPONSE

inherit
	X_ERROR_RESPONSE
	XER_SERVER

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			Result := "Cannot recieve response from web application '" + arg + "'"
		end

end
