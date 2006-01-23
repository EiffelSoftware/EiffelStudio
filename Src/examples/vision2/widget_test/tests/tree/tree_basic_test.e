indexing
	description: "Objects that test EV_TREE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			tree_item1, tree_item2: EV_TREE_ITEM
			
		do
			create tree
			tree.set_minimum_size (300, 300)
			create tree_item1.make_with_text ("level 1")
			tree.extend (tree_item1)
			create tree_item2.make_with_text ("Level 2")
			tree_item1.extend (tree_item2)
			create tree_item2.make_with_text ("Level 2")
			tree_item1.extend (tree_item2)
		
			widget := tree
		end
		
feature {NONE} -- Implementation

	tree: EV_TREE;
		-- Widget that test is to be performed on.

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


end -- class TREE_BASIC_TEST
