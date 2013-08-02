note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	Z_TREE

create
	make

feature {NONE} -- Initialization

	make (n: STRING)
			-- Initialize `Current'.
		do
			name := n
			create nodes.make
			create nodes_table.make (10)
		end

feature -- Access

	name: STRING

	title: STRING
		do
			Result := "Tree named %""+ name +"%""
		end

	nodes: LINKED_LIST [Z_TREE_NODE]

	nodes_table: HASH_TABLE [Z_TREE_NODE, INTEGER]

feature -- Change

	add_node (i: Z_TREE_NODE)
		do
			nodes.force (i)
			nodes_table.force (i, i.id)
		end

end
