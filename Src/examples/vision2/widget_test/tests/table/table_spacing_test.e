indexing
	description: "Objects that test spacing of EV_TABLE."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_SPACING_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

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
			table.put_at_position (button, 1, 1, 1, 1)
			create button.make_with_text ("Two")
			table.put_at_position (button, 2, 1, 1, 1)
			create button.make_with_text ("Three")
			table.put_at_position (button, 1, 2, 1, 1)
			create button.make_with_text ("Four")
			table.put_at_position (button, 2, 2, 1, 1)
			
			table.set_column_spacing (50)
			table.set_row_spacing (10)

			widget := table
		end
		
feature {NONE} -- Implementation

	table: EV_TABLE
		-- Widget that test is to be performed on.

end -- class TABLE_SPACING_TEST
