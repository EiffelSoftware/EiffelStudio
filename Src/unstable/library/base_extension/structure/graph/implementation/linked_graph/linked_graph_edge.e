note
	description: "[
		Graph edges used for the LINKED_GRAPH data structure.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_GRAPH_EDGE [G -> HASHABLE, L]

inherit
	EDGE [G,L]
		rename
			make_directed as old_make_directed,
			make_undirected as old_make_undirected
		export {NONE}
			old_make_directed,
			old_make_undirected
		end

create
	make_directed, make_undirected

feature {NONE} -- Initialization

	make_directed (a_start_node, a_end_node: LINKED_GRAPH_NODE [G, L]; a_label: detachable L)
			-- Make a directed edge from `a_start_node' to `a_end_node' with label `a_label'.
		require
			nodes_not_void: a_start_node /= Void and a_end_node /= Void
		do
			internal_start_node := a_start_node
			start_node := a_start_node.item
			internal_end_node := a_end_node
			end_node := a_end_node.item
			label := a_label
			is_directed := True
		ensure
			nodes_not_void: start_node /= Void and
							end_node /= Void
			nodes_assigned: start_node = a_start_node.item and
							end_node = a_end_node.item
			label_set: label = a_label
			is_directed: is_directed
		end

	make_undirected (a_start_node, a_end_node: LINKED_GRAPH_NODE [G, L]; a_label: detachable L)
			-- Make an undirected edge from `a_start_node' to a_end_node' with label `a_label'.
		require
			nodes_not_void: a_start_node /= Void and a_end_node /= Void
		do
			internal_start_node := a_start_node
			start_node := a_start_node.item
			internal_end_node := a_end_node
			end_node := a_end_node.item
			label := a_label
			is_directed := False
		ensure
			nodes_not_void: start_node /= Void and
							end_node /= Void
			nodes_assigned: start_node = a_start_node.item and
							end_node = a_end_node.item
			label_set: label = a_label
			not_directed: not is_directed
		end

feature {LINKED_GRAPH, LINKED_GRAPH_NODE} -- Access

	internal_start_node: LINKED_GRAPH_NODE [G, L]
			-- Start node (linked graph)

	internal_end_node: LINKED_GRAPH_NODE [G, L]
			-- End node (linked graph)

	opposite (a_node: LINKED_GRAPH_NODE [G, L]): LINKED_GRAPH_NODE [G, L]
			-- Opposite node of `a_linked_node' in an undirected graph
		require
			undirected: not is_directed
			incident_node: a_node = internal_start_node or a_node = internal_end_node
		do
			if a_node = internal_start_node then
				Result := internal_end_node
			else
				Result := internal_start_node
			end
		end

end -- class LINKED_GRAPH_EDGE
