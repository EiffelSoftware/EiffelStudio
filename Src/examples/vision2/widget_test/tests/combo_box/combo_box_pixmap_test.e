indexing
	description: "Objects that demonstrate EV_COMBO_BOX"
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
		
feature {NONE} -- Implementation

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

	combo_box: EV_COMBO_BOX
	
end -- class COMBO_BOX_PIXMAP_TEST
