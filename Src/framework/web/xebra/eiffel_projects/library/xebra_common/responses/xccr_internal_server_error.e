note
	description: "[
		The error command response that occurs if there was an internal server error.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_INTERNAL_SERVER_ERROR

inherit
	XCCR_ERROR

feature -- Access

	description: STRING
			-- <Precursor>
		do
			Result := "Internal Server Error."
		end

end

