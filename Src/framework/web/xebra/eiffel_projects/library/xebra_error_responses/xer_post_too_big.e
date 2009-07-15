note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_POST_TOO_BIG

inherit
	X_ERROR_RESPONSE
	XER_SERVER

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			Result :=  "Input file exceeds maximum permitted file size."
		end

end

