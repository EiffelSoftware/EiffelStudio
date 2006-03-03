indexing
	description: "Assembly open error."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_ASOP

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (an_assembly: STRING) is
			-- Create.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			text := "Assembly open error: "+an_assembly
		end


feature -- Access

	text: STRING


end
