note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XER_CANNOT_CONNECT

inherit
	XER_SERVER

create
	make

feature -- Access

	message: STRING
			-- <Precursor>
		do
			Result := "Cannot connect to web application '" + arg + "'"
		end

end
