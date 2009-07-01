note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_APP_STARTING

inherit
	X_INFO_RESPONSE
		redefine
			has_refresh
		end
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
			Result := "Application '" + arg + "' is starting..."
		end

	has_refresh: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

end
