indexing
	description: "Error if a class is overriden by multiple classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_MULOVER

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
			text := "Class "+a_class.as_upper+" is overriden by multiple classes."
		end

feature -- Access

	text: STRING


end
