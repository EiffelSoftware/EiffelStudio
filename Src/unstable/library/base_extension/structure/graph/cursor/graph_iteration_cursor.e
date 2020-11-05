note
	description: "External (dfs or bfs) iteration cursor for {GRAPH}."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPH_ITERATION_CURSOR [G -> HASHABLE, L]

inherit

	ITERATION_CURSOR [G]

create
	make

feature {NONE} -- Initialization

	make (g: GRAPH [G, L])
			-- Create a new iteration cursor that is walking on `g'. The starting position
			-- of the walker is the current node of the graph.
		require
			non_void: g /= Void
			graph_not_off: not g.off
		do
			graph := g
			create nodes.make_from_iterable (g.nodes)
			create_dispenser
			create visited_nodes.make (g.node_count)
			start
		ensure
			item_set: item = g.item
		end

feature -- Access

	graph: GRAPH [G, L]
			-- The graph the iterator is processing

	item: G
			-- Current graph node
		do
			Result := nodes.at (target_index)
		end

	index_cursor: INTEGER
			-- Index of current cursor position.

	target_index: INTEGER
			-- Index of	current item.

feature -- Status report

	after: BOOLEAN

	is_empty: BOOLEAN = False

feature -- Cursor movement

	start
			-- Move the cursor back to the start
		do
			index_cursor := 1
			target_index := nodes.index_of (graph.item, 1)
			visited_nodes.wipe_out
			visited_nodes.put (True, nodes.at (target_index))
			dispenser.wipe_out
			dispenser.extend (item)
			after := False
		end

	forth
			-- Move the cursor to the next item
		do
			if dispenser.is_empty then
				after := True
			else
				from
				until
					(not visited_nodes.has (nodes.at (target_index))) or
					dispenser.is_empty
				loop
					target_index := nodes.index_of (dispenser.item, 1)
					dispenser.remove
					across graph.neighbors_of (nodes.at (target_index)) as ic loop
						if not visited_nodes.has (ic.item) then
							dispenser.extend (ic.item)
						end
					end
				end
				after := visited_nodes.has (nodes.at (target_index))
				if not after then
					visited_nodes.put (True, nodes.at (target_index))
					index_cursor := index_cursor + 1
				end
			end
		end

feature {NONE} -- Implementation

	nodes: ARRAYED_SET [like item]
			-- Set of nodes to be traversed.

	dispenser: DISPENSER [G]
			-- Storage of items that need to be processed

	visited_nodes: HASH_TABLE [BOOLEAN, HASHABLE]
			-- Provides fast lookup for already processed nodes

	create_dispenser
			-- Create the dispenser
			--		as a queue for the BFS Walker
			--		as a stask for a DFS walker
		do
			if graph.is_depth_first then
				create {LINKED_STACK [G]} dispenser.make
			else
				create {LINKED_QUEUE [G]} dispenser.make
			end
			dispenser.compare_objects
		end

end
