indexing
	description: "Objects that demonstrate EV_CELL."
	pixmaps_required: "1"
	date: "$Date$"
	revision: "$Revision$"

class
	CELL_BACKGROUND_PIXMAP_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

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
		-- Widget that test is to be performed on.

end -- class CELL_BACKGROUND_PIXMAP_TEST
