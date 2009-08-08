note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_INTERNAL_SERVER_ERROR

inherit
	X_ERROR_RESPONSE
	XER_SERVER

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			Result :=  "Internal Server Error"
		end

end
