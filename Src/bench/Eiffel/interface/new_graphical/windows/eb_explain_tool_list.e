indexing
	description: "Supervisor for explain tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_TOOL_LIST

obsolete
	"The explain tool is obsolete."

inherit
	EB_TEXT_TOOL_LIST [EB_EXPLAIN_TOOL]
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
