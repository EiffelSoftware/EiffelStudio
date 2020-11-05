note
	description: "[
		Cursors for remembering positions in graphs.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPH_CURSOR [G -> HASHABLE, L]

inherit
	CURSOR

create
	make

feature {NONE} -- Initialization

	make (a_node: detachable G; a_edge: detachable EDGE [G, L])
			-- Create a cursor for with attributes `a_node' and `a_edge'.
		require
			no_edge_when_off: (a_node = Void) implies (a_edge = Void)
		do
			current_node := a_node
			edge_item := a_edge
		ensure
			node_assigned: current_node = a_node
			edge_assigned: edge_item = a_edge
		end

feature {GRAPH} -- Access

	current_node: detachable G
			-- Node at the current cursor position

	edge_item: detachable EDGE [G, L]
			-- Edge which is currently focused

feature	{GRAPH} -- Change Element

	remove_edge_item
		do
			edge_item := Void
		end

invariant

	no_edge_when_off: (current_node = Void) implies (edge_item = Void)

end -- class GRAPH_CURSOR
