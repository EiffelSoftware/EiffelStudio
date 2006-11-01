indexing
	description: "Objects that test EV_MULTI_COLUMN_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW
		do
			create multi_column_list
			multi_column_list.set_minimum_size (300, 300)
			
				-- Build the first row.
			create multi_column_list_row
			multi_column_list_row.fill (<<("1, 1").to_string_32, ("2, 1").to_string_32, ("3, 1").to_string_32>>)
			multi_column_list.extend (multi_column_list_row)
			
				-- Build the second row.
			create multi_column_list_row
			multi_column_list_row.fill (<<("1, 2").to_string_32, ("2, 2").to_string_32, ("3, 2").to_string_32>>)
			multi_column_list.extend (multi_column_list_row)
			
				-- Build the third row.		
			create multi_column_list_row
			multi_column_list_row.fill (<<("1, 3").to_string_32, ("2, 3").to_string_32, ("3, 3").to_string_32>>)
			multi_column_list.extend (multi_column_list_row)
			
			widget := multi_column_list
		end
		
feature {NONE} -- Implementation

	multi_column_list: EV_MULTI_COLUMN_LIST;
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


end -- class MULTI_COLUMN_LIST_BASIC_TEST
