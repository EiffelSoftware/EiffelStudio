indexing
	description: "Objects that create extendible controls for EV_TREE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_EXTENDIBLE_CONTROLS
	
inherit
	EXTENDIBLE_CONTROLS
		redefine
			current_type
		end
	
create
	make_with_text_control

feature -- Access

	current_type: EV_TREE

feature -- Status report

	help: STRING is "Select %"Extend%", to add a new item to the tree, with `text' matching that of the text field.%NIf you select an item in the tree, then the new item will be added to the selected item.%NSelecting %"Wipe_out%" will clear the tree." 
			-- Instructions on how to use the control.

feature -- Status setting

	extend_item is
			-- Add a new item to `current_type'.
		local
			tree_item, selected_item: EV_TREE_ITEM
		do
			create tree_item.make_with_text (text_control.text)
			if current_type.selected_item /= Void then
				selected_item ?= current_type.selected_item
				check
					selected_item_not_void: selected_item /= Void
				end
				selected_item.extend (tree_item)
				if not selected_item.is_expanded then
					selected_item.expand
				end
			else
				current_type.extend (tree_item)
			end
			
		end
		
	wipe_out_item is
			-- call `wipe_out' on `Current_type'.
		do
			current_type.wipe_out
		end

feature {NONE} -- Implementation

	initial_text: STRING is "Tree item"
			-- Initial text for new items.

end -- class TREE_EXTENDIBLE_CONTROLS
