indexing
	description: "Objects that test EV_TABLE."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_SINGLE_CHILD_TEST

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
			create button.make_with_text ("A button")
			table.put_at_position (button, 1, 1, 1, 1)
			
			widget := table
		end
		
feature {NONE} -- Implementation

	table: EV_TABLE
		-- Widget that test is to be performed on.

end -- class TABLE_SINGLE_CHILD
