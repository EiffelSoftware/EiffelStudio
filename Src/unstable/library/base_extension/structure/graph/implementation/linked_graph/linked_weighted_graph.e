note
	description: "[
		Directed weighted graphs, implemented as
		dynamically linked structure.
		Simple graphs, multigraphs, symmetric graphs
		and symmetric multigraphs are supported.
	]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_WEIGHTED_GRAPH [G -> HASHABLE, L]

inherit
	LINKED_GRAPH [G, L]
		rename
			put_edge as put_unweighted_edge,
			put_unlabeled_edge as put_unweighted_unlabeled_edge,
			edge_from_values as unweighted_edge_from_values
		export {NONE}
 put_unweighted_edge,
			put_unweighted_unlabeled_edge,
			unweighted_edge_from_values
		undefine
			adopt_edge,
			edge_length,
			put_unweighted_edge
		redefine
			edge_item,
			prune_edge,
			out
		end

	WEIGHTED_GRAPH [G, L]
		rename
			make_empty_graph as make_empty_linked_graph
		undefine
			make_simple_graph,
			make_symmetric_graph,
			make_multi_graph,
			make_symmetric_multi_graph,
			has_node,
			has_edge,
			has_cycles,
			has_links,
			node_count,
			edge_count,
			target,
			out_degree,
			unweighted_edge_from_values,
			forth,
			out
			--		redefine
			--			border_nodes
		end

create
	make_simple_graph,
	make_symmetric_graph,
	make_multi_graph,
	make_symmetric_multi_graph

feature -- Access

	edge_item: detachable LINKED_GRAPH_WEIGHTED_EDGE [like item, L]
			-- Current edge
		do
			if attached current_node as l_current_node and then not l_current_node.edge_list.off then
				Result := {LINKED_GRAPH_WEIGHTED_EDGE [like item, L]} / l_current_node.edge_list.item
			else
				Result := Void
			end
		end

	edge_from_values (a_start_node, a_end_node: like item; a_label: L; a_weight: REAL_64): like edge_item
			-- Edge that matches `a_start_node', `a_end_node', `a_label' and `a_weight'.
			-- Result is Void if there is no match.
			-- The cursor is not moved.
		local
			start_node, end_node: like current_node
			edge: like edge_item
		do
			if has_node (a_start_node) and has_node (a_end_node) then
				start_node := linked_node_from_item (a_start_node)
				end_node := linked_node_from_item (a_end_node)
				if attached start_node and then attached end_node then
					create edge.make_directed (start_node, end_node, a_label, a_weight)
					if has_edge (edge) then
						Result := edge
					else
						Result := Void
					end
				end
			end
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put_edge (a_start_node, a_end_node: like item; a_label: detachable L; a_weight: REAL_64)
			-- Create an edge with weight `a_weight' between `a_start_node' and `a_end_node'.
			-- The edge will be labeled `a_label'.
			-- For symmetric graphs, another edge is inserted in the opposite direction.
		local
			start_node, end_node: like current_node
			edge: like edge_item
		do
			start_node := linked_node_from_item (a_start_node)
			end_node := linked_node_from_item (a_end_node)
			if attached start_node and then attached end_node then
				create edge.make_directed (start_node, end_node, a_label, a_weight)
				start_node.put_edge (edge)
				internal_edges.extend (edge)
				if is_symmetric_graph and start_node /= end_node then
					create edge.make_directed (end_node, start_node, a_label, a_weight)
					end_node.put_edge (edge)
					internal_edges.extend (edge)
				end
			end
		end

feature -- Removal

	prune_edge (a_edge: EDGE [like item, L])
			-- Remove `a_edge' from the graph.
		local
			linked_edge: like edge_item
			symmetric_edge: LINKED_GRAPH_WEIGHTED_EDGE [like item, L]
			start_node, end_node: like current_node
			l: L
		do
			prune_edge_impl (a_edge)
			if is_symmetric_graph then
					-- Find both start and end node in the node list.
				linked_edge := if attached {like edge_item} a_edge as l_edge then  l_edge else Void end
				if linked_edge /= Void then
					start_node := linked_edge.internal_start_node
					end_node := linked_edge.internal_end_node
				else
					start_node := linked_node_from_item (a_edge.start_node)
					end_node := linked_node_from_item (a_edge.end_node)
				end
				if attached end_node and then attached start_node then
					l := a_edge.label
					create symmetric_edge.make_directed (end_node, start_node, l, if attached linked_edge as l_edge then l_edge.weight else 0.0 end)
					prune_edge_impl (symmetric_edge)
				end
			end
		end

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
			-- Printable representation of the graph
		local
				-- node: like current_node
				-- edge: like edge_item
			i, index: INTEGER
		do
			Result := "digraph linked_weighted_graph%N"
			Result.append ("{%N")
			from
				i := 1
			until
				i > node_count
			loop
				check attached node_list.item (i) as node then
					Result.append ("%"")
					Result.append (node.item.out)
					Result.append ("%";%N")
					from
							-- Store previous cursor position
						index := node.edge_list.index
						node.edge_list.start
					until
						node.edge_list.exhausted
					loop
						Result.append ("  %"")
						Result.append (node.item.out)
						Result.append ("%" -> %"")
							--						edge ?= node.edge_list.item
						check attached {like edge_item} node.edge_list.item as edge then
							Result.append (edge.end_node.out)
							Result.append ("%" [label=%"")

							if attached {ANY} edge.label as label and then label /= Void and then not label.out.is_equal ("") then
								Result.append (label.out)
								Result.append ("\n")
							end
							Result.append ("w = ")
							Result.append (edge.weight.out)
							Result.append ("%"];%N")
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

end -- class LINKED_WEIGHTED_GRAPH
