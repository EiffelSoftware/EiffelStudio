note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_COMPILING_FAILED

inherit
	X_ERROR_RESPONSE
	XER_SERVER

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			if arg.is_empty then
				arg := " "
			end
			Result := "Failed to compile web application '" + arg + "' "
		end

end

