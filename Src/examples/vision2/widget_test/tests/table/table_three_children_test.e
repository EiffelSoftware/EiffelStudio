indexing
	description: "Objects that test EV_TABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_THREE_CHILDREN_TEST

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
			table.resize (3, 3)
			create button.make_with_text ("Spans two cells")
			table.put (button, 1, 1, 2, 1)
			create button.make_with_text ("Spans three cells")
			table.put (button, 3, 1, 1, 3)
			create button.make_with_text ("Spans four cells")
			table.put (button, 1, 2, 2, 2)

			widget := table
		end
		
feature {NONE} -- Implementation

	table: EV_TABLE

end -- class TABLE_THREE_CHILDREN_TEST
