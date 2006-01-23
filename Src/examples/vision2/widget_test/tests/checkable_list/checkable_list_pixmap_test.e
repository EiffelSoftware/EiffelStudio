indexing
	description: "Objects that test EV_CHECKABLE_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	pixmaps_required: "1, 2"
	date: "$Date$"
	revision: "$Revision$"

class
	CHECKABLE_LIST_PIXMAP_TEST

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
		do
			create checkable_list
			checkable_list.set_minimum_size (300, 300)
			from
				counter := 1
			until
				counter > 20
			loop
				create list_item.make_with_text ("Item " + counter.out)
				list_item.set_pixmap (numbered_pixmap (1))
				checkable_list.extend (list_item)
				counter := counter + 1
			end
			widget := checkable_list
			checkable_list.check_actions.extend (agent respond_to_check)
			checkable_list.uncheck_actions.extend (agent respond_to_unchecK)
		end
		
feature {NONE} -- Implementation

	checkable_list: EV_CHECKABLE_LIST
		-- Widget that test is to be performed on.
	
	respond_to_check (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected, so update its
			-- pixmap.
		do
			list_item.set_pixmap (numbered_pixmap (2))	
		end
		
	respond_to_uncheck (list_item: EV_LIST_ITEM) is
			-- `list_item' has been unselected, so update its
			-- pixmap.
		do
			list_item.set_pixmap (numbered_pixmap (1))	
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


end -- class CHECKABLE_LIST_PIXMAP_TEST
