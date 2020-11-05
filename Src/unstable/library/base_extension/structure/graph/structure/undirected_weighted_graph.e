note
	description: "[
		Undirected weighted graphs without commitment to
		a particular representation.
		Both simple graphs and multigraphs are supported.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNDIRECTED_WEIGHTED_GRAPH [G -> HASHABLE, L]

inherit
	UNDIRECTED_GRAPH [G, L]
		rename
			put_edge as put_unweighted_edge,
			put_unlabeled_edge as put_unweighted_unlabeled_edge,
			edge_from_values as unweighted_edge_from_values
		export {NONE}
			put_unweighted_unlabeled_edge,
			unweighted_edge_from_values
		undefine
			edge_length
		redefine
			adopt_edge,
			degree
		end

	WEIGHTED_GRAPH [G, L]
		rename
			in_degree as degree,
			out_degree as degree
		export {NONE}
			is_dag
		undefine
			components,
			put_unweighted_edge,
			put_unweighted_unlabeled_edge,
			has_cycles,
			is_dag,
			is_connected,
			is_eulerian,
			opposite_node
		redefine
			adopt_edge,
			edge_item,
			degree,
			put_edge,
			put_unlabeled_edge
		end

feature -- Access

	edge_item: detachable WEIGHTED_EDGE [like item, L]
			-- Current edge
		deferred
		end

feature -- Measurement

	degree: INTEGER
			-- Number of edges attached to `item'
		do
			Result := Precursor {UNDIRECTED_GRAPH}
		end

feature -- Status report

	has_edge_between (a_start_node, a_end_node: like item): BOOLEAN
			-- Are `a_start_node' and `a_end_node' directly connected?
		deferred
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put_edge (a_start_node, a_end_node: like item; a_label: detachable L; a_weight: REAL_64)
			-- Create an edge with weight `a_weight' between `a_start_node' and `a_end_node'.
			-- The edge will be labeled `a_label'.
			-- The cursor is not moved.
		deferred
		ensure then
			undirected_graph: has_edge_between (a_start_node, a_end_node) and has_edge_between (a_end_node, a_start_node)
		end

	put_unlabeled_edge (a_start_node, a_end_node: like item; a_weight: REAL_64)
			-- Create an edge with weight `a_weight' between `a_start_node' and `a_end_node'.
			-- The cursor is not moved.
		local
			l: L
		do
			put_edge (a_start_node, a_end_node, l, a_weight)
		ensure then
			undirected_graph: has_edge_between (a_start_node, a_end_node) and has_edge_between (a_end_node, a_start_node)
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

	minimum_spanning_tree: like Current
			-- Minimum spanning tree of the current graph
			-- The cursor is not moved.
		require
			connected_graph: is_connected
			positive_weights: all_weights_positive
		local
			-- edge: like edge_item
			node_list: like linear_representation
			edge_list: ARRAYED_LIST [like edge_item]
			set_1, set_2: INTEGER
			mst: like Current
			uf: UNION_FIND_STRUCTURE [like item]
			l: L
		do
			mst := empty_graph
			node_list := linear_representation

			-- Initialize union-find data structure.
			create uf.make (node_count)
			from
				node_list.start
			until
				node_list.after
			loop
				uf.put (node_list.item)
				-- MST has same node set as current graph
				mst.put_node (node_list.item)
				node_list.forth
			end

			-- Put edges into sorted array (priority queue with lowest priority first).
			create edge_list.make (0)
			if attached {LINEAR [like edge_item]} edges.linear_representation as lin_rep then
				from
					lin_rep.start
				until
					lin_rep.after
				loop
					sorted_put (lin_rep.item, edge_list)
					lin_rep.forth
				end
			end

			-- Traverse edges in increasing order and keep only the MST edges.
			from
			until
				edge_list.is_empty
			loop
				edge_list.start
--				edge := edge_list.item
				if attached edge_list.item as edge then
					set_1 := uf.find (edge.start_node)
					set_2 := uf.find (edge.end_node)
					if set_1 /= set_2 then
						-- Keep edges that connect two independent graph parts.
						l := edge.label
						mst.put_edge (edge.start_node, edge.end_node, l, edge.weight)
						uf.union (set_1, set_2)
	----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
						debug ("mst")
							print ("MST: Keeping edge `" + edge.out + "'%N")
						end
	----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
					end
				end
				edge_list.remove
			end

			Result := mst
		ensure
			graph_not_changed: (node_count = old node_count) and (edge_count = old edge_count)
			cursor_not_moved: equal (cursor, old cursor)
			is_tree: Result.is_tree
		end

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature {NONE} -- Inapplicable

	put_unweighted_edge (a_start_node, a_end_node: like item; a_label: detachable L)
			-- Not applicable anymore. Edges must be weighted.
		do
			-- Workaround for catcalls: Put unweighted edge instead.
			put_edge (a_start_node, a_end_node, a_label, 0)
		end

feature {NONE} -- Implementation

	adopt_edge (a_edge: WEIGHTED_EDGE [like item, L])
			-- Put `a_edge' into current graph.
		local
			l: L
		do
			l := a_edge.label
			put_edge (a_edge.start_node, a_edge.end_node, l, a_edge.weight)
		end

	sorted_put (a_edge: like edge_item; edge_list: ARRAYED_LIST [like edge_item])
			-- Put `a_edge' into `edge_list' such that `edge_list' is
			-- sorted by increasing edge weights.
		require
			edge_list_not_void: edge_list /= Void
			edge_not_void: a_edge /= Void
		local
			l, r, p: INTEGER
		do
			check attached a_edge then
				-- Note: This routine is necessary because `WEIGHTED_EDGE' cannot
				-- inherit from `COMPARABLE' (failure of `is_equal' because of
				-- trichotomy postcondition). Hence no sortable data structure can be used.
				if edge_list.is_empty then
					edge_list.extend (a_edge)
				else
					-- Find insertion position for `edge_list' via binary search.
					from
						l := 1
						r := edge_list.count
					until
						r <= (l+1)
					loop
						p := (l+r) // 2
						if attached edge_list.i_th (p) as l_item and then l_item.weight < a_edge.weight then
							l := p
						else
							r := p
						end
					variant
						r-l
					end

					-- Decide whether to insert the new item at the left or right.
					edge_list.go_i_th (l)
					if attached edge_list.item as l_item and then l_item.weight < a_edge.weight then
						edge_list.put_right (a_edge)
					else
						edge_list.put_left (a_edge)
					end
				end
			end
		end

end -- class UNDIRECTED_WEIGHTED_GRAPH
