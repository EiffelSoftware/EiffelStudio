indexing
	description: "Supervisor for explain tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_TOOL_LIST

inherit
	EB_EDIT_TOOL_LIST [EB_EXPLAIN_TOOL]
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
		 	-- Initialize Current.
		do
			precursor
		end

end -- class EB_EXPLAIN_TOOL_LIST
