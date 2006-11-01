indexing
	description: "Objects that test EV_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_BASIC_TEST

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
		do
			create list
			list.set_minimum_size (300, 300)
			create list_item.make_with_text ("Item 1")
			list.extend (list_item)
			create list_item.make_with_text ("Item 2")
			list.extend (list_item)
			create list_item.make_with_text ("Item 3")
			list.extend (list_item)
			widget := list
		end
		
feature {NONE} -- Implementation

	list: EV_LIST;
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


end -- class LIST_BASIC_TEST
