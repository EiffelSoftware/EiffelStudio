note
	description: "[
		Annotated graph nodes that can be used for graph algorithms
		such as finding the shortest routes between two nodes.
		]"
	author: "Olivier Jeger"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	NODE [G -> HASHABLE, L]

inherit
	COMPARABLE
		undefine
			is_equal
		end

	HASHABLE

create
	make

feature {NONE} -- Initialization

	make (a_item: like item)
			-- Initialize `Current'.
		require
			item_not_void: a_item /= Void
		do
			item := a_item
			reset
		ensure
			no_referrer: (referring_node = Void) and (referring_edge = Void)
			distance_positive: distance >= 0
			item_not_void: item /= Void
			fresh: not processed
		end

feature {GRAPH} -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item.hash_code
		end

	item: G
			-- Node item

--- ??? --- ??? --- ??? --- ??? --- ??? --- ??? --- ??? ---
--	referring_edge: WEIGHTED_EDGE [like item, L]
--- ??? --- ??? --- ??? --- ??? --- ??? --- ??? --- ??? ---
	referring_edge: detachable EDGE [like item, L]
			-- Edge where we came from

	referring_node: detachable like Current
			-- Node where we came from

feature {GRAPH, NODE} -- Access

	distance: REAL_64
			-- Length of the shortest route to `item' until now

feature {GRAPH, NODE} -- Status report

	processed: BOOLEAN
			-- Has the node already been processed by the algorithm?

feature -- Status setting

	set_processed
			-- Set `processed' flag.
		do
			processed := True
		ensure
			processed: processed
		end

	reset
			-- Reset `referring_edge', `distance' and `processed'.
		do
			referring_node := Void
			referring_edge := Void
			distance := (create {INTEGER_REF}).Max_value
			processed := False
		ensure
			no_referrer: (referring_node = Void) and (referring_edge = Void)
			fresh: not processed
		end


feature {GRAPH} -- Element change

	set_referrer (a_node: detachable like Current; a_edge: detachable  like referring_edge; a_distance: like distance)
			-- Set the referring edge to `a_edge' and the referring node to `a_node'.
		require
			positive_distance: a_distance >= 0
			less_than_previous: a_distance < distance
		do
			referring_node := a_node
			referring_edge := a_edge
			distance := a_distance
		ensure
			referring_node_set: referring_node = a_node
			referring_edge_set: referring_edge = a_edge
			distance_set: distance = a_distance
			smaller_than_before: distance < old distance
		end

feature -- Basic operations

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current route shorter than the one of `other'?
		do
			Result := distance < other.distance
		end

invariant

	distance_positive: distance >= 0
	item_not_void: item /= Void

end -- class NODE
