note
	description: "Skeleton for a fixed point iteration through a CFG."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_CFG_ITERATOR

feature -- Iteration

	process_cfg (a_cfg: attached CA_CONTROL_FLOW_GRAPH)
			-- Iterate through `a_cfg'.
		deferred
		end

	visit_edge (a_from, a_to: attached CA_CFG_BASIC_BLOCK): BOOLEAN
			-- Visit edge from `a_from' to `a_to'. Continue iteration iff Result is
			-- true.
		deferred
		end

	initialize_processing (a_cfg: attached CA_CONTROL_FLOW_GRAPH)
			-- Perform initialization before running the worklist algorithm.
		deferred
		end

feature {NONE} -- Implementation

	worklist: LINKED_QUEUE [TUPLE [fr, to: CA_CFG_BASIC_BLOCK]]
		-- Worklist with nodes whose processing is still due.

end
