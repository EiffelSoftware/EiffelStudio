note
	description: "Performs a fixed point iteration backwards through the CFG."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_CFG_BACKWARD_ITERATOR

inherit
	CA_CFG_ITERATOR
		rename
			is_ready as is_empty
		end

feature -- Iteration

	process_cfg (a_cfg: attached CA_CONTROL_FLOW_GRAPH)
		local
			l_label: INTEGER
			l_bfs_nodes: LINKED_QUEUE [CA_CFG_BASIC_BLOCK]
			l_current_node: CA_CFG_BASIC_BLOCK
			l_visited: BINARY_SEARCH_TREE_SET [INTEGER]
		do
				-- Create edge list using BFS. Add every graph edge
				-- to the work list.
			from
				create worklist.make
				create l_visited.make
				create l_bfs_nodes.make
				l_bfs_nodes.extend (a_cfg.end_node)
			until
				l_bfs_nodes.is_empty
			loop
				across l_bfs_nodes.item.in_edges as l_ins loop
					l_label := l_ins.label

					worklist.put ([l_ins, l_bfs_nodes.item])

					if not l_visited.has (l_label) then
						l_visited.extend (l_label)
						l_bfs_nodes.extend (l_ins)
					end
				end
				l_bfs_nodes.remove
			end

				-- Now process all edges that are in the worklist. If `visit_edge' has a
				-- positive result then add all incoming edges to the worklist.
			from
				initialize_processing (a_cfg)
			until
				worklist.is_empty
			loop
				l_current_node := worklist.item.fr
				if visit_edge (l_current_node, worklist.item.to) then
						-- The visitor requests another pass on this edge
						-- so again we will add it to the worklist.
					across l_current_node.in_edges as l_ins loop
						worklist.put ([l_ins, l_current_node])
					end
				end
				worklist.remove
			end
		end

end
