indexing
	description: "Objects that test EV_MULTI_COLUMN_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW
		do
			create multi_column_list
			multi_column_list.set_minimum_size (300, 300)
			
				-- Build the first row.
			create multi_column_list_row
			multi_column_list_row.fill (<<"1, 1", "2, 1", "3, 1">>)
			multi_column_list.extend (multi_column_list_row)
			
				-- Build the second row.
			create multi_column_list_row
			multi_column_list_row.fill (<<"1, 2", "2, 2", "3, 2">>)
			multi_column_list.extend (multi_column_list_row)
			
				-- Build the third row.		
			create multi_column_list_row
			multi_column_list_row.fill (<<"1, 3", "2, 3", "3, 3">>)
			multi_column_list.extend (multi_column_list_row)
			
			widget := multi_column_list
		end
		
feature {NONE} -- Implementation

	multi_column_list: EV_MULTI_COLUMN_LIST

end -- class MULTI_COLUMN_LIST_BASIC_TEST
