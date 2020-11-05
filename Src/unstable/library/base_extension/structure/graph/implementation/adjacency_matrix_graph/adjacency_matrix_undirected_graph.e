note
	description: "[
		Undirected graphs, implemented on the basis
		of an adjacency matrix.
		Only simple graphs are supported.
	]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ADJACENCY_MATRIX_UNDIRECTED_GRAPH [G -> HASHABLE, L]

inherit
	ADJACENCY_MATRIX_GRAPH [G, L]
		rename
			in_degree as degree,
			out_degree as degree
		export {NONE}
 			is_dag
		undefine
			adopt_edge,
			components,
			put_unlabeled_edge,
			has_cycles,
			is_dag,
			is_connected,
			is_eulerian,
			opposite_node
		redefine
			has_edge_between,
			put_edge,
			degree,
			edge_count,
			empty_graph,
			prune_edge,
			prune_edge_between,
			out
		end

	UNDIRECTED_GRAPH [G, L]
		rename
			make_empty_graph as make_empty_adjacency_matrix_graph
		undefine
			make_simple_graph,
			make_symmetric_graph,
			make_multi_graph,
			make_symmetric_multi_graph,
			has_node,
			has_edge,
			has_links,
			target,
			degree,
			node_count,
			edge_count,
			forth,
			out
		end

create
	make_simple_graph

feature -- Access

feature -- Measurement

	degree: INTEGER
			-- Number of edges attached to `item'
		local
			i: INTEGER
		do
			if not has_links then
				Result := 0
			else
				from
					Result := 0
					i := first_edge_index
				until
					i > last_edge_index
				loop
					if adjacency_matrix.item (current_node_index, i) /= Void then
						if current_node_index /= i then
								-- "Normal" edges are counted once.
							Result := Result + 1
						else
								-- Graph loops are counted twice.
							Result := Result + 2
						end
					end
					i := i + 1
				end
			end
		end

	edge_count: INTEGER
			-- Number of edges in the graph
		local
			i, j: INTEGER
		do
			from
				i := 1
				Result := 0
			until
				i > node_array.count
			loop
				from
					j := 1
				until
					j > i -- Consider only the upper half of the matrix
				loop
					if valid_index (i) and valid_index (j) and (adjacency_matrix.item (i, j) /= Void) then
						Result := Result + 1
					end
					j := j + 1
				end
				i := i + 1
			end
		end

feature -- Status report

	has_edge_between (a_start_node, a_end_node: like item): BOOLEAN
			-- Are `a_start_node' and `a_end_node' directly connected?
		local
			start_index, end_index: INTEGER
		do
			start_index := index_of_element.item (a_start_node)
			end_index := index_of_element.item (a_end_node)
			Result := adjacency_matrix.item (start_index, end_index) /= Void
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put_edge (a_start_node, a_end_node: like item; a_label: detachable L)
			-- Create an edge between `a_start_node' and `a_end_node'
			-- and set its label to `a_label'.
			-- The cursor is not moved.
		local
			start_index, end_index: INTEGER
			edge: like edge_item
		do
			start_index := index_of_element.item (a_start_node)
			end_index := index_of_element.item (a_end_node)
			create edge.make_undirected (a_start_node, a_end_node, a_label)
			adjacency_matrix.put (edge, start_index, end_index)
			adjacency_matrix.put (edge, end_index, start_index)
			internal_edges.extend (edge)

				-- Update index bounds if necessary.
			if end_index < first_edge_index then
				first_edge_index := end_index
			elseif end_index > last_edge_index then
				last_edge_index := end_index
			end
		end

feature -- Removal

	prune_edge_between (a_start_node, a_end_node: like item)
			-- Remove the edge connecting `a_start_node' and `a_end_node'.
			-- This operation is only permitted on simple graphs because of ambiguity.
			-- The cursor will turn right if `edge_item' is removed.
		local
			start_index, end_index: INTEGER
		do
			start_index := index_of_element.item (a_start_node)
			end_index := index_of_element.item (a_end_node)

			if (not off) and then (current_target_node_index = end_index) then
				if degree > 1 then
						-- Turn right if `target' is removed.
					right
				else
					current_target_node_index := -1
					exhausted := True
				end
			end

				-- Remove edge from edge list.
			if attached adjacency_matrix.item (start_index, end_index) as l_item then
				internal_edges.prune (l_item)
			end

				-- Adjust the adjacency matrix.
			adjacency_matrix.put (Void, start_index, end_index)
			adjacency_matrix.put (Void, end_index, start_index)

			if not off and then degree = 0 then
				current_target_node_index := -1
				exhausted := True
			end

				-- Adjust node indices if necessary.
			if (not off) and then (start_index = first_edge_index) then
				find_first_edge_index
				current_target_node_index := first_edge_index
			elseif (not off) and then (end_index = last_edge_index) then
				find_last_edge_index
				current_target_node_index := last_edge_index
			end
		end

	prune_edge (a_edge: EDGE [like item, L])
			-- Remove `a_edge' from the graph.
			-- The cursor will turn right if `current_egde' is removed.
		do
				-- This will work, since we only have a simple graph.
			prune_edge_between (a_edge.start_node, a_edge.end_node)
		end

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Output

	out: STRING
			-- Textual representation of the graph
		local
			i, j: INTEGER
			node: like item
			label: L
		do
			Result := "graph adjacency_matrix_undirected_graph%N"
			Result.append ("{%N")
			from
				i := 1
			until
				i > node_array.count
			loop
				node := node_array.item (i)
				Result.append ("%"")
				Result.append (node.out)
				Result.append ("%";%N")
				from
					j := 1
				until
					j > i -- Consider only the upper half of the graph.
				loop
					if
						adjacency_matrix.item (i, j) /= Void
					then
						Result.append ("  %"")
						Result.append (node.out)
						Result.append ("%" -- %"")
						Result.append (node_array.item (j).out)
						Result.append ("%"")
						label := if attached adjacency_matrix.item (i, j) as l_item then l_item.label else label end
						separate label as s_label do
							if attached s_label as ls_label and then not ls_label.out.is_equal ("") then
								Result.append (" [label=%"")
								Result.append (create {STRING}.make_from_separate (ls_label.out))
								Result.append ("%"]")
							end
						end
						Result.append (";%N")
					end
					j := j + 1
				end
				i := i + 1
			end
			Result.append ("}%N")
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	empty_graph: like Current
			-- Empty graph with the same actual type than `Current'
		do
			create Result.make_simple_graph
		end

end -- class ADJACENCY_MATRIX_UNDIRECTED_GRAPH
