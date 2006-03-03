indexing
	description: "Error if there was no class in a file where a class was expected."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CLASSN

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
			text := "Classfile without a class in "+a_file
		end

feature -- Access

	text: STRING

end
