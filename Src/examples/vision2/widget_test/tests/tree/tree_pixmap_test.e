indexing
	description: "Objects that test EV_TREE."
	pixmaps_required: "1, 2"
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_PIXMAP_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			
			create tree
			tree.set_minimum_size (280, 280)
			build_tree			
		
			widget := tree
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
			root_item.set_pixmap (numbered_pixmap (1))
			tree.extend (root_item)
			add_items (root_item, 4)
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
				create tree_item.make_with_text ("Item")
				if count \\ 2 = 1 then
					tree_item.set_pixmap (numbered_pixmap (1))
				else
					tree_item.set_pixmap (numbered_pixmap (2))
				end
				item.extend (tree_item)
				add_items (tree_item, count - 1)
				counter := counter + 1
			end
		end

end -- class TREE_PIXMAP_TEST
