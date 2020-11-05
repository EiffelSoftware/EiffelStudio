note
	description: "[
		Undirected weighted graphs, implemented
		on the basis of an adjacency matrix.
		Only simple graphs are supported.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH [G -> HASHABLE, L]

inherit
	ADJACENCY_MATRIX_UNDIRECTED_GRAPH [G, L]
		rename
			put_edge as put_unweighted_edge,
			put_unlabeled_edge as put_unweighted_unlabeled_edge,
			edge_from_values as unweighted_edge_from_values
		export {NONE}
			unweighted_edge_from_values,
			put_unweighted_edge,
			put_unweighted_unlabeled_edge
		undefine
			adopt_edge,
			edge_length,
			make_simple_graph,
			make_symmetric_graph,
			put_unweighted_edge,
			edge_item,
			out
		end

	ADJACENCY_MATRIX_WEIGHTED_GRAPH [G, L]
		rename
			in_degree as degree,
			out_degree as degree
		export {NONE}
			is_dag
		undefine
			adopt_edge,
			components,
			degree,
			empty_graph,
			has_edge_between,
			put_unlabeled_edge,
			edge_count,
			opposite_node,
			put_unweighted_unlabeled_edge,
			prune_edge,
			prune_edge_between,
			has_cycles,
			is_dag,
			is_connected,
			is_eulerian,
			out
		redefine
			put_edge
		end

	UNDIRECTED_WEIGHTED_GRAPH [G, L]
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
			unweighted_edge_from_values,
			node_count,
			edge_count,
			put_unweighted_edge,
			forth,
			out
		end

create
	make_simple_graph

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put_edge (a_start_node, a_end_node: G; a_label: detachable L; a_weight: REAL_64)
			-- Create an edge with weight `a_weight' between `a_start_node' and `a_end_node'.
			-- The edge will be labeled `a_label'.
			-- The cursor is not moved.
		local
			start_index, end_index: INTEGER
			edge: WEIGHTED_EDGE [G, L]
		do
			start_index := index_of_element.item (a_start_node)
			end_index := index_of_element.item (a_end_node)
			create edge.make_undirected (a_start_node, a_end_node, a_label, a_weight)
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

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature -- Output

	out: STRING
			-- Textual representation of the graph
		local
			i, j: INTEGER
			node: G
			label: L
			edge: WEIGHTED_EDGE [G, L]
		do
			Result := "graph adjacency_matrix_graph%N"
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
					j := i
				until
					j > node_array.count
				loop
					edge := adjacency_matrix.item (i, j)
					if
						edge /= Void
					then
						Result.append ("  %"")
						Result.append (node.out)
						Result.append ("%" -- %"")
						Result.append (node_array.item (j).out)
						Result.append ("%" [label=%"")
						label := edge.label
						separate label as s_label do
							if attached s_label as ls_label and then not ls_label.out.is_equal ("") then
								Result.append (create {STRING}.make_from_separate (ls_label.out))
								Result.append ("\n")
							end
						end
						Result.append ("w = ")
						Result.append (edge.weight.out)
						Result.append ("%"];%N")
					end
					j := j + 1
				end
				i := i + 1
			end
			Result.append ("}%N")
		end

end -- class ADJACENCY_MATRIX_UNDIRECTED_WEIGHTED_GRAPH
