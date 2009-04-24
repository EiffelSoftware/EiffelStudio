note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_CANNOT_COMPILE_APP

inherit
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
			Result := "Cannot compile application '" + arg + "' "
		end
end
