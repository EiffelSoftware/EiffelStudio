note

	description:

		"Tables which map XML nodes to their positions in source documents"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XML_POSITION_TABLE

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new position table.
		do
			create table.make
		end

feature -- Status report

	has (a_node: XML_NODE): BOOLEAN
			-- Is there a position associated with `a_node'?
		require
			a_node_not_void: a_node /= Void
		local
			lst: like table
			c: CURSOR
		do
			lst := table
			c := lst.cursor
			from
				lst.start
			until
				lst.after or Result
			loop
				if lst.item.node = a_node then
					Result := True
				else
					lst.forth
				end
			end
			lst.go_to (c)
		end

feature -- Access

	item (a_node: XML_NODE): detachable XML_POSITION
			-- Position associated with `a_node'
		require
			a_node_not_void: a_node /= Void
			has_node: has (a_node)
		local
			lst: like table
			c: CURSOR
		do
			lst := table
			c := lst.cursor
			from
				lst.start
			until
				lst.after or Result /= Void
			loop
				if lst.item.node = a_node then
					Result := lst.item.position
				else
					lst.forth
				end
			end
			lst.go_to (c)
		ensure
			position_not_void: Result /= Void
		end

feature -- Element change

	put (a_position: XML_POSITION; a_node: XML_NODE)
			-- Associate `a_node' with position `a_position'.
		require
			a_position_not_void: a_position /= Void
			a_node_not_void: a_node /= Void
			not_has_node: not has (a_node)
		do
			table.force ([a_position, a_node])
		ensure
			has_node: has (a_node)
			inserted: item (a_node) = a_position
		end

feature {NONE} -- Implementation

	table: LINKED_LIST [TUPLE [position: XML_POSITION; node: XML_NODE]]
			-- List of (node, position) pairs

invariant

	table_not_void: table /= Void
--	no_void_pair: not table.has_void
	-- no_void_position: forall p in table, p.first /= Void
	-- no_void_node: forall p in table, p.second /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
