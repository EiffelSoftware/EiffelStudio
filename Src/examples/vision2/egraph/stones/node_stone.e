indexing
	description: "Stone transporting an EG_NODE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_STONE
	
create
	make
	
feature {NONE} -- Initialization

	make (a_node: like node) is
			-- Make a NODE_STONE transporting `a_node'.
		require
			a_node_not_void: a_node /= Void
		do
			node := a_node
		ensure
			set: node = a_node
		end

feature -- Access

	node: EG_NODE;
			-- The node transported.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class NODE_STONE
