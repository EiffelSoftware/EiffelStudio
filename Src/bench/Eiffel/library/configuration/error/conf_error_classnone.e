indexing
	description: "Class called NONE."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CLASSNONE

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Creation

	make (a_file: STRING) is
			-- Create.
		require
			a_file_not_void: a_file /= Void
		do
			text := "Class with illegal name NONE in "+a_file+"."
		end

feature -- Access

	text: STRING

end
