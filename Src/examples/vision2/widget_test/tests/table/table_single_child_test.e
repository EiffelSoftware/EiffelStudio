indexing
	description: "Objects that test EV_TABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_SINGLE_CHILD_TEST

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
			create button.make_with_text ("A button")
			table.put (button, 1, 1, 1, 1)
			
			widget := table
		end
		
feature {NONE} -- Implementation

	table: EV_TABLE

end -- class TABLE_SINGLE_CHILD
