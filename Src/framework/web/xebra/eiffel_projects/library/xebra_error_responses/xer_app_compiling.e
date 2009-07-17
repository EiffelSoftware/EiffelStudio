note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_INVALID_COMMAND

inherit
	X_INFO_RESPONSE
	XER_SERVER

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do			
			Result := "Invalid command."
		end

end

