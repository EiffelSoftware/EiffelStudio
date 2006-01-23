indexing
	description: "Objects that demonstrate EV_COMBO_BOX"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	pixmaps_required: "1, 2"
	date: "$Date$"
	revision: "$Revision$"

class
	COMBO_BOX_PIXMAP_TEST
	
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
			create combo_box.make_with_text ("A combo box")
			combo_box.set_minimum_width (150)
				
			from
				counter := 1
			until
				counter = 20
			loop
				create list_item.make_with_text ("Item " + counter.out)
				list_item.set_pixmap (numbered_pixmap ((counter \\ 2) + 1))
				combo_box.extend (list_item)
				counter := counter + 1
			end
			widget := combo_box
		end
				
feature {NONE} -- Implementation

	combo_box: EV_COMBO_BOX;
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


end -- class COMBO_BOX_PIXMAP_TEST
