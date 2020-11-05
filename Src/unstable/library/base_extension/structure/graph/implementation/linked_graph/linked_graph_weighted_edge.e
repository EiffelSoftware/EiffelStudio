note
	description: "[
		Weighted graph edges used for the LINKED_GRAPH data structure.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_GRAPH_WEIGHTED_EDGE [G -> HASHABLE, L]

inherit
	WEIGHTED_EDGE [G, L]
		rename
			make_directed as weighted_edge_make_directed,
			make_undirected as weighted_edge_make_undirected
		export {NONE}
			weighted_edge_make_directed,
			weighted_edge_make_undirected
		end

	LINKED_GRAPH_EDGE [G, L]
		rename
			make_directed as unweighted_make_directed,
			make_undirected as unweighted_make_undirected
		export {NONE}
			unweighted_make_directed,
			unweighted_make_undirected
		undefine
			is_equal,
			out
		end

create
	make_directed, make_undirected

feature {NONE} -- Initialization

	make_directed (a_start_node, a_end_node: LINKED_GRAPH_NODE [G, L]; a_label: detachable L; a_weight: REAL_64)
			-- Make a directed labeled edge from two nodes with weight `a_weight'.
		do
			unweighted_make_directed (a_start_node, a_end_node, a_label)
			user_defined_weight_function := False
			internal_weight := a_weight
		ensure then
			weight_set: weight = a_weight
			default_weight_function: not user_defined_weight_function
		end

	make_undirected (a_start_node, a_end_node: LINKED_GRAPH_NODE [G, L]; a_label: detachable L; a_weight: REAL_64)
			-- Make an undirected labeled edge from two nodes with weight `a_weight'.
		do
			unweighted_make_undirected (a_start_node, a_end_node, a_label)
			user_defined_weight_function := False
			internal_weight := a_weight
		ensure then
			weight_set: weight = a_weight
			default_weight_function: not user_defined_weight_function
		end

end -- class LINKED_GRAPH_WEIGHTED_EDGE
