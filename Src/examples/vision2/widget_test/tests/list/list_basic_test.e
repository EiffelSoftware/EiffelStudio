indexing
	description: "Objects that test EV_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_BASIC_TEST

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

	list: EV_LIST

end -- class LIST_BASIC_TEST
