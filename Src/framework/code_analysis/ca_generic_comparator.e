note
	description: "Generic object comparator. The comparison function is provided as an agent."
	author: "Paolo Antonucci"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_GENERIC_COMPARATOR [G]

inherit
	COMPARATOR [G]
	redefine
		less_than
	end

create
	make_with_agent

feature -- Comparison

	less_than (u, v: G): BOOLEAN
			-- Is `u' less than `v'?
		do
			Result := compare_agent.item ([u, v])
		end

feature -- Implementation

	compare_agent: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]
			-- The comparison function

	make_with_agent (a_comparison_agent: FUNCTION [ANY, TUPLE [G, G], BOOLEAN])
		do
			compare_agent := a_comparison_agent
		end

end
