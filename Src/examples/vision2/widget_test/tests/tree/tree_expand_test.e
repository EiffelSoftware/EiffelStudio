indexing
	description: "Objects that test EV_TREE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_EXPAND_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create vertical_box
			
			create tree
			tree.set_minimum_size (280, 280)
			build_tree
			vertical_box.extend (tree)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create expand_button.make_with_text ("Expand all")
			expand_button.select_actions.extend (agent expand_all)
			create collapse_button.make_with_text ("Collapse all")
			collapse_button.select_actions.extend (agent collapse_all)
			horizontal_box.extend (expand_button)
			horizontal_box.extend (collapse_button)
			
		
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	tree: EV_TREE
			-- Widget that test is to be performed on.
	
	expand_button, collapse_button: EV_BUTTON
			-- Buttons for controlling expanding/collapsing `tree'.
	
	build_tree is
			-- Fill `tree' with tree items.
		local
			root_item: EV_TREE_ITEM
		do
			create root_item.make_with_text ("Root Item")
			tree.extend (root_item)
			add_items (root_item, 5)
		end
		
	add_items (item: EV_TREE_ITEM; count: INTEGER) is
			-- Add `count' items to `item'.
		local
			counter: INTEGER
			tree_item: EV_TREE_ITEM
		do
			from
				counter := 1
			until
				counter > count
			loop
				create tree_item.make_with_text ("not expanded")
				tree_item.expand_actions.extend (agent tree_item.set_text ("expanded"))
				tree_item.collapse_actions.extend (agent tree_item.set_text ("not expanded"))
				item.extend (tree_item)
				add_items (tree_item, count - 1)
				counter := counter + 1
			end
		end
		
	expand_all is
			-- Expand all items in `tree'.
		do
			adjust_state (tree.i_th (1), False)
		end
		
	collapse_all is
			-- Collapse all items in `tree'.
		do
			adjust_state (tree.i_th (1), True)
		end
		
	adjust_state (tree_item: EV_TREE_NODE; collapsing: BOOLEAN) is
			-- For all items of `tree_item', recursively collapse
			-- if `collapsing' otherwise expand.
		do
			from
				tree_item.start
			until
				tree_item.off
			loop
				if collapsing then
					tree_item.collapse
				else
					tree_item.expand
				end
				adjust_state (tree_item.item, collapsing)
				tree_item.forth
			end
		end

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


end -- class TREE_EXPAND_TEST
