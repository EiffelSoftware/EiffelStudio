indexing
	description: "Objects that test EV_MULTI_COLUMN_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_COLUMN_RESIZING_TEST

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
			multi_column_list.column_resized_actions.extend (agent update_width_information)
			multi_column_list_row.fill (<<"Please resize column", "Please resize column", "Please resize column">>)
			multi_column_list.extend (multi_column_list_row)
			widget := multi_column_list
		end
		
feature {NONE} -- Implementation

	multi_column_list: EV_MULTI_COLUMN_LIST
	
	update_width_information (column_number: INTEGER) is
			--
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			row := multi_column_list.i_th (1)
			row.go_i_th (column_number)
			row.replace (multi_column_list.column_width (column_number).out)
		end

end -- class MULTI_COLUMN_LIST_COLUMN_RESIZING_TEST