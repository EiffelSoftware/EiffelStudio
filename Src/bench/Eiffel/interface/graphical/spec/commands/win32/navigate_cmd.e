indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAVIGATE_CMD

inherit
	COMMAND

creation
	make

feature -- creation

	make (other: TEXT_FIELD) is
		do
		end

	imp: TEXT_FIELD_IMP

feature -- Execution

	execute (argument: ANY) is
		do
		end;

end -- class NAVIGATE_CMD
