indexing
	description: "Objects that test EV_MULTI_COLUMN_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_MULTIPLE_SELECTION_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
	EXECUTION_ENVIRONMENT
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW
			counter: INTEGER
			vertical_box: EV_VERTICAL_BOX
		do
			create multi_column_list
			multi_column_list.set_column_title ("Selected?", 3)
			create vertical_box
			vertical_box.set_minimum_size (300, 300)
			create multiple_selection_button.make_with_text ("Multiple selection? - Hold %"Ctrl%" while selecting.")
			multiple_selection_button.select_actions.extend (agent adjust_selection)
			
			vertical_box.extend (multi_column_list)
			vertical_box.extend (multiple_selection_button)
			vertical_box.disable_item_expand (multiple_selection_button)
			
			from
				counter := 1
			until
				counter > 25
			loop
				create multi_column_list_row
				multi_column_list_row.fill (<<"1, " + counter.out, "2, " + counter.out, "No">>)
				multi_column_list_row.select_actions.extend (agent update_selection_on_row (multi_column_list_row))
				multi_column_list_row.deselect_actions.extend (agent update_selection_on_row (multi_column_list_row))
				multi_column_list.extend (multi_column_list_row)
				counter := counter + 1
			end
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	multi_column_list: EV_MULTI_COLUMN_LIST
	
	multiple_selection_button: EV_CHECK_BUTTON
	
	adjust_selection is
			-- Toggle selection of `multi_column_list' between single
			-- and multiple based on state of `multiple_selection_button'.
		do
			if multiple_selection_button.is_selected then
				multi_column_list.enable_multiple_selection
			else
				multi_column_list.disable_multiple_selection
			end
		end
		
	update_selection_on_row (row: EV_MULTI_COLUMN_LIST_ROW) is
			-- Display selected state of `row' within `row'.
		require
			row_not_void: row /= Void
			row_has_three_items: row.count = 3
		do
			row.go_i_th (3)
			if row.is_selected then		
				row.replace ("Yes")
			else
				row.replace ("No")
			end
		end

end -- class MULTI_COLUMN_LIST_MULTIPLE_SELECTION_TEST
