indexing
	description: "Objects that demonstrate EV_CELL."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CELL_BACKGROUND_PIXMAP_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create cell
			cell.set_minimum_size (300, 300)
			cell.set_background_pixmap (numbered_pixmap (1))
			widget := cell
		end
		
feature {NONE} -- Implementation

	cell: EV_CELL

end -- class CELL_BACKGROUND_PIXMAP_TEST
