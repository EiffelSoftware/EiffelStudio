note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_GENERAL

inherit
	X_ERROR_RESPONSE

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			Result := arg
		end

end
