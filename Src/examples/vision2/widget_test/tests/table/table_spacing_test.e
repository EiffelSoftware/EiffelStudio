indexing
	description: "Objects that test spacing of EV_TABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_SPACING_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button: EV_BUTTON
		do
				-- Create `label' using `make_with_text'.
			create table
			table.set_minimum_size (300, 300)
			table.resize (2, 2)
			create button.make_with_text ("One")
			table.put (button, 1, 1, 1, 1)
			create button.make_with_text ("Two")
			table.put (button, 2, 1, 1, 1)
			create button.make_with_text ("Three")
			table.put (button, 1, 2, 1, 1)
			create button.make_with_text ("Four")
			table.put (button, 2, 2, 1, 1)
			
			table.set_column_spacing (50)
			table.set_row_spacing (10)

			widget := table
		end
		
feature {NONE} -- Implementation

	table: EV_TABLE

end -- class TABLE_SPACING_TEST
