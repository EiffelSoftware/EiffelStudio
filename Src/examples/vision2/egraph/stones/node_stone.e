indexing
	description: "Stone transporting an EG_NODE"
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

	node: EG_NODE
			-- The node transported.

end -- class NODE_STONE
