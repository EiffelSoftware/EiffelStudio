indexing
	description: "Error if an override itself is overriden."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_OVERRIDE

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_group: STRING) is
			-- Create.
		do
			text := "An override was overriden: "+a_group
		end

feature -- Access

	text: STRING


end
