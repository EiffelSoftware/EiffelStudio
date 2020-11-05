note
	description: "[
		Graph nodes used for the LINKED_GRAPH data structure.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_GRAPH_NODE [G -> HASHABLE, L]

inherit
	NODE [G, L]
		redefine
			make,
			item
		end

create
	make

feature {NONE} -- Initialization

	make (a_item: G)
			-- Make a new linked graph node.
		do
			Precursor (a_item)
			create edge_list.make
		ensure then
			no_neighbors: edge_list.is_empty
		end

feature -- Access

	item: G
			-- Item value

feature {LINKED_GRAPH} -- Access

	edge_list: TWO_WAY_CIRCULAR [LINKED_GRAPH_EDGE [G, L]]
			-- List of all incident edges.

feature -- Measurement

	out_degree: INTEGER
			-- Number of outgoing edges of `item'
		do
			Result := edge_list.count
		end

feature -- Cursor movement

	turn_to (a_node: LINKED_GRAPH_NODE [G, L])
			-- Turn to the edge where `a_node' is the opposite node.
		require
			node_not_void: a_node /= Void
		local
			found: BOOLEAN
		do
			from
				edge_list.start
			until
				found or edge_list.after
			loop
				if edge_list.item.internal_end_node = a_node then
					found := True
				else
					edge_list.forth
				end
			end
		end

feature -- Element change

	put_edge (a_edge: LINKED_GRAPH_EDGE [G, L]) 
			--
		require
			incident_node: item = a_edge.start_node or item = a_edge.end_node
		do
			edge_list.extend (a_edge)
		ensure
			edge_inserted: edge_list.has (a_edge)
			increased_degree: out_degree = old out_degree + 1
		end

invariant

	item_not_void: item /= Void

end -- class LINKED_GRAPH_NODE
