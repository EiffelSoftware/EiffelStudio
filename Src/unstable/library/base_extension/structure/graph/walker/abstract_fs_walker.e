note
	description: "[
		An abstract "something first search" implementation,
		that can be transformed to "breadth first search" or
		"depth first search" by defining the create_dispenser
		routine to create either a queue or a stack.
	]"
	author: "Olivier Jeger, based on an initial design by Bernd Schoeller"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_FS_WALKER [G -> HASHABLE, L]

inherit
	LINEAR [G]

feature -- Initialization

	make (g: GRAPH [G, L])
			-- Create a new walker that is walking on `g'. The starting position
			-- of the walker is the current node of the graph.
		require
			non_void: g /= Void
			graph_not_off: not g.off
		do
			graph := g.twin
			first_node := g.cursor
			create_dispenser
			create visited_nodes.make (g.node_count)
			start
		ensure
			item_set: item = g.item
		end

feature {NONE} -- Initialization

feature -- Access

	graph: GRAPH [G, L]
			-- The graph the walker is processing

	item: G
			-- Current graph node
		do
			Result := graph.item
		end

	index: INTEGER
			-- Index of current position

feature -- Measurement

feature -- Status report

	after: BOOLEAN

	is_empty: BOOLEAN = False

feature -- Cursor movement

	start
			-- Move the cursor back to the start
		do
			graph.go_to (first_node)
			index := 1
			visited_nodes.wipe_out
			visited_nodes.put (True, graph.node_identity)
			dispenser.wipe_out
			add_targets_to_dispenser
			after := False
		end

	forth
			-- Move the cursor to the next item
		do
			if dispenser.is_empty then
				after := True
			else
				from
					graph.go_to (dispenser.item)
						----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
					debug ("walker")
						print ("WALKER: am at item `")
						print (graph.item)
						print ("'%N")
					end
						----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
					dispenser.remove
				until
					(not visited_nodes.has (graph.node_identity)) or
					dispenser.is_empty
				loop
					graph.go_to (dispenser.item)
						----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
					debug ("walker")
						print ("WALKER: am at item `")
						print (graph.item)
						print ("'%N")
					end
						----- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG --- DEBUG -----
					dispenser.remove
				end
				after := visited_nodes.has (graph.node_identity)
				if not after then
					visited_nodes.put (True, graph.node_identity)
					add_targets_to_dispenser
					index := index + 1
				end
			end
		end

	finish
			-- Move the cursor to the last item
		do
			from
				start
			until
				after or next_will_be_after
			loop
				forth
			end
		end

feature {NONE} -- Implementation

	first_node: GRAPH_CURSOR [G, L]
			-- Node to start the walk on

	dispenser: DISPENSER [GRAPH_CURSOR [G, L]]
			-- Storage of items that need to be processed

	visited_nodes: HASH_TABLE [BOOLEAN, HASHABLE]
			-- Provides fast lookup for already processed nodes

	create_dispenser
			-- Create the dispenser
		deferred
		ensure
			dispenser_created: dispenser /= Void
		end

	add_targets_to_dispenser
			-- Add all targets of the current node to the dispenser
		require
			not_off_graph: not graph.off
		do
			from
				graph.start
			until
				graph.exhausted
			loop
				dispenser.extend (graph.target_cursor)
				graph.left
			end
		end

	next_will_be_after: BOOLEAN
			-- Will the next forth result in an after ?
			-- (all items in the dispenser are already visited)
		local
			oldpos: GRAPH_CURSOR [G, L]
			linear: LINEAR [GRAPH_CURSOR [G, L]]
		do
			oldpos := graph.cursor
			linear := dispenser.linear_representation
			Result := True
			from
				linear.start
			until
				linear.after or not Result
			loop
				graph.go_to (linear.item)
				if
					not visited_nodes.has (graph.node_identity)
				then
					Result := False
				end
			end
			graph.go_to (oldpos)
		end

end -- class ABSTRACT_FS_WALKER
