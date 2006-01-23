indexing
	description: "Objects that test EV_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	pixmaps_required: "1, 2"
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_PIXMAP_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			list_item: EV_LIST_ITEM
			counter: INTEGER
			vertical_box: EV_VERTICAL_BOX
			reset_button: EV_BUTTON
		do
			create vertical_box
			create list
			vertical_box.extend (list)
			create reset_button.make_with_text_and_action ("Reset", agent reset)
			vertical_box.extend (reset_button)
			vertical_box.disable_item_expand (reset_button)
			vertical_box.set_minimum_size (300, 300)
			from
				counter := 1
			until
				counter > 25
			loop
				create list_item.make_with_text ("Item " + counter.out)
				list_item.select_actions.extend (agent select_pixmap)

				list_item.set_pixmap (numbered_pixmap (1))
				list.extend (list_item)
				counter := counter + 1
			end
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	list: EV_LIST
		-- Widget that test is to be performed on.
	
	select_pixmap is
			-- Set `selected_pixmap' to `selected_item' of `list'.
		do
			list.selected_item.set_pixmap (numbered_pixmap (2))
		end

	reset is
			-- Reset items in `list' to display `unselected_pixmap'.
		do
			from
				list.start
			until
				list.off
			loop
				list.item.set_pixmap (numbered_pixmap (1))
				list.forth
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


end -- class LIST_PIXMAP_TEST
