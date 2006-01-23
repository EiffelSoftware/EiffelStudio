indexing
	description: "Objects that test EV_DYNAMIC_TREE_ITEM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_DYNAMIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			tree_item: EV_DYNAMIC_TREE_ITEM
			
		do
			create tree
			tree.set_minimum_size (300, 300)
			create tree_item.make_with_text ("Level 1")
			tree_item.set_subtree_function_timeout (20)
			tree_item.set_subtree_function (agent create_children (tree_item))
			tree.extend (tree_item)
		
			widget := tree
		end
		
feature {NONE} -- Implementation

	create_children (item: EV_DYNAMIC_TREE_ITEM): ARRAYED_LIST [EV_TREE_NODE] is
			-- Create new children for `item'. The depth of `item'
			-- in `tree' determines how many children are contained.
		local
			counter: INTEGER
			tree_item: EV_DYNAMIC_TREE_ITEM
			depth: INTEGER
		do
			depth := depth_of_item (item) + 1
			create Result.make (depth)--item.count)
			from
				counter := 1
			until
				counter > depth
			loop
				create tree_item.make_with_text ("Level " + depth.out)
				tree_item.set_subtree_function (agent create_children (tree_item))
				tree_item.set_subtree_function_timeout (20)
				Result.extend (tree_item)
				counter := counter + 1
			end
		end
		
	depth_of_item (item: EV_DYNAMIC_TREE_ITEM): INTEGER is
			-- `Result' is depth of `item' in top level parent tree.
		do
			Result := recursive_depth (item, 1)
		end
	
	recursive_depth (item: EV_DYNAMIC_TREE_ITEM; depth: INTEGER): INTEGER is
			-- If `item' has parent, increase `depth' and call
			-- recursive, otherwise `Result' is set to depth.
		local
			parent_item: EV_DYNAMIC_TREE_ITEM
		do
			parent_item ?= item.parent
			if parent_item /= Void then
				Result := recursive_depth (parent_item, depth + 1)
			else
				Result := depth
			end
		end

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


end -- class TREE_DYNAMIC_TEST

