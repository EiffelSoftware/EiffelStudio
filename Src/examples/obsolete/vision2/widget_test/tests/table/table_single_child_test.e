indexing
	description: "Objects that test EV_TABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	table: EV_TABLE;
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


end -- class TABLE_SINGLE_CHILD
