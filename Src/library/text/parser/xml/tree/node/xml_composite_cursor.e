note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XML_COMPOSITE_CURSOR

inherit
	ITERATION_CURSOR [XML_NODE]
		redefine
			make, target
		end

create
	make

feature {NONE} -- Initialization

	make (s: like target)
			-- Initialize `Current'.
		do
			Precursor (s)
			nodes := s.nodes
		end

feature -- Access

	item: XML_NODE
			-- Item at current cursor position
		do
			Result := nodes.item
		end

feature -- Cursor movement

	remove
		do
			nodes.remove
		end

	go_after
		do
			nodes.finish
			nodes.forth
		end

feature -- Status report

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := nodes.after
		end

feature {NONE} -- Implementation

	nodes: LIST [XML_NODE]
			-- Associated nodes list

	target: XML_COMPOSITE
			-- Associated structure used for iteration

invariant
	nodes_attached: nodes /= Void
	nodes_from_target: target.nodes = nodes

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
