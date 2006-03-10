indexing
	description: "Renaming for a non existing class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_RENAM

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_class: STRING) is
			-- Create.
		require
			a_class_not_void: a_class /= Void
		do
			text := "Renaming for a non existing class: "+a_class
		end


feature -- Access

	text: STRING


end
