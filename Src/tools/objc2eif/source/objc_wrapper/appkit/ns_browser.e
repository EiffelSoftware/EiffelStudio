note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BROWSER

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSBrowser

	load_column_zero
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_load_column_zero (item)
		end

	is_loaded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_loaded (item)
		end

	set_double_action_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_set_double_action_ (item, a_selector__item)
		end

	double_action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_double_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_matrix_class_ (a_factory_id: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			a_factory_id__item: POINTER
		do
			if attached a_factory_id as a_factory_id_attached then
				a_factory_id__item := a_factory_id_attached.item
			end
			objc_set_matrix_class_ (item, a_factory_id__item)
		end

	matrix_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_matrix_class (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like matrix_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like matrix_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_cell_class_ (a_factory_id: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			a_factory_id__item: POINTER
		do
			if attached a_factory_id as a_factory_id_attached then
				a_factory_id__item := a_factory_id_attached.item
			end
			objc_set_cell_class_ (item, a_factory_id__item)
		end

	set_cell_prototype_ (a_cell: detachable NS_CELL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_cell_prototype_ (item, a_cell__item)
		end

	cell_prototype: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_cell_prototype (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like cell_prototype} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like cell_prototype} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (an_object: detachable NS_BROWSER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_BROWSER_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_reuses_columns_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_reuses_columns_ (item, a_flag)
		end

	reuses_columns: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_reuses_columns (item)
		end

	set_has_horizontal_scroller_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_has_horizontal_scroller_ (item, a_flag)
		end

	has_horizontal_scroller: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_horizontal_scroller (item)
		end

	set_autohides_scroller_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autohides_scroller_ (item, a_flag)
		end

	autohides_scroller: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autohides_scroller (item)
		end

	set_separates_columns_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_separates_columns_ (item, a_flag)
		end

	separates_columns: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_separates_columns (item)
		end

	set_titled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_titled_ (item, a_flag)
		end

	is_titled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_titled (item)
		end

	set_min_column_width_ (a_column_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_column_width_ (item, a_column_width)
		end

	min_column_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_column_width (item)
		end

	set_max_visible_columns_ (a_column_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_visible_columns_ (item, a_column_count)
		end

	max_visible_columns: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_visible_columns (item)
		end

	set_allows_multiple_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_multiple_selection_ (item, a_flag)
		end

	allows_multiple_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_multiple_selection (item)
		end

	set_allows_branch_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_branch_selection_ (item, a_flag)
		end

	allows_branch_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_branch_selection (item)
		end

	set_allows_empty_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_empty_selection_ (item, a_flag)
		end

	allows_empty_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_empty_selection (item)
		end

	set_takes_title_from_previous_column_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_takes_title_from_previous_column_ (item, a_flag)
		end

	takes_title_from_previous_column: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_takes_title_from_previous_column (item)
		end

	set_sends_action_on_arrow_keys_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_sends_action_on_arrow_keys_ (item, a_flag)
		end

	sends_action_on_arrow_keys: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_sends_action_on_arrow_keys (item)
		end

	item_at_index_path_ (a_index_path: detachable NS_INDEX_PATH): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_index_path__item: POINTER
		do
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			result_pointer := objc_item_at_index_path_ (item, a_index_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_at_index_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_at_index_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	item_at_row__in_column_ (a_row: INTEGER_64; a_column: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_at_row__in_column_ (item, a_row, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_at_row__in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_at_row__in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_path_for_column_ (a_column: INTEGER_64): detachable NS_INDEX_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_index_path_for_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like index_path_for_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like index_path_for_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_leaf_item_ (a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_is_leaf_item_ (item, a_item__item)
		end

	reload_data_for_row_indexes__in_column_ (a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_row_indexes__item: POINTER
		do
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			objc_reload_data_for_row_indexes__in_column_ (item, a_row_indexes__item, a_column)
		end

	parent_for_items_in_column_ (a_column: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parent_for_items_in_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent_for_items_in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent_for_items_in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	scroll_row_to_visible__in_column_ (a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_row_to_visible__in_column_ (item, a_row, a_column)
		end

	set_title__of_column_ (a_string: detachable NS_STRING; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_title__of_column_ (item, a_string__item, a_column)
		end

	title_of_column_ (a_column: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title_of_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_of_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_of_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_path_separator_ (a_new_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_new_string__item: POINTER
		do
			if attached a_new_string as a_new_string_attached then
				a_new_string__item := a_new_string_attached.item
			end
			objc_set_path_separator_ (item, a_new_string__item)
		end

	path_separator: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_separator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_separator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_separator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_path_ (a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_set_path_ (item, a_path__item)
		end

	path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_to_column_ (a_column: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_to_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_to_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_to_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	clicked_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_clicked_column (item)
		end

	clicked_row: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_clicked_row (item)
		end

	selected_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_column (item)
		end

	selected_cell_in_column_ (a_column: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_cell_in_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_cell_in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_cell_in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_cells: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_cells (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_cells} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_cells} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	select_row__in_column_ (a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_select_row__in_column_ (item, a_row, a_column)
		end

	selected_row_in_column_ (a_column: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_row_in_column_ (item, a_column)
		end

	selection_index_path: detachable NS_INDEX_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selection_index_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selection_index_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selection_index_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selection_index_path_ (a_path: detachable NS_INDEX_PATH)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_set_selection_index_path_ (item, a_path__item)
		end

	selection_index_paths: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selection_index_paths (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selection_index_paths} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selection_index_paths} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selection_index_paths_ (a_paths: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_paths__item: POINTER
		do
			if attached a_paths as a_paths_attached then
				a_paths__item := a_paths_attached.item
			end
			objc_set_selection_index_paths_ (item, a_paths__item)
		end

	select_row_indexes__in_column_ (a_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_select_row_indexes__in_column_ (item, a_indexes__item, a_column)
		end

	selected_row_indexes_in_column_ (a_column: INTEGER_64): detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_row_indexes_in_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_row_indexes_in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_row_indexes_in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reload_column_ (a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reload_column_ (item, a_column)
		end

	validate_visible_columns
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_validate_visible_columns (item)
		end

	scroll_columns_right_by_ (a_shift_amount: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_columns_right_by_ (item, a_shift_amount)
		end

	scroll_columns_left_by_ (a_shift_amount: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_columns_left_by_ (item, a_shift_amount)
		end

	scroll_column_to_visible_ (a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_column_to_visible_ (item, a_column)
		end

	last_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_last_column (item)
		end

	set_last_column_ (a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_last_column_ (item, a_column)
		end

	add_column
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_column (item)
		end

	number_of_visible_columns: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_visible_columns (item)
		end

	first_visible_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_first_visible_column (item)
		end

	last_visible_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_last_visible_column (item)
		end

	column_of_matrix_ (a_matrix: detachable NS_MATRIX): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_matrix__item: POINTER
		do
			if attached a_matrix as a_matrix_attached then
				a_matrix__item := a_matrix_attached.item
			end
			Result := objc_column_of_matrix_ (item, a_matrix__item)
		end

	matrix_in_column_ (a_column: INTEGER_64): detachable NS_MATRIX
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_matrix_in_column_ (item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like matrix_in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like matrix_in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	loaded_cell_at_row__column_ (a_row: INTEGER_64; a_col: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_loaded_cell_at_row__column_ (item, a_row, a_col)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like loaded_cell_at_row__column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like loaded_cell_at_row__column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tile
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_tile (item)
		end

	do_click_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_do_click_ (item, a_sender__item)
		end

	do_double_click_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_do_double_click_ (item, a_sender__item)
		end

	send_action: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_send_action (item)
		end

	title_frame_of_column_ (a_column: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_title_frame_of_column_ (item, Result.item, a_column)
		end

	draw_title_of_column__in_rect_ (a_column: INTEGER_64; a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_title_of_column__in_rect_ (item, a_column, a_rect.item)
		end

	title_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_height (item)
		end

	frame_of_column_ (a_column: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_of_column_ (item, Result.item, a_column)
		end

	frame_of_inside_of_column_ (a_column: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_of_inside_of_column_ (item, Result.item, a_column)
		end

	frame_of_row__in_column_ (a_row: INTEGER_64; a_column: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_of_row__in_column_ (item, Result.item, a_row, a_column)
		end

--	get_row__column__for_point_ (a_row: UNSUPPORTED_TYPE; a_column: UNSUPPORTED_TYPE; a_point: NS_POINT): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_row__item: POINTER
--			a_column__item: POINTER
--		do
--			if attached a_row as a_row_attached then
--				a_row__item := a_row_attached.item
--			end
--			if attached a_column as a_column_attached then
--				a_column__item := a_column_attached.item
--			end
--			Result := objc_get_row__column__for_point_ (item, a_row__item, a_column__item, a_point.item)
--		end

	column_width_for_column_content_width_ (a_column_content_width: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_width_for_column_content_width_ (item, a_column_content_width)
		end

	column_content_width_for_column_width_ (a_column_width: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_content_width_for_column_width_ (item, a_column_width)
		end

	set_column_resizing_type_ (a_column_resizing_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_column_resizing_type_ (item, a_column_resizing_type)
		end

	column_resizing_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_resizing_type (item)
		end

	set_prefers_all_column_user_resizing_ (a_prefers_all_column_resizing: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_prefers_all_column_user_resizing_ (item, a_prefers_all_column_resizing)
		end

	prefers_all_column_user_resizing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_prefers_all_column_user_resizing (item)
		end

	set_width__of_column_ (a_column_width: REAL_64; a_column_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_width__of_column_ (item, a_column_width, a_column_index)
		end

	width_of_column_ (a_column: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width_of_column_ (item, a_column)
		end

	set_row_height_ (a_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_row_height_ (item, a_height)
		end

	row_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_row_height (item)
		end

	note_height_of_rows_with_indexes_changed__in_column_ (a_index_set: detachable NS_INDEX_SET; a_column_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			objc_note_height_of_rows_with_indexes_changed__in_column_ (item, a_index_set__item, a_column_index)
		end

	set_default_column_width_ (a_column_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_default_column_width_ (item, a_column_width)
		end

	default_column_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_default_column_width (item)
		end

	set_columns_autosave_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_columns_autosave_name_ (item, a_name__item)
		end

	columns_autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_columns_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like columns_autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like columns_autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	can_drag_rows_with_indexes__in_column__with_event_ (a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64; a_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_row_indexes__item: POINTER
			a_event__item: POINTER
		do
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_can_drag_rows_with_indexes__in_column__with_event_ (item, a_row_indexes__item, a_column, a_event__item)
		end

--	dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64; a_event: detachable NS_EVENT; a_drag_image_offset: UNSUPPORTED_TYPE): detachable NS_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_row_indexes__item: POINTER
--			a_event__item: POINTER
--			a_drag_image_offset__item: POINTER
--		do
--			if attached a_row_indexes as a_row_indexes_attached then
--				a_row_indexes__item := a_row_indexes_attached.item
--			end
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_drag_image_offset as a_drag_image_offset_attached then
--				a_drag_image_offset__item := a_drag_image_offset_attached.item
--			end
--			result_pointer := objc_dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (item, a_row_indexes__item, a_column, a_event__item, a_drag_image_offset__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like dragging_image_for_rows_with_indexes__in_column__with_event__offset_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like dragging_image_for_rows_with_indexes__in_column__with_event__offset_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_dragging_source_operation_mask__for_local_ (a_mask: NATURAL_64; a_is_local: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_dragging_source_operation_mask__for_local_ (item, a_mask, a_is_local)
		end

	allows_type_select: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_type_select (item)
		end

	set_allows_type_select_ (a_value: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_type_select_ (item, a_value)
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	edit_item_at_index_path__with_event__select_ (a_index_path: detachable NS_INDEX_PATH; a_the_event: detachable NS_EVENT; a_select: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_index_path__item: POINTER
			a_the_event__item: POINTER
		do
			if attached a_index_path as a_index_path_attached then
				a_index_path__item := a_index_path_attached.item
			end
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_edit_item_at_index_path__with_event__select_ (item, a_index_path__item, a_the_event__item, a_select)
		end

feature {NONE} -- NSBrowser Externals

	objc_load_column_zero (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item loadColumnZero];
			 ]"
		end

	objc_is_loaded (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item isLoaded];
			 ]"
		end

	objc_set_double_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setDoubleAction:$a_selector];
			 ]"
		end

	objc_double_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item doubleAction];
			 ]"
		end

	objc_set_matrix_class_ (an_item: POINTER; a_factory_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setMatrixClass:$a_factory_id];
			 ]"
		end

	objc_matrix_class (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item matrixClass];
			 ]"
		end

	objc_set_cell_class_ (an_item: POINTER; a_factory_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setCellClass:$a_factory_id];
			 ]"
		end

	objc_set_cell_prototype_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setCellPrototype:$a_cell];
			 ]"
		end

	objc_cell_prototype (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item cellPrototype];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item delegate];
			 ]"
		end

	objc_set_reuses_columns_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setReusesColumns:$a_flag];
			 ]"
		end

	objc_reuses_columns (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item reusesColumns];
			 ]"
		end

	objc_set_has_horizontal_scroller_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setHasHorizontalScroller:$a_flag];
			 ]"
		end

	objc_has_horizontal_scroller (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item hasHorizontalScroller];
			 ]"
		end

	objc_set_autohides_scroller_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setAutohidesScroller:$a_flag];
			 ]"
		end

	objc_autohides_scroller (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item autohidesScroller];
			 ]"
		end

	objc_set_separates_columns_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setSeparatesColumns:$a_flag];
			 ]"
		end

	objc_separates_columns (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item separatesColumns];
			 ]"
		end

	objc_set_titled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setTitled:$a_flag];
			 ]"
		end

	objc_is_titled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item isTitled];
			 ]"
		end

	objc_set_min_column_width_ (an_item: POINTER; a_column_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setMinColumnWidth:$a_column_width];
			 ]"
		end

	objc_min_column_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item minColumnWidth];
			 ]"
		end

	objc_set_max_visible_columns_ (an_item: POINTER; a_column_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setMaxVisibleColumns:$a_column_count];
			 ]"
		end

	objc_max_visible_columns (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item maxVisibleColumns];
			 ]"
		end

	objc_set_allows_multiple_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setAllowsMultipleSelection:$a_flag];
			 ]"
		end

	objc_allows_multiple_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item allowsMultipleSelection];
			 ]"
		end

	objc_set_allows_branch_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setAllowsBranchSelection:$a_flag];
			 ]"
		end

	objc_allows_branch_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item allowsBranchSelection];
			 ]"
		end

	objc_set_allows_empty_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setAllowsEmptySelection:$a_flag];
			 ]"
		end

	objc_allows_empty_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item allowsEmptySelection];
			 ]"
		end

	objc_set_takes_title_from_previous_column_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setTakesTitleFromPreviousColumn:$a_flag];
			 ]"
		end

	objc_takes_title_from_previous_column (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item takesTitleFromPreviousColumn];
			 ]"
		end

	objc_set_sends_action_on_arrow_keys_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setSendsActionOnArrowKeys:$a_flag];
			 ]"
		end

	objc_sends_action_on_arrow_keys (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item sendsActionOnArrowKeys];
			 ]"
		end

	objc_item_at_index_path_ (an_item: POINTER; a_index_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item itemAtIndexPath:$a_index_path];
			 ]"
		end

	objc_item_at_row__in_column_ (an_item: POINTER; a_row: INTEGER_64; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item itemAtRow:$a_row inColumn:$a_column];
			 ]"
		end

	objc_index_path_for_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item indexPathForColumn:$a_column];
			 ]"
		end

	objc_is_leaf_item_ (an_item: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item isLeafItem:$a_item];
			 ]"
		end

	objc_reload_data_for_row_indexes__in_column_ (an_item: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item reloadDataForRowIndexes:$a_row_indexes inColumn:$a_column];
			 ]"
		end

	objc_parent_for_items_in_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item parentForItemsInColumn:$a_column];
			 ]"
		end

	objc_scroll_row_to_visible__in_column_ (an_item: POINTER; a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item scrollRowToVisible:$a_row inColumn:$a_column];
			 ]"
		end

	objc_set_title__of_column_ (an_item: POINTER; a_string: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setTitle:$a_string ofColumn:$a_column];
			 ]"
		end

	objc_title_of_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item titleOfColumn:$a_column];
			 ]"
		end

	objc_set_path_separator_ (an_item: POINTER; a_new_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setPathSeparator:$a_new_string];
			 ]"
		end

	objc_path_separator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item pathSeparator];
			 ]"
		end

	objc_set_path_ (an_item: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item setPath:$a_path];
			 ]"
		end

	objc_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item path];
			 ]"
		end

	objc_path_to_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item pathToColumn:$a_column];
			 ]"
		end

	objc_clicked_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item clickedColumn];
			 ]"
		end

	objc_clicked_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item clickedRow];
			 ]"
		end

	objc_selected_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item selectedColumn];
			 ]"
		end

	objc_selected_cell_in_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item selectedCellInColumn:$a_column];
			 ]"
		end

	objc_selected_cells (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item selectedCells];
			 ]"
		end

	objc_select_row__in_column_ (an_item: POINTER; a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item selectRow:$a_row inColumn:$a_column];
			 ]"
		end

	objc_selected_row_in_column_ (an_item: POINTER; a_column: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item selectedRowInColumn:$a_column];
			 ]"
		end

	objc_selection_index_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item selectionIndexPath];
			 ]"
		end

	objc_set_selection_index_path_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setSelectionIndexPath:$a_path];
			 ]"
		end

	objc_selection_index_paths (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item selectionIndexPaths];
			 ]"
		end

	objc_set_selection_index_paths_ (an_item: POINTER; a_paths: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setSelectionIndexPaths:$a_paths];
			 ]"
		end

	objc_select_row_indexes__in_column_ (an_item: POINTER; a_indexes: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item selectRowIndexes:$a_indexes inColumn:$a_column];
			 ]"
		end

	objc_selected_row_indexes_in_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item selectedRowIndexesInColumn:$a_column];
			 ]"
		end

	objc_reload_column_ (an_item: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item reloadColumn:$a_column];
			 ]"
		end

	objc_validate_visible_columns (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item validateVisibleColumns];
			 ]"
		end

	objc_scroll_columns_right_by_ (an_item: POINTER; a_shift_amount: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item scrollColumnsRightBy:$a_shift_amount];
			 ]"
		end

	objc_scroll_columns_left_by_ (an_item: POINTER; a_shift_amount: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item scrollColumnsLeftBy:$a_shift_amount];
			 ]"
		end

	objc_scroll_column_to_visible_ (an_item: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item scrollColumnToVisible:$a_column];
			 ]"
		end

	objc_last_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item lastColumn];
			 ]"
		end

	objc_set_last_column_ (an_item: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setLastColumn:$a_column];
			 ]"
		end

	objc_add_column (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item addColumn];
			 ]"
		end

	objc_number_of_visible_columns (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item numberOfVisibleColumns];
			 ]"
		end

	objc_first_visible_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item firstVisibleColumn];
			 ]"
		end

	objc_last_visible_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item lastVisibleColumn];
			 ]"
		end

	objc_column_of_matrix_ (an_item: POINTER; a_matrix: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item columnOfMatrix:$a_matrix];
			 ]"
		end

	objc_matrix_in_column_ (an_item: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item matrixInColumn:$a_column];
			 ]"
		end

	objc_loaded_cell_at_row__column_ (an_item: POINTER; a_row: INTEGER_64; a_col: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item loadedCellAtRow:$a_row column:$a_col];
			 ]"
		end

	objc_tile (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item tile];
			 ]"
		end

	objc_do_click_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item doClick:$a_sender];
			 ]"
		end

	objc_do_double_click_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item doDoubleClick:$a_sender];
			 ]"
		end

	objc_send_action (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item sendAction];
			 ]"
		end

	objc_title_frame_of_column_ (an_item: POINTER; result_pointer: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBrowser *)$an_item titleFrameOfColumn:$a_column];
			 ]"
		end

	objc_draw_title_of_column__in_rect_ (an_item: POINTER; a_column: INTEGER_64; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item drawTitleOfColumn:$a_column inRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_title_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item titleHeight];
			 ]"
		end

	objc_frame_of_column_ (an_item: POINTER; result_pointer: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBrowser *)$an_item frameOfColumn:$a_column];
			 ]"
		end

	objc_frame_of_inside_of_column_ (an_item: POINTER; result_pointer: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBrowser *)$an_item frameOfInsideOfColumn:$a_column];
			 ]"
		end

	objc_frame_of_row__in_column_ (an_item: POINTER; result_pointer: POINTER; a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBrowser *)$an_item frameOfRow:$a_row inColumn:$a_column];
			 ]"
		end

--	objc_get_row__column__for_point_ (an_item: POINTER; a_row: UNSUPPORTED_TYPE; a_column: UNSUPPORTED_TYPE; a_point: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSBrowser *)$an_item getRow: column: forPoint:*((NSPoint *)$a_point)];
--			 ]"
--		end

	objc_column_width_for_column_content_width_ (an_item: POINTER; a_column_content_width: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item columnWidthForColumnContentWidth:$a_column_content_width];
			 ]"
		end

	objc_column_content_width_for_column_width_ (an_item: POINTER; a_column_width: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item columnContentWidthForColumnWidth:$a_column_width];
			 ]"
		end

	objc_set_column_resizing_type_ (an_item: POINTER; a_column_resizing_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setColumnResizingType:$a_column_resizing_type];
			 ]"
		end

	objc_column_resizing_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item columnResizingType];
			 ]"
		end

	objc_set_prefers_all_column_user_resizing_ (an_item: POINTER; a_prefers_all_column_resizing: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setPrefersAllColumnUserResizing:$a_prefers_all_column_resizing];
			 ]"
		end

	objc_prefers_all_column_user_resizing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item prefersAllColumnUserResizing];
			 ]"
		end

	objc_set_width__of_column_ (an_item: POINTER; a_column_width: REAL_64; a_column_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setWidth:$a_column_width ofColumn:$a_column_index];
			 ]"
		end

	objc_width_of_column_ (an_item: POINTER; a_column: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item widthOfColumn:$a_column];
			 ]"
		end

	objc_set_row_height_ (an_item: POINTER; a_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setRowHeight:$a_height];
			 ]"
		end

	objc_row_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item rowHeight];
			 ]"
		end

	objc_note_height_of_rows_with_indexes_changed__in_column_ (an_item: POINTER; a_index_set: POINTER; a_column_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item noteHeightOfRowsWithIndexesChanged:$a_index_set inColumn:$a_column_index];
			 ]"
		end

	objc_set_default_column_width_ (an_item: POINTER; a_column_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setDefaultColumnWidth:$a_column_width];
			 ]"
		end

	objc_default_column_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item defaultColumnWidth];
			 ]"
		end

	objc_set_columns_autosave_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setColumnsAutosaveName:$a_name];
			 ]"
		end

	objc_columns_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item columnsAutosaveName];
			 ]"
		end

	objc_can_drag_rows_with_indexes__in_column__with_event_ (an_item: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64; a_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item canDragRowsWithIndexes:$a_row_indexes inColumn:$a_column withEvent:$a_event];
			 ]"
		end

--	objc_dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (an_item: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64; a_event: POINTER; a_drag_image_offset: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSBrowser *)$an_item draggingImageForRowsWithIndexes:$a_row_indexes inColumn:$a_column withEvent:$a_event offset:];
--			 ]"
--		end

	objc_set_dragging_source_operation_mask__for_local_ (an_item: POINTER; a_mask: NATURAL_64; a_is_local: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setDraggingSourceOperationMask:$a_mask forLocal:$a_is_local];
			 ]"
		end

	objc_allows_type_select (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBrowser *)$an_item allowsTypeSelect];
			 ]"
		end

	objc_set_allows_type_select_ (an_item: POINTER; a_value: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setAllowsTypeSelect:$a_value];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBrowser *)$an_item backgroundColor];
			 ]"
		end

	objc_edit_item_at_index_path__with_event__select_ (an_item: POINTER; a_index_path: POINTER; a_the_event: POINTER; a_select: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBrowser *)$an_item editItemAtIndexPath:$a_index_path withEvent:$a_the_event select:$a_select];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBrowser"
		end

end
