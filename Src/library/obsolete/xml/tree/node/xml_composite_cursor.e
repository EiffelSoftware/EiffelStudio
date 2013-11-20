note
	description : "External iteration cursor used by `across...loop...end'."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_COMPOSITE_CURSOR

inherit
	ITERATION_CURSOR [XML_NODE]

create
	make

feature {NONE} -- Initialization

	make (s: like target)
			-- Initialize `Current'.
		do
			target := s
			internal_cursor := s.internal_nodes.new_cursor
		end

feature -- Access

	item: XML_NODE
			-- Item at current cursor position
		do
			Result := internal_cursor.item
		end

feature -- Cursor movement

	start
			-- <Precursor>
		do
			internal_cursor.start
		end

	forth
			-- <Precursor>
		do
			internal_cursor.forth
		end

	remove
			-- Remove `item' pointed at by `Current' from `target'.
		local
			l_nodes: LIST [XML_NODE]
			c: CURSOR
		do
			l_nodes := target.internal_nodes
				--| `{XML_COMPOSITE}.before_addition' ensures a node has a single parent
				--| and is contained only once.
				--| thus it is safe to call prune_all
			c := l_nodes.cursor
			l_nodes.prune_all (item)
			if l_nodes.valid_cursor (c) then
				l_nodes.go_to (c)
			end
		end

	go_after
			-- Set `Current' to be `after'.	
		do
			from
			until
				internal_cursor.after
			loop
				internal_cursor.forth
			end
		end

feature -- Status report

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := internal_cursor.after
		end

feature {NONE} -- Implementation

	internal_cursor: INDEXABLE_ITERATION_CURSOR [XML_NODE]
		-- Node cursor that `Current' forwards calls to.			

	target: XML_COMPOSITE
			-- Associated structure used for iteration

invariant
	target_attached: target /= Void

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
