indexing
	description: "Objects that represent a tree structure of BOOLEAN."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_BOOLEAN_TREE

feature -- Access

	root_node: GB_BOOLEAN_TREE_ITEM
	
feature -- Status setting

	set_root_node (node: GB_BOOLEAN_TREE_ITEM) is
			-- Assign `node' to `root_node'.
		require
			node_not_void: node /= Void
		do
			root_node := node
		ensure
			root_node = node
		end
		
end -- class GB_BOOLEAN_TREE
