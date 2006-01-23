indexing
	description: "Objects that demonstrate EV_CELL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	cell: EV_CELL;
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


end -- class CELL_BACKGROUND_PIXMAP_TEST
