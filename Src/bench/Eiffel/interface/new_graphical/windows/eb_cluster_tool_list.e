indexing
	description: "Supervisor for explain tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTER_TOOL_LIST

inherit
	EB_TEXT_TOOL_LIST [EB_CLUSTER_TOOL]
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

end -- class EB_CLUSTER_TOOL_LIST
