note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TABLE_VIEW_DELEGATE_PROTOCOL

inherit
	NS_CONTROL_TEXT_EDITING_DELEGATE_PROTOCOL

feature -- Optional Methods

	table_view__will_display_cell__for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_cell: detachable NS_OBJECT; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__will_display_cell__for_table_column__row_: has_table_view__will_display_cell__for_table_column__row_
		local
			a_table_view__item: POINTER
			a_cell__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_table_view__will_display_cell__for_table_column__row_ (item, a_table_view__item, a_cell__item, a_table_column__item, a_row)
		end

	table_view__should_edit_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_edit_table_column__row_: has_table_view__should_edit_table_column__row_
		local
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			Result := objc_table_view__should_edit_table_column__row_ (item, a_table_view__item, a_table_column__item, a_row)
		end

	selection_should_change_in_table_view_ (a_table_view: detachable NS_TABLE_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_selection_should_change_in_table_view_: has_selection_should_change_in_table_view_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_selection_should_change_in_table_view_ (item, a_table_view__item)
		end

	table_view__should_select_row_ (a_table_view: detachable NS_TABLE_VIEW; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_select_row_: has_table_view__should_select_row_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_table_view__should_select_row_ (item, a_table_view__item, a_row)
		end

	table_view__selection_indexes_for_proposed_selection_ (a_table_view: detachable NS_TABLE_VIEW; a_proposed_selection_indexes: detachable NS_INDEX_SET): detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__selection_indexes_for_proposed_selection_: has_table_view__selection_indexes_for_proposed_selection_
		local
			result_pointer: POINTER
			a_table_view__item: POINTER
			a_proposed_selection_indexes__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_proposed_selection_indexes as a_proposed_selection_indexes_attached then
				a_proposed_selection_indexes__item := a_proposed_selection_indexes_attached.item
			end
			result_pointer := objc_table_view__selection_indexes_for_proposed_selection_ (item, a_table_view__item, a_proposed_selection_indexes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_view__selection_indexes_for_proposed_selection_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_view__selection_indexes_for_proposed_selection_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	table_view__should_select_table_column_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_select_table_column_: has_table_view__should_select_table_column_
		local
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			Result := objc_table_view__should_select_table_column_ (item, a_table_view__item, a_table_column__item)
		end

	table_view__mouse_down_in_header_of_table_column_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__mouse_down_in_header_of_table_column_: has_table_view__mouse_down_in_header_of_table_column_
		local
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_table_view__mouse_down_in_header_of_table_column_ (item, a_table_view__item, a_table_column__item)
		end

	table_view__did_click_table_column_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__did_click_table_column_: has_table_view__did_click_table_column_
		local
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_table_view__did_click_table_column_ (item, a_table_view__item, a_table_column__item)
		end

	table_view__did_drag_table_column_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__did_drag_table_column_: has_table_view__did_drag_table_column_
		local
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_table_view__did_drag_table_column_ (item, a_table_view__item, a_table_column__item)
		end

--	table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_ (a_table_view: detachable NS_TABLE_VIEW; a_cell: detachable NS_CELL; a_rect: UNSUPPORTED_TYPE; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64; a_mouse_location: NS_POINT): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		require
--			has_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_: has_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_
--		local
--			result_pointer: POINTER
--			a_table_view__item: POINTER
--			a_cell__item: POINTER
--			a_rect__item: POINTER
--			a_table_column__item: POINTER
--		do
--			if attached a_table_view as a_table_view_attached then
--				a_table_view__item := a_table_view_attached.item
--			end
--			if attached a_cell as a_cell_attached then
--				a_cell__item := a_cell_attached.item
--			end
--			if attached a_rect as a_rect_attached then
--				a_rect__item := a_rect_attached.item
--			end
--			if attached a_table_column as a_table_column_attached then
--				a_table_column__item := a_table_column_attached.item
--			end
--			result_pointer := objc_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_ (item, a_table_view__item, a_cell__item, a_rect__item, a_table_column__item, a_row, a_mouse_location.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	table_view__height_of_row_ (a_table_view: detachable NS_TABLE_VIEW; a_row: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__height_of_row_: has_table_view__height_of_row_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_table_view__height_of_row_ (item, a_table_view__item, a_row)
		end

	table_view__type_select_string_for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__type_select_string_for_table_column__row_: has_table_view__type_select_string_for_table_column__row_
		local
			result_pointer: POINTER
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			result_pointer := objc_table_view__type_select_string_for_table_column__row_ (item, a_table_view__item, a_table_column__item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_view__type_select_string_for_table_column__row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_view__type_select_string_for_table_column__row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	table_view__next_type_select_match_from_row__to_row__for_string_ (a_table_view: detachable NS_TABLE_VIEW; a_start_row: INTEGER_64; a_end_row: INTEGER_64; a_search_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__next_type_select_match_from_row__to_row__for_string_: has_table_view__next_type_select_match_from_row__to_row__for_string_
		local
			a_table_view__item: POINTER
			a_search_string__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			Result := objc_table_view__next_type_select_match_from_row__to_row__for_string_ (item, a_table_view__item, a_start_row, a_end_row, a_search_string__item)
		end

	table_view__should_type_select_for_event__with_current_search_string_ (a_table_view: detachable NS_TABLE_VIEW; a_event: detachable NS_EVENT; a_search_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_type_select_for_event__with_current_search_string_: has_table_view__should_type_select_for_event__with_current_search_string_
		local
			a_table_view__item: POINTER
			a_event__item: POINTER
			a_search_string__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			Result := objc_table_view__should_type_select_for_event__with_current_search_string_ (item, a_table_view__item, a_event__item, a_search_string__item)
		end

	table_view__should_show_cell_expansion_for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_show_cell_expansion_for_table_column__row_: has_table_view__should_show_cell_expansion_for_table_column__row_
		local
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			Result := objc_table_view__should_show_cell_expansion_for_table_column__row_ (item, a_table_view__item, a_table_column__item, a_row)
		end

	table_view__should_track_cell__for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_cell: detachable NS_CELL; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_track_cell__for_table_column__row_: has_table_view__should_track_cell__for_table_column__row_
		local
			a_table_view__item: POINTER
			a_cell__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			Result := objc_table_view__should_track_cell__for_table_column__row_ (item, a_table_view__item, a_cell__item, a_table_column__item, a_row)
		end

	table_view__data_cell_for_table_column__row_ (a_table_view: detachable NS_TABLE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_row: INTEGER_64): detachable NS_CELL
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__data_cell_for_table_column__row_: has_table_view__data_cell_for_table_column__row_
		local
			result_pointer: POINTER
			a_table_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			result_pointer := objc_table_view__data_cell_for_table_column__row_ (item, a_table_view__item, a_table_column__item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like table_view__data_cell_for_table_column__row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like table_view__data_cell_for_table_column__row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	table_view__is_group_row_ (a_table_view: detachable NS_TABLE_VIEW; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__is_group_row_: has_table_view__is_group_row_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_table_view__is_group_row_ (item, a_table_view__item, a_row)
		end

	table_view__size_to_fit_width_of_column_ (a_table_view: detachable NS_TABLE_VIEW; a_column: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__size_to_fit_width_of_column_: has_table_view__size_to_fit_width_of_column_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_table_view__size_to_fit_width_of_column_ (item, a_table_view__item, a_column)
		end

	table_view__should_reorder_column__to_column_ (a_table_view: detachable NS_TABLE_VIEW; a_column_index: INTEGER_64; a_new_column_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_table_view__should_reorder_column__to_column_: has_table_view__should_reorder_column__to_column_
		local
			a_table_view__item: POINTER
		do
			if attached a_table_view as a_table_view_attached then
				a_table_view__item := a_table_view_attached.item
			end
			Result := objc_table_view__should_reorder_column__to_column_ (item, a_table_view__item, a_column_index, a_new_column_index)
		end

	table_view_selection_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view_selection_did_change_: has_table_view_selection_did_change_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_table_view_selection_did_change_ (item, a_notification__item)
		end

	table_view_column_did_move_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view_column_did_move_: has_table_view_column_did_move_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_table_view_column_did_move_ (item, a_notification__item)
		end

	table_view_column_did_resize_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view_column_did_resize_: has_table_view_column_did_resize_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_table_view_column_did_resize_ (item, a_notification__item)
		end

	table_view_selection_is_changing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_table_view_selection_is_changing_: has_table_view_selection_is_changing_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_table_view_selection_is_changing_ (item, a_notification__item)
		end

feature -- Status Report

	has_table_view__will_display_cell__for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__will_display_cell__for_table_column__row_ (item)
		end

	has_table_view__should_edit_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_edit_table_column__row_ (item)
		end

	has_selection_should_change_in_table_view_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_selection_should_change_in_table_view_ (item)
		end

	has_table_view__should_select_row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_select_row_ (item)
		end

	has_table_view__selection_indexes_for_proposed_selection_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__selection_indexes_for_proposed_selection_ (item)
		end

	has_table_view__should_select_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_select_table_column_ (item)
		end

	has_table_view__mouse_down_in_header_of_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__mouse_down_in_header_of_table_column_ (item)
		end

	has_table_view__did_click_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__did_click_table_column_ (item)
		end

	has_table_view__did_drag_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__did_drag_table_column_ (item)
		end

--	has_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_ (item)
--		end

	has_table_view__height_of_row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__height_of_row_ (item)
		end

	has_table_view__type_select_string_for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__type_select_string_for_table_column__row_ (item)
		end

	has_table_view__next_type_select_match_from_row__to_row__for_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__next_type_select_match_from_row__to_row__for_string_ (item)
		end

	has_table_view__should_type_select_for_event__with_current_search_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_type_select_for_event__with_current_search_string_ (item)
		end

	has_table_view__should_show_cell_expansion_for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_show_cell_expansion_for_table_column__row_ (item)
		end

	has_table_view__should_track_cell__for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_track_cell__for_table_column__row_ (item)
		end

	has_table_view__data_cell_for_table_column__row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__data_cell_for_table_column__row_ (item)
		end

	has_table_view__is_group_row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__is_group_row_ (item)
		end

	has_table_view__size_to_fit_width_of_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__size_to_fit_width_of_column_ (item)
		end

	has_table_view__should_reorder_column__to_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view__should_reorder_column__to_column_ (item)
		end

	has_table_view_selection_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view_selection_did_change_ (item)
		end

	has_table_view_column_did_move_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view_column_did_move_ (item)
		end

	has_table_view_column_did_resize_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view_column_did_resize_ (item)
		end

	has_table_view_selection_is_changing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_table_view_selection_is_changing_ (item)
		end

feature -- Status Report Externals

	objc_has_table_view__will_display_cell__for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:willDisplayCell:forTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__should_edit_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldEditTableColumn:row:)];
			 ]"
		end

	objc_has_selection_should_change_in_table_view_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(selectionShouldChangeInTableView:)];
			 ]"
		end

	objc_has_table_view__should_select_row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldSelectRow:)];
			 ]"
		end

	objc_has_table_view__selection_indexes_for_proposed_selection_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:selectionIndexesForProposedSelection:)];
			 ]"
		end

	objc_has_table_view__should_select_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldSelectTableColumn:)];
			 ]"
		end

	objc_has_table_view__mouse_down_in_header_of_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:mouseDownInHeaderOfTableColumn:)];
			 ]"
		end

	objc_has_table_view__did_click_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:didClickTableColumn:)];
			 ]"
		end

	objc_has_table_view__did_drag_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:didDragTableColumn:)];
			 ]"
		end

--	objc_has_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(tableView:toolTipForCell:rect:tableColumn:row:mouseLocation:)];
--			 ]"
--		end

	objc_has_table_view__height_of_row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:heightOfRow:)];
			 ]"
		end

	objc_has_table_view__type_select_string_for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:typeSelectStringForTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__next_type_select_match_from_row__to_row__for_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:nextTypeSelectMatchFromRow:toRow:forString:)];
			 ]"
		end

	objc_has_table_view__should_type_select_for_event__with_current_search_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldTypeSelectForEvent:withCurrentSearchString:)];
			 ]"
		end

	objc_has_table_view__should_show_cell_expansion_for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldShowCellExpansionForTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__should_track_cell__for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldTrackCell:forTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__data_cell_for_table_column__row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:dataCellForTableColumn:row:)];
			 ]"
		end

	objc_has_table_view__is_group_row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:isGroupRow:)];
			 ]"
		end

	objc_has_table_view__size_to_fit_width_of_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:sizeToFitWidthOfColumn:)];
			 ]"
		end

	objc_has_table_view__should_reorder_column__to_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableView:shouldReorderColumn:toColumn:)];
			 ]"
		end

	objc_has_table_view_selection_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableViewSelectionDidChange:)];
			 ]"
		end

	objc_has_table_view_column_did_move_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableViewColumnDidMove:)];
			 ]"
		end

	objc_has_table_view_column_did_resize_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableViewColumnDidResize:)];
			 ]"
		end

	objc_has_table_view_selection_is_changing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(tableViewSelectionIsChanging:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_table_view__will_display_cell__for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_cell: POINTER; a_table_column: POINTER; a_row: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view willDisplayCell:$a_cell forTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__should_edit_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldEditTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_selection_should_change_in_table_view_ (an_item: POINTER; a_table_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item selectionShouldChangeInTableView:$a_table_view];
			 ]"
		end

	objc_table_view__should_select_row_ (an_item: POINTER; a_table_view: POINTER; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldSelectRow:$a_row];
			 ]"
		end

	objc_table_view__selection_indexes_for_proposed_selection_ (an_item: POINTER; a_table_view: POINTER; a_proposed_selection_indexes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view selectionIndexesForProposedSelection:$a_proposed_selection_indexes];
			 ]"
		end

	objc_table_view__should_select_table_column_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldSelectTableColumn:$a_table_column];
			 ]"
		end

	objc_table_view__mouse_down_in_header_of_table_column_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view mouseDownInHeaderOfTableColumn:$a_table_column];
			 ]"
		end

	objc_table_view__did_click_table_column_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view didClickTableColumn:$a_table_column];
			 ]"
		end

	objc_table_view__did_drag_table_column_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view didDragTableColumn:$a_table_column];
			 ]"
		end

--	objc_table_view__tool_tip_for_cell__rect__table_column__row__mouse_location_ (an_item: POINTER; a_table_view: POINTER; a_cell: POINTER; a_rect: UNSUPPORTED_TYPE; a_table_column: POINTER; a_row: INTEGER_64; a_mouse_location: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view toolTipForCell:$a_cell rect: tableColumn:$a_table_column row:$a_row mouseLocation:*((NSPoint *)$a_mouse_location)];
--			 ]"
--		end

	objc_table_view__height_of_row_ (an_item: POINTER; a_table_view: POINTER; a_row: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view heightOfRow:$a_row];
			 ]"
		end

	objc_table_view__type_select_string_for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view typeSelectStringForTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__next_type_select_match_from_row__to_row__for_string_ (an_item: POINTER; a_table_view: POINTER; a_start_row: INTEGER_64; a_end_row: INTEGER_64; a_search_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view nextTypeSelectMatchFromRow:$a_start_row toRow:$a_end_row forString:$a_search_string];
			 ]"
		end

	objc_table_view__should_type_select_for_event__with_current_search_string_ (an_item: POINTER; a_table_view: POINTER; a_event: POINTER; a_search_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldTypeSelectForEvent:$a_event withCurrentSearchString:$a_search_string];
			 ]"
		end

	objc_table_view__should_show_cell_expansion_for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldShowCellExpansionForTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__should_track_cell__for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_cell: POINTER; a_table_column: POINTER; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldTrackCell:$a_cell forTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__data_cell_for_table_column__row_ (an_item: POINTER; a_table_view: POINTER; a_table_column: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTableViewDelegate>)$an_item tableView:$a_table_view dataCellForTableColumn:$a_table_column row:$a_row];
			 ]"
		end

	objc_table_view__is_group_row_ (an_item: POINTER; a_table_view: POINTER; a_row: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view isGroupRow:$a_row];
			 ]"
		end

	objc_table_view__size_to_fit_width_of_column_ (an_item: POINTER; a_table_view: POINTER; a_column: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view sizeToFitWidthOfColumn:$a_column];
			 ]"
		end

	objc_table_view__should_reorder_column__to_column_ (an_item: POINTER; a_table_view: POINTER; a_column_index: INTEGER_64; a_new_column_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTableViewDelegate>)$an_item tableView:$a_table_view shouldReorderColumn:$a_column_index toColumn:$a_new_column_index];
			 ]"
		end

	objc_table_view_selection_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableViewSelectionDidChange:$a_notification];
			 ]"
		end

	objc_table_view_column_did_move_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableViewColumnDidMove:$a_notification];
			 ]"
		end

	objc_table_view_column_did_resize_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableViewColumnDidResize:$a_notification];
			 ]"
		end

	objc_table_view_selection_is_changing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTableViewDelegate>)$an_item tableViewSelectionIsChanging:$a_notification];
			 ]"
		end

end
