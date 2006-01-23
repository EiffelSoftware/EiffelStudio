indexing
	description: "Objects that test EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create grid
			grid.set_minimum_size (300, 300)
			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Item 1, 1"))
			grid.set_item (2, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Item 2, 1"))
			grid.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("Item 1, 2"))
			grid.set_item (2, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("Item 2, 2"))
			grid.column (1).set_title ("Column 1")
			grid.column (2).set_title ("Column 2")
			
			widget := grid
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID;
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


end -- class GRID_BASIC_TEST
