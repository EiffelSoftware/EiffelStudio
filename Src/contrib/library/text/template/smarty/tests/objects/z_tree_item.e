note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	Z_TREE_ITEM

inherit
	Z_TREE_NODE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (n: STRING)
			-- Initialize `Current'.
		do
			Precursor (n)
			create nodes.make
		end

feature -- Access

	nodes: LINKED_LIST [Z_TREE_NODE]

feature -- Change

	add_node (i: Z_TREE_NODE)
		do
			nodes.force (i)
			i.set_parent (Current)
		end

end
