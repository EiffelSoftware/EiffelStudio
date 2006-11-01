indexing
	description: "Objects that test EV_MULTI_COLUMN_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_COLUMN_RESIZING_TEST

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
			multi_column_list_row.fill (<<
				("Please resize column").to_string_32,
				("Please resize column").to_string_32,
				("Please resize column").to_string_32>>)
			multi_column_list.extend (multi_column_list_row)
			multi_column_list.column_resized_actions.extend (agent update_width_information)
			widget := multi_column_list
		end
		
feature {NONE} -- Implementation

	multi_column_list: EV_MULTI_COLUMN_LIST
		-- Widget that test is to be performed on.
	
	update_width_information (column_number: INTEGER) is
			-- Update the text of the first row in `column_number' to
			-- the width of the column `column_number'.
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			row := multi_column_list.i_th (1)
			row.go_i_th (column_number)
			row.replace (multi_column_list.column_width (column_number).out)
		end

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


end -- class MULTI_COLUMN_LIST_COLUMN_RESIZING_TEST
