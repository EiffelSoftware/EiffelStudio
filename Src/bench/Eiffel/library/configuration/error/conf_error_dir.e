indexing
	description: "File open error."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_DIR

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_dir: STRING) is
			-- Create.
		require
			a_dir_not_void: a_dir /= Void
		do
			text := "Directory open error: "+a_dir
		end


feature -- Access

	text: STRING


end
