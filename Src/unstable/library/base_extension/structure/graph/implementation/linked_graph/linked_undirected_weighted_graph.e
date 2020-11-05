note
	description: "[
		Undirected weighted graphs, implemented as
		dynamically linked structure.
		Both simple graphs and multigraphs are supported.
	]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_UNDIRECTED_WEIGHTED_GRAPH [G -> HASHABLE, L]

inherit
	LINKED_UNDIRECTED_GRAPH [G, L]
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

	LINKED_WEIGHTED_GRAPH [G, L]
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
			out,
			target,
			neighbors
		redefine
			put_edge
		end

	UNDIRECTED_WEIGHTED_GRAPH [G, L]
		rename
			make_empty_graph as make_empty_linked_graph
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
			neighbors,
			out
		end

create
	make_simple_graph,
	make_multi_graph

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put_edge (a_start_node, a_end_node: G; a_label: detachable L; a_weight: REAL_64)
			-- Create an edge with weight `a_weight' between `a_start_node' and `a_end_node'.
			-- The edge will be labeled `a_label'.
		local
			start_node, end_node: like current_node
			edge: like edge_item
		do
			start_node := linked_node_from_item (a_start_node)
			end_node := linked_node_from_item (a_end_node)
			if attached start_node and then attached end_node then
				create edge.make_undirected (start_node, end_node, a_label, a_weight)
				start_node.put_edge (edge)
				end_node.put_edge (edge)
				internal_edges.extend (edge)
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
			i, index: INTEGER
				-- node: like current_node
				-- edge: like edge_item
			edges_todo: like edges
		do
			Result := "graph linked_undirected_graph%N"
			Result.append ("{%N")

			edges_todo := internal_edges.twin
			edges_todo.compare_objects

			from
				i := 1
			until
				i > node_count
			loop
				if attached node_list.item (i) as node then
					Result.append ("%"")
					Result.append (node.item.out)
					Result.append ("%";%N")
					from
						index := node.edge_list.index
						node.edge_list.start
					until
						node.edge_list.exhausted
					loop
						if attached {like edge_item} node.edge_list.item as edge then
							if edges_todo.has (edge) then
								Result.append ("  %"")
								Result.append (node.item.out)
								Result.append ("%" -- %"")
								Result.append (edge.opposite_node (node.item).out)
								Result.append ("%" [label=%"")

								if attached {ANY} node.edge_list.item.label as label and then label /= Void and then not label.out.is_equal ("") then
									Result.append (label.out)
									Result.append ("\n")
								end
								Result.append ("w = ")
								Result.append (edge.weight.out)
								Result.append ("%"];%N")
								edges_todo.start
								edges_todo.prune (edge)
							end
						end
						node.edge_list.forth
					end
					if node.edge_list.valid_index (index) then
						node.edge_list.go_i_th (index)
					end
				end
				i := i + 1
			end
			Result.append ("}%N")
		end

end -- class LINKED_UNDIRECTED_WEIGHTED_GRAPH
