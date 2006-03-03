indexing
	description: "File open error."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_FILE

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_file: STRING) is
			-- Create.
		require
			a_file_not_void: a_file /= Void
		do
			text := "File open error: "+a_file
		end


feature -- Access

	text: STRING


end
