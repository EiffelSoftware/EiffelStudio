indexing
	description: "Objects that demonstrate EV_CELL."
	date: "$Date$"
	revision: "$Revision$"

class
	CELL_BASIC_TEST
	
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
			cell.extend (create {EV_BUTTON}.make_with_text ("Parented in a cell."))
			widget := cell
		end
		
feature {NONE} -- Implementation

	cell: EV_CELL
		-- Widget that test is to be performed on.

end -- class CELL_BASIC_TEST
