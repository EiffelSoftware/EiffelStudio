note
	description: "[
		Represents a specific response
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_APP_COMPILING

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
			Result := "Application '" + arg + "' is compiling..."
		end

		has_refresh: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end
end

