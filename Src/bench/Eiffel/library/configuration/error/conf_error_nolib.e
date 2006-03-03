indexing
	description: "A system was used as a library and has no library target."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_NOLIB

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_library: STRING) is
			-- Create
		do
			text := "A system was used as a library and has no library target: "+a_library
		end

feature -- Access

	text: STRING

end
