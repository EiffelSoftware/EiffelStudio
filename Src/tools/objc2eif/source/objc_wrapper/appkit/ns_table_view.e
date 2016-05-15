note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TABLE_VIEW

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end

	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL
	NS_TEXT_VIEW_DELEGATE_PROTOCOL
		undefine
			text_should_begin_editing_,
			objc_text_should_begin_editing_,
			text_should_end_editing_,
			objc_text_should_end_editing_,
			text_did_begin_editing_,
			objc_text_did_begin_editing_,
			text_did_end_editing_,
			objc_text_did_end_editing_,
			text_did_change_,
			objc_text_did_change_
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSTableView

	set_data_source_ (a_source: detachable NS_TABLE_VIEW_DATA_SOURCE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_source__item: POINTER
		do
			if attached a_source as a_source_attached then
				a_source__item := a_source_attached.item
			end
			objc_set_data_source_ (item, a_source__item)
		end

	data_source: detachable NS_TABLE_VIEW_DATA_SOURCE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_source (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_source} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_source} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (a_delegate: detachable NS_TABLE_VIEW_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_TABLE_VIEW_DELEGATE_PROTOCOL
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

	set_header_view_ (a_header_view: detachable NS_TABLE_HEADER_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_header_view__item: POINTER
		do
			if attached a_header_view as a_header_view_attached then
				a_header_view__item := a_header_view_attached.item
			end
			objc_set_header_view_ (item, a_header_view__item)
		end

	header_view: detachable NS_TABLE_HEADER_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_header_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like header_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like header_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_corner_view_ (a_corner_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_corner_view__item: POINTER
		do
			if attached a_corner_view as a_corner_view_attached then
				a_corner_view__item := a_corner_view_attached.item
			end
			objc_set_corner_view_ (item, a_corner_view__item)
		end

	corner_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_corner_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like corner_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like corner_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_allows_column_reordering_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_column_reordering_ (item, a_flag)
		end

	allows_column_reordering: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_column_reordering (item)
		end

	set_allows_column_resizing_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_column_resizing_ (item, a_flag)
		end

	allows_column_resizing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_column_resizing (item)
		end

	set_column_autoresizing_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_column_autoresizing_style_ (item, a_style)
		end

	column_autoresizing_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_autoresizing_style (item)
		end

	set_grid_style_mask_ (a_grid_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_grid_style_mask_ (item, a_grid_type)
		end

	grid_style_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_grid_style_mask (item)
		end

	set_intercell_spacing_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_intercell_spacing_ (item, a_size.item)
		end

	intercell_spacing: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_intercell_spacing (item, Result.item)
		end

	set_uses_alternating_row_background_colors_ (a_use_alternating_row_colors: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_alternating_row_background_colors_ (item, a_use_alternating_row_colors)
		end

	uses_alternating_row_background_colors: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_alternating_row_background_colors (item)
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

	set_grid_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_grid_color_ (item, a_color__item)
		end

	grid_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_grid_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like grid_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like grid_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_row_height_ (a_row_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_row_height_ (item, a_row_height)
		end

	row_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_row_height (item)
		end

	note_height_of_rows_with_indexes_changed_ (a_index_set: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			objc_note_height_of_rows_with_indexes_changed_ (item, a_index_set__item)
		end

	table_columns: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_table_columns (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_columns} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_columns} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_of_columns: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_columns (item)
		end

	number_of_rows: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_rows (item)
		end

	add_table_column_ (a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		local
			a_table_column__item: POINTER
		do
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_add_table_column_ (item, a_table_column__item)
		end

	remove_table_column_ (a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		local
			a_table_column__item: POINTER
		do
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_remove_table_column_ (item, a_table_column__item)
		end

	move_column__to_column_ (a_old_index: INTEGER_64; a_new_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_move_column__to_column_ (item, a_old_index, a_new_index)
		end

	column_with_identifier_ (a_identifier: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			Result := objc_column_with_identifier_ (item, a_identifier__item)
		end

	table_column_with_identifier_ (a_identifier: detachable NS_OBJECT): detachable NS_TABLE_COLUMN
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_identifier__item: POINTER
		do
			if attached a_identifier as a_identifier_attached then
				a_identifier__item := a_identifier_attached.item
			end
			result_pointer := objc_table_column_with_identifier_ (item, a_identifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_column_with_identifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_column_with_identifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	size_last_column_to_fit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_last_column_to_fit (item)
		end

	scroll_row_to_visible_ (a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_row_to_visible_ (item, a_row)
		end

	scroll_column_to_visible_ (a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_column_to_visible_ (item, a_column)
		end

	reload_data
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reload_data (item)
		end

	note_number_of_rows_changed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_note_number_of_rows_changed (item)
		end

	reload_data_for_row_indexes__column_indexes_ (a_row_indexes: detachable NS_INDEX_SET; a_column_indexes: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_row_indexes__item: POINTER
			a_column_indexes__item: POINTER
		do
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			if attached a_column_indexes as a_column_indexes_attached then
				a_column_indexes__item := a_column_indexes_attached.item
			end
			objc_reload_data_for_row_indexes__column_indexes_ (item, a_row_indexes__item, a_column_indexes__item)
		end

	edited_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_edited_column (item)
		end

	edited_row: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_edited_row (item)
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

	set_sort_descriptors_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_sort_descriptors_ (item, a_array__item)
		end

	sort_descriptors: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sort_descriptors (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sort_descriptors} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sort_descriptors} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_indicator_image__in_table_column_ (an_image: detachable NS_IMAGE; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		local
			an_image__item: POINTER
			a_table_column__item: POINTER
		do
			if attached an_image as an_image_attached then
				an_image__item := an_image_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_set_indicator_image__in_table_column_ (item, an_image__item, a_table_column__item)
		end

	indicator_image_in_table_column_ (a_table_column: detachable NS_TABLE_COLUMN): detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			result_pointer := objc_indicator_image_in_table_column_ (item, a_table_column__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like indicator_image_in_table_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like indicator_image_in_table_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_highlighted_table_column_ (a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		local
			a_table_column__item: POINTER
		do
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_set_highlighted_table_column_ (item, a_table_column__item)
		end

	highlighted_table_column: detachable NS_TABLE_COLUMN
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_highlighted_table_column (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like highlighted_table_column} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like highlighted_table_column} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_vertical_motion_can_begin_drag_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_vertical_motion_can_begin_drag_ (item, a_flag)
		end

	vertical_motion_can_begin_drag: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_vertical_motion_can_begin_drag (item)
		end

	can_drag_rows_with_indexes__at_point_ (a_row_indexes: detachable NS_INDEX_SET; a_mouse_down_point: NS_POINT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_row_indexes__item: POINTER
		do
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			Result := objc_can_drag_rows_with_indexes__at_point_ (item, a_row_indexes__item, a_mouse_down_point.item)
		end

--	drag_image_for_rows_with_indexes__table_columns__event__offset_ (a_drag_rows: detachable NS_INDEX_SET; a_table_columns: detachable NS_ARRAY; a_drag_event: detachable NS_EVENT; a_drag_image_offset: UNSUPPORTED_TYPE): detachable NS_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_drag_rows__item: POINTER
--			a_table_columns__item: POINTER
--			a_drag_event__item: POINTER
--			a_drag_image_offset__item: POINTER
--		do
--			if attached a_drag_rows as a_drag_rows_attached then
--				a_drag_rows__item := a_drag_rows_attached.item
--			end
--			if attached a_table_columns as a_table_columns_attached then
--				a_table_columns__item := a_table_columns_attached.item
--			end
--			if attached a_drag_event as a_drag_event_attached then
--				a_drag_event__item := a_drag_event_attached.item
--			end
--			if attached a_drag_image_offset as a_drag_image_offset_attached then
--				a_drag_image_offset__item := a_drag_image_offset_attached.item
--			end
--			result_pointer := objc_drag_image_for_rows_with_indexes__table_columns__event__offset_ (item, a_drag_rows__item, a_table_columns__item, a_drag_event__item, a_drag_image_offset__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like drag_image_for_rows_with_indexes__table_columns__event__offset_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like drag_image_for_rows_with_indexes__table_columns__event__offset_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	set_drop_row__drop_operation_ (a_row: INTEGER_64; a_drop_operation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_drop_row__drop_operation_ (item, a_row, a_drop_operation)
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

	set_allows_column_selection_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_column_selection_ (item, a_flag)
		end

	allows_column_selection: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_column_selection (item)
		end

	deselect_all_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_deselect_all_ (item, a_sender__item)
		end

	select_column_indexes__by_extending_selection_ (a_indexes: detachable NS_INDEX_SET; a_extend: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_select_column_indexes__by_extending_selection_ (item, a_indexes__item, a_extend)
		end

	select_row_indexes__by_extending_selection_ (a_indexes: detachable NS_INDEX_SET; a_extend: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_select_row_indexes__by_extending_selection_ (item, a_indexes__item, a_extend)
		end

	selected_column_indexes: detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_column_indexes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_column_indexes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_column_indexes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	selected_row_indexes: detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_row_indexes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_row_indexes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_row_indexes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	deselect_column_ (a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deselect_column_ (item, a_column)
		end

	deselect_row_ (a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deselect_row_ (item, a_row)
		end

	selected_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_column (item)
		end

	selected_row: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selected_row (item)
		end

	is_column_selected_ (a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_column_selected_ (item, a_column)
		end

	is_row_selected_ (a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_row_selected_ (item, a_row)
		end

	number_of_selected_columns: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_selected_columns (item)
		end

	number_of_selected_rows: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_selected_rows (item)
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

	selection_highlight_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_selection_highlight_style (item)
		end

	set_selection_highlight_style_ (a_selection_highlight_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selection_highlight_style_ (item, a_selection_highlight_style)
		end

	set_dragging_destination_feedback_style_ (a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_dragging_destination_feedback_style_ (item, a_style)
		end

	dragging_destination_feedback_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dragging_destination_feedback_style (item)
		end

	rect_of_column_ (a_column: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_of_column_ (item, Result.item, a_column)
		end

	rect_of_row_ (a_row: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_of_row_ (item, Result.item, a_row)
		end

	column_indexes_in_rect_ (a_rect: NS_RECT): detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_column_indexes_in_rect_ (item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like column_indexes_in_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like column_indexes_in_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rows_in_rect_ (a_rect: NS_RECT): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rows_in_rect_ (item, Result.item, a_rect.item)
		end

	column_at_point_ (a_point: NS_POINT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_at_point_ (item, a_point.item)
		end

	row_at_point_ (a_point: NS_POINT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_row_at_point_ (item, a_point.item)
		end

	frame_of_cell_at_column__row_ (a_column: INTEGER_64; a_row: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame_of_cell_at_column__row_ (item, Result.item, a_column, a_row)
		end

	prepared_cell_at_column__row_ (a_column: INTEGER_64; a_row: INTEGER_64): detachable NS_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_prepared_cell_at_column__row_ (item, a_column, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like prepared_cell_at_column__row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like prepared_cell_at_column__row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_should_begin_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_begin_editing_ (item, a_text_object__item)
		end

	text_should_end_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_end_editing_ (item, a_text_object__item)
		end

	text_did_begin_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_begin_editing_ (item, a_notification__item)
		end

	text_did_end_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_end_editing_ (item, a_notification__item)
		end

	text_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_change_ (item, a_notification__item)
		end

	set_autosave_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_autosave_name_ (item, a_name__item)
		end

	autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_autosave_table_columns_ (a_save: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autosave_table_columns_ (item, a_save)
		end

	autosave_table_columns: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autosave_table_columns (item)
		end

	should_focus_cell__at_column__row_ (a_cell: detachable NS_CELL; a_column: INTEGER_64; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			Result := objc_should_focus_cell__at_column__row_ (item, a_cell__item, a_column, a_row)
		end

	focused_column: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_focused_column (item)
		end

	set_focused_column_ (a_focused_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_focused_column_ (item, a_focused_column)
		end

	perform_click_on_cell_at_column__row_ (a_column: INTEGER_64; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_perform_click_on_cell_at_column__row_ (item, a_column, a_row)
		end

	edit_column__row__with_event__select_ (a_column: INTEGER_64; a_row: INTEGER_64; a_the_event: detachable NS_EVENT; a_select: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_edit_column__row__with_event__select_ (item, a_column, a_row, a_the_event__item, a_select)
		end

	draw_row__clip_rect_ (a_row: INTEGER_64; a_clip_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_row__clip_rect_ (item, a_row, a_clip_rect.item)
		end

	highlight_selection_in_clip_rect_ (a_clip_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_highlight_selection_in_clip_rect_ (item, a_clip_rect.item)
		end

	draw_grid_in_clip_rect_ (a_clip_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_grid_in_clip_rect_ (item, a_clip_rect.item)
		end

	draw_background_in_clip_rect_ (a_clip_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_background_in_clip_rect_ (item, a_clip_rect.item)
		end

feature {NONE} -- NSTableView Externals

	objc_set_data_source_ (an_item: POINTER; a_source: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setDataSource:$a_source];
			 ]"
		end

	objc_data_source (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item dataSource];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item delegate];
			 ]"
		end

	objc_set_header_view_ (an_item: POINTER; a_header_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setHeaderView:$a_header_view];
			 ]"
		end

	objc_header_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item headerView];
			 ]"
		end

	objc_set_corner_view_ (an_item: POINTER; a_corner_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setCornerView:$a_corner_view];
			 ]"
		end

	objc_corner_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item cornerView];
			 ]"
		end

	objc_set_allows_column_reordering_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAllowsColumnReordering:$a_flag];
			 ]"
		end

	objc_allows_column_reordering (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item allowsColumnReordering];
			 ]"
		end

	objc_set_allows_column_resizing_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAllowsColumnResizing:$a_flag];
			 ]"
		end

	objc_allows_column_resizing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item allowsColumnResizing];
			 ]"
		end

	objc_set_column_autoresizing_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setColumnAutoresizingStyle:$a_style];
			 ]"
		end

	objc_column_autoresizing_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item columnAutoresizingStyle];
			 ]"
		end

	objc_set_grid_style_mask_ (an_item: POINTER; a_grid_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setGridStyleMask:$a_grid_type];
			 ]"
		end

	objc_grid_style_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item gridStyleMask];
			 ]"
		end

	objc_set_intercell_spacing_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setIntercellSpacing:*((NSSize *)$a_size)];
			 ]"
		end

	objc_intercell_spacing (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSTableView *)$an_item intercellSpacing];
			 ]"
		end

	objc_set_uses_alternating_row_background_colors_ (an_item: POINTER; a_use_alternating_row_colors: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setUsesAlternatingRowBackgroundColors:$a_use_alternating_row_colors];
			 ]"
		end

	objc_uses_alternating_row_background_colors (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item usesAlternatingRowBackgroundColors];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item backgroundColor];
			 ]"
		end

	objc_set_grid_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setGridColor:$a_color];
			 ]"
		end

	objc_grid_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item gridColor];
			 ]"
		end

	objc_set_row_height_ (an_item: POINTER; a_row_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setRowHeight:$a_row_height];
			 ]"
		end

	objc_row_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item rowHeight];
			 ]"
		end

	objc_note_height_of_rows_with_indexes_changed_ (an_item: POINTER; a_index_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item noteHeightOfRowsWithIndexesChanged:$a_index_set];
			 ]"
		end

	objc_table_columns (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item tableColumns];
			 ]"
		end

	objc_number_of_columns (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item numberOfColumns];
			 ]"
		end

	objc_number_of_rows (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item numberOfRows];
			 ]"
		end

	objc_add_table_column_ (an_item: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item addTableColumn:$a_table_column];
			 ]"
		end

	objc_remove_table_column_ (an_item: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item removeTableColumn:$a_table_column];
			 ]"
		end

	objc_move_column__to_column_ (an_item: POINTER; a_old_index: INTEGER_64; a_new_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item moveColumn:$a_old_index toColumn:$a_new_index];
			 ]"
		end

	objc_column_with_identifier_ (an_item: POINTER; a_identifier: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item columnWithIdentifier:$a_identifier];
			 ]"
		end

	objc_table_column_with_identifier_ (an_item: POINTER; a_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item tableColumnWithIdentifier:$a_identifier];
			 ]"
		end

	objc_tile (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item tile];
			 ]"
		end

	objc_size_last_column_to_fit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item sizeLastColumnToFit];
			 ]"
		end

	objc_scroll_row_to_visible_ (an_item: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item scrollRowToVisible:$a_row];
			 ]"
		end

	objc_scroll_column_to_visible_ (an_item: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item scrollColumnToVisible:$a_column];
			 ]"
		end

	objc_reload_data (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item reloadData];
			 ]"
		end

	objc_note_number_of_rows_changed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item noteNumberOfRowsChanged];
			 ]"
		end

	objc_reload_data_for_row_indexes__column_indexes_ (an_item: POINTER; a_row_indexes: POINTER; a_column_indexes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item reloadDataForRowIndexes:$a_row_indexes columnIndexes:$a_column_indexes];
			 ]"
		end

	objc_edited_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item editedColumn];
			 ]"
		end

	objc_edited_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item editedRow];
			 ]"
		end

	objc_clicked_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item clickedColumn];
			 ]"
		end

	objc_clicked_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item clickedRow];
			 ]"
		end

	objc_set_double_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setDoubleAction:$a_selector];
			 ]"
		end

	objc_double_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item doubleAction];
			 ]"
		end

	objc_set_sort_descriptors_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setSortDescriptors:$a_array];
			 ]"
		end

	objc_sort_descriptors (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item sortDescriptors];
			 ]"
		end

	objc_set_indicator_image__in_table_column_ (an_item: POINTER; an_image: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setIndicatorImage:$an_image inTableColumn:$a_table_column];
			 ]"
		end

	objc_indicator_image_in_table_column_ (an_item: POINTER; a_table_column: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item indicatorImageInTableColumn:$a_table_column];
			 ]"
		end

	objc_set_highlighted_table_column_ (an_item: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setHighlightedTableColumn:$a_table_column];
			 ]"
		end

	objc_highlighted_table_column (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item highlightedTableColumn];
			 ]"
		end

	objc_set_vertical_motion_can_begin_drag_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setVerticalMotionCanBeginDrag:$a_flag];
			 ]"
		end

	objc_vertical_motion_can_begin_drag (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item verticalMotionCanBeginDrag];
			 ]"
		end

	objc_can_drag_rows_with_indexes__at_point_ (an_item: POINTER; a_row_indexes: POINTER; a_mouse_down_point: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item canDragRowsWithIndexes:$a_row_indexes atPoint:*((NSPoint *)$a_mouse_down_point)];
			 ]"
		end

--	objc_drag_image_for_rows_with_indexes__table_columns__event__offset_ (an_item: POINTER; a_drag_rows: POINTER; a_table_columns: POINTER; a_drag_event: POINTER; a_drag_image_offset: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSTableView *)$an_item dragImageForRowsWithIndexes:$a_drag_rows tableColumns:$a_table_columns event:$a_drag_event offset:];
--			 ]"
--		end

	objc_set_dragging_source_operation_mask__for_local_ (an_item: POINTER; a_mask: NATURAL_64; a_is_local: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setDraggingSourceOperationMask:$a_mask forLocal:$a_is_local];
			 ]"
		end

	objc_set_drop_row__drop_operation_ (an_item: POINTER; a_row: INTEGER_64; a_drop_operation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setDropRow:$a_row dropOperation:$a_drop_operation];
			 ]"
		end

	objc_set_allows_multiple_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAllowsMultipleSelection:$a_flag];
			 ]"
		end

	objc_allows_multiple_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item allowsMultipleSelection];
			 ]"
		end

	objc_set_allows_empty_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAllowsEmptySelection:$a_flag];
			 ]"
		end

	objc_allows_empty_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item allowsEmptySelection];
			 ]"
		end

	objc_set_allows_column_selection_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAllowsColumnSelection:$a_flag];
			 ]"
		end

	objc_allows_column_selection (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item allowsColumnSelection];
			 ]"
		end

	objc_deselect_all_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item deselectAll:$a_sender];
			 ]"
		end

	objc_select_column_indexes__by_extending_selection_ (an_item: POINTER; a_indexes: POINTER; a_extend: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item selectColumnIndexes:$a_indexes byExtendingSelection:$a_extend];
			 ]"
		end

	objc_select_row_indexes__by_extending_selection_ (an_item: POINTER; a_indexes: POINTER; a_extend: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item selectRowIndexes:$a_indexes byExtendingSelection:$a_extend];
			 ]"
		end

	objc_selected_column_indexes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item selectedColumnIndexes];
			 ]"
		end

	objc_selected_row_indexes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item selectedRowIndexes];
			 ]"
		end

	objc_deselect_column_ (an_item: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item deselectColumn:$a_column];
			 ]"
		end

	objc_deselect_row_ (an_item: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item deselectRow:$a_row];
			 ]"
		end

	objc_selected_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item selectedColumn];
			 ]"
		end

	objc_selected_row (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item selectedRow];
			 ]"
		end

	objc_is_column_selected_ (an_item: POINTER; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item isColumnSelected:$a_column];
			 ]"
		end

	objc_is_row_selected_ (an_item: POINTER; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item isRowSelected:$a_row];
			 ]"
		end

	objc_number_of_selected_columns (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item numberOfSelectedColumns];
			 ]"
		end

	objc_number_of_selected_rows (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item numberOfSelectedRows];
			 ]"
		end

	objc_allows_type_select (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item allowsTypeSelect];
			 ]"
		end

	objc_set_allows_type_select_ (an_item: POINTER; a_value: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAllowsTypeSelect:$a_value];
			 ]"
		end

	objc_selection_highlight_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item selectionHighlightStyle];
			 ]"
		end

	objc_set_selection_highlight_style_ (an_item: POINTER; a_selection_highlight_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setSelectionHighlightStyle:$a_selection_highlight_style];
			 ]"
		end

	objc_set_dragging_destination_feedback_style_ (an_item: POINTER; a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setDraggingDestinationFeedbackStyle:$a_style];
			 ]"
		end

	objc_dragging_destination_feedback_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item draggingDestinationFeedbackStyle];
			 ]"
		end

	objc_rect_of_column_ (an_item: POINTER; result_pointer: POINTER; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTableView *)$an_item rectOfColumn:$a_column];
			 ]"
		end

	objc_rect_of_row_ (an_item: POINTER; result_pointer: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTableView *)$an_item rectOfRow:$a_row];
			 ]"
		end

	objc_column_indexes_in_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item columnIndexesInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_rows_in_rect_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTableView *)$an_item rowsInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_column_at_point_ (an_item: POINTER; a_point: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item columnAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_row_at_point_ (an_item: POINTER; a_point: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item rowAtPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_frame_of_cell_at_column__row_ (an_item: POINTER; result_pointer: POINTER; a_column: INTEGER_64; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTableView *)$an_item frameOfCellAtColumn:$a_column row:$a_row];
			 ]"
		end

	objc_prepared_cell_at_column__row_ (an_item: POINTER; a_column: INTEGER_64; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item preparedCellAtColumn:$a_column row:$a_row];
			 ]"
		end

	objc_text_should_begin_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item textShouldBeginEditing:$a_text_object];
			 ]"
		end

	objc_text_should_end_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item textShouldEndEditing:$a_text_object];
			 ]"
		end

	objc_text_did_begin_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item textDidBeginEditing:$a_notification];
			 ]"
		end

	objc_text_did_end_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item textDidEndEditing:$a_notification];
			 ]"
		end

	objc_text_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item textDidChange:$a_notification];
			 ]"
		end

	objc_set_autosave_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAutosaveName:$a_name];
			 ]"
		end

	objc_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTableView *)$an_item autosaveName];
			 ]"
		end

	objc_set_autosave_table_columns_ (an_item: POINTER; a_save: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setAutosaveTableColumns:$a_save];
			 ]"
		end

	objc_autosave_table_columns (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item autosaveTableColumns];
			 ]"
		end

	objc_should_focus_cell__at_column__row_ (an_item: POINTER; a_cell: POINTER; a_column: INTEGER_64; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item shouldFocusCell:$a_cell atColumn:$a_column row:$a_row];
			 ]"
		end

	objc_focused_column (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTableView *)$an_item focusedColumn];
			 ]"
		end

	objc_set_focused_column_ (an_item: POINTER; a_focused_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item setFocusedColumn:$a_focused_column];
			 ]"
		end

	objc_perform_click_on_cell_at_column__row_ (an_item: POINTER; a_column: INTEGER_64; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item performClickOnCellAtColumn:$a_column row:$a_row];
			 ]"
		end

	objc_edit_column__row__with_event__select_ (an_item: POINTER; a_column: INTEGER_64; a_row: INTEGER_64; a_the_event: POINTER; a_select: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item editColumn:$a_column row:$a_row withEvent:$a_the_event select:$a_select];
			 ]"
		end

	objc_draw_row__clip_rect_ (an_item: POINTER; a_row: INTEGER_64; a_clip_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item drawRow:$a_row clipRect:*((NSRect *)$a_clip_rect)];
			 ]"
		end

	objc_highlight_selection_in_clip_rect_ (an_item: POINTER; a_clip_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item highlightSelectionInClipRect:*((NSRect *)$a_clip_rect)];
			 ]"
		end

	objc_draw_grid_in_clip_rect_ (an_item: POINTER; a_clip_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item drawGridInClipRect:*((NSRect *)$a_clip_rect)];
			 ]"
		end

	objc_draw_background_in_clip_rect_ (an_item: POINTER; a_clip_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTableView *)$an_item drawBackgroundInClipRect:*((NSRect *)$a_clip_rect)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTableView"
		end

end
