indexing
	description: "Objects that test EV_MULTI_COLUMN_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_MULTIPLE_SELECTION_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			list_item: EV_LIST_ITEM
			counter: INTEGER
			vertical_box: EV_VERTICAL_BOX
		do
			create list
			create vertical_box
			vertical_box.set_minimum_size (300, 300)
			create multiple_selection_button.make_with_text ("Multiple selection? - Hold %"Ctrl%" while selecting.")
			multiple_selection_button.select_actions.extend (agent adjust_selection)
			
			vertical_box.extend (list)
			vertical_box.extend (multiple_selection_button)
			vertical_box.disable_item_expand (multiple_selection_button)
			
			from
				counter := 1
			until
				counter > 25
			loop
				create list_item.make_with_text ("Not selected")
				list_item.select_actions.extend (agent update_selection_on_item (list_item))
				list_item.deselect_actions.extend (agent update_selection_on_item (list_item))
				list.extend (list_item)
				counter := counter + 1
			end
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	list: EV_LIST
	
	multiple_selection_button: EV_CHECK_BUTTON
	
	adjust_selection is
			-- Toggle selection of `list' between single
			-- and multiple based on state of `multiple_selection_button'.
		do
			if multiple_selection_button.is_selected then
				list.enable_multiple_selection
			else
				list.disable_multiple_selection
			end
		end
		
	update_selection_on_item (item: EV_LIST_ITEM) is
			-- Update `text' of `item' to reflects its selection state.
		require
			item_not_void: item /= Void
		do
			if item.is_selected then
				item.set_text ("Selected")
			else
				item.set_text ("Not selected")
			end
		end

end -- class LIST_MULTIPLE_SELECTION_TEST
