note
	description: "[
		Undirected graphs without commitment to a particular representation.
		Both simple graphs and multigraphs are supported.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNDIRECTED_GRAPH [G -> HASHABLE,  L]

inherit
	GRAPH [G, L]
		rename
			in_degree as degree,
			out_degree as degree
		export {NONE}
			is_dag
		redefine
			adopt_edge,
			put_edge,
			put_unlabeled_edge,
			has_edge_between,
			opposite_node,
			has_cycles,
			is_dag,
			is_eulerian
		end

feature -- Access

feature -- Measurement

feature -- Status report

	has_edge_between (a_start_node, a_end_node: like item): BOOLEAN
			-- Are `a_start_node' and `a_end_node' directly connected?
		deferred
		end

	has_cycles: BOOLEAN
			-- Does the graph contain cyclic paths?
			-- Note: Graph loops are considered to be cycles.
			-- Note 2: Multigraphs are currently not supported.
		do
			if is_simple_graph then
				-- Euler's formula for trees, applied to all components.
				Result := edge_count > (node_count - components)
			else
----- FIXME --- FIXME --- FIXME --- FIXME --- FIXME --- FIXME -----
				--| TODO: has_cycles on multi_graphs
				print ("{UNDIRECTED_GRAPH}.has_cycles:%N")
				print ("  multi_graphs are not supported.%N%N")
----- FIXME --- FIXME --- FIXME --- FIXME --- FIXME --- FIXME -----
			end
		end

	is_tree: BOOLEAN
			-- Is the graph a tree?
		require
			simple_graph: is_simple_graph
		do
			-- A connected simple graph without cycles is a tree.
			Result := is_connected and not has_cycles
		end

	is_eulerian: BOOLEAN
			-- Can the whole graph be drawn with a single closed line without lifting the pencil?
		local
			node_list: like linear_representation
			c: like cursor
		do
			-- Make backup of `cursor' if necessary.
			if not off then
				c := cursor
			end

			-- Definition: A graph is Eularian iff it is connected and all nodes have even degree.
			Result := is_connected
			node_list := linear_representation
			from
				node_list.start
			until
				not Result or node_list.after
			loop
				search (node_list.item)
				Result := Result and (degree \\ 2) = 0
----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
				debug ("is_eulerian")
					print ("is_eulerian: degree of `")
					print (item)
					print ("' = ")
					print (degree)
					print ("%N")
				end
----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
				node_list.forth
			end

			-- Restore cursor.
			if c /= Void then
				go_to (c)
			else
				invalidate_cursor
			end
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put_edge (a_start_node, a_end_node: like item; a_label: detachable L)
			-- Create an edge between `a_start_node' and `a_end_node'
			-- and set its label to `a_label'.
			-- The cursor is not moved.
		deferred
		ensure then
			undirected_graph: has_edge_between (a_start_node, a_end_node) and has_edge_between (a_end_node, a_start_node)
			edge_count: edge_count = old edge_count + 1
		end

	put_unlabeled_edge (a_start_node, a_end_node: like item)
			-- Create an edge between `a_start_node' and `a_end_node'.
			-- The cursor is not moved.
		local
			l: L
		do
			put_edge (a_start_node, a_end_node, l)
		ensure then
			undirected_graph: has_edge_between (a_start_node, a_end_node) and has_edge_between (a_end_node, a_start_node)
			edge_count: edge_count = old edge_count + 1
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature {NONE} -- Inapplicable

	is_dag: BOOLEAN = False
			-- Is `Current' a directed acyclic graph?

feature {NONE} -- Implementation

	adopt_edge (a_edge: EDGE [like item, L])
			-- Put `a_edge' into current graph.
		do
			put_edge (a_edge.start_node, a_edge.end_node, a_edge.label)
		end

	opposite_node (a_edge: like edge_item; a_node: like item): like item
			-- End node of `a_edge' when `a_node' is the start node
		do
			check attached a_edge as l_edge  then
				Result := a_edge.opposite_node (a_node)
			end
		end

end -- class UNDIRECTED_GRAPH
