indexing
	description:
		"All shared attributes specific to the explain tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_TOOL_DATA

feature -- Access

	Explain_Resources: EB_EXPLAIN_PARAMETERS is
			-- Explain tool specific parameters
		once
			create Result.make
		end

end -- class EB_EXPLAIN_TOOL_DATA
