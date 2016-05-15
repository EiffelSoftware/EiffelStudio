note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_OUTLINE_VIEW_DELEGATE_PROTOCOL

inherit
	NS_CONTROL_TEXT_EDITING_DELEGATE_PROTOCOL

feature -- Optional Methods

	outline_view__will_display_cell__for_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_cell: detachable NS_OBJECT; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__will_display_cell__for_table_column__item_: has_outline_view__will_display_cell__for_table_column__item_
		local
			a_outline_view__item: POINTER
			a_cell__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_outline_view__will_display_cell__for_table_column__item_ (item, a_outline_view__item, a_cell__item, a_table_column__item, a_item__item)
		end

	outline_view__should_edit_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_edit_table_column__item_: has_outline_view__should_edit_table_column__item_
		local
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_edit_table_column__item_ (item, a_outline_view__item, a_table_column__item, a_item__item)
		end

	selection_should_change_in_outline_view_ (a_outline_view: detachable NS_OUTLINE_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_selection_should_change_in_outline_view_: has_selection_should_change_in_outline_view_
		local
			a_outline_view__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			Result := objc_selection_should_change_in_outline_view_ (item, a_outline_view__item)
		end

	outline_view__should_select_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_select_item_: has_outline_view__should_select_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_select_item_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__selection_indexes_for_proposed_selection_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_proposed_selection_indexes: detachable NS_INDEX_SET): detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__selection_indexes_for_proposed_selection_: has_outline_view__selection_indexes_for_proposed_selection_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_proposed_selection_indexes__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_proposed_selection_indexes as a_proposed_selection_indexes_attached then
				a_proposed_selection_indexes__item := a_proposed_selection_indexes_attached.item
			end
			result_pointer := objc_outline_view__selection_indexes_for_proposed_selection_ (item, a_outline_view__item, a_proposed_selection_indexes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__selection_indexes_for_proposed_selection_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__selection_indexes_for_proposed_selection_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__should_select_table_column_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_select_table_column_: has_outline_view__should_select_table_column_
		local
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			Result := objc_outline_view__should_select_table_column_ (item, a_outline_view__item, a_table_column__item)
		end

	outline_view__mouse_down_in_header_of_table_column_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__mouse_down_in_header_of_table_column_: has_outline_view__mouse_down_in_header_of_table_column_
		local
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_outline_view__mouse_down_in_header_of_table_column_ (item, a_outline_view__item, a_table_column__item)
		end

	outline_view__did_click_table_column_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__did_click_table_column_: has_outline_view__did_click_table_column_
		local
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_outline_view__did_click_table_column_ (item, a_outline_view__item, a_table_column__item)
		end

	outline_view__did_drag_table_column_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__did_drag_table_column_: has_outline_view__did_drag_table_column_
		local
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			objc_outline_view__did_drag_table_column_ (item, a_outline_view__item, a_table_column__item)
		end

--	outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_cell: detachable NS_CELL; a_rect: UNSUPPORTED_TYPE; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT; a_mouse_location: NS_POINT): detachable NS_STRING
--			-- Auto generated Objective-C wrapper.
--		require
--			has_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_: has_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_
--		local
--			result_pointer: POINTER
--			a_outline_view__item: POINTER
--			a_cell__item: POINTER
--			a_rect__item: POINTER
--			a_table_column__item: POINTER
--			a_item__item: POINTER
--		do
--			if attached a_outline_view as a_outline_view_attached then
--				a_outline_view__item := a_outline_view_attached.item
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
--			if attached a_item as a_item_attached then
--				a_item__item := a_item_attached.item
--			end
--			result_pointer := objc_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_ (item, a_outline_view__item, a_cell__item, a_rect__item, a_table_column__item, a_item__item, a_mouse_location.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	outline_view__height_of_row_by_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__height_of_row_by_item_: has_outline_view__height_of_row_by_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__height_of_row_by_item_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__type_select_string_for_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__type_select_string_for_table_column__item_: has_outline_view__type_select_string_for_table_column__item_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_outline_view__type_select_string_for_table_column__item_ (item, a_outline_view__item, a_table_column__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__type_select_string_for_table_column__item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__type_select_string_for_table_column__item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__next_type_select_match_from_item__to_item__for_string_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_start_item: detachable NS_OBJECT; a_end_item: detachable NS_OBJECT; a_search_string: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__next_type_select_match_from_item__to_item__for_string_: has_outline_view__next_type_select_match_from_item__to_item__for_string_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_start_item__item: POINTER
			a_end_item__item: POINTER
			a_search_string__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_start_item as a_start_item_attached then
				a_start_item__item := a_start_item_attached.item
			end
			if attached a_end_item as a_end_item_attached then
				a_end_item__item := a_end_item_attached.item
			end
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			result_pointer := objc_outline_view__next_type_select_match_from_item__to_item__for_string_ (item, a_outline_view__item, a_start_item__item, a_end_item__item, a_search_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__next_type_select_match_from_item__to_item__for_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__next_type_select_match_from_item__to_item__for_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__should_type_select_for_event__with_current_search_string_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_event: detachable NS_EVENT; a_search_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_type_select_for_event__with_current_search_string_: has_outline_view__should_type_select_for_event__with_current_search_string_
		local
			a_outline_view__item: POINTER
			a_event__item: POINTER
			a_search_string__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			Result := objc_outline_view__should_type_select_for_event__with_current_search_string_ (item, a_outline_view__item, a_event__item, a_search_string__item)
		end

	outline_view__should_show_cell_expansion_for_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_show_cell_expansion_for_table_column__item_: has_outline_view__should_show_cell_expansion_for_table_column__item_
		local
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_show_cell_expansion_for_table_column__item_ (item, a_outline_view__item, a_table_column__item, a_item__item)
		end

	outline_view__should_track_cell__for_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_cell: detachable NS_CELL; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_track_cell__for_table_column__item_: has_outline_view__should_track_cell__for_table_column__item_
		local
			a_outline_view__item: POINTER
			a_cell__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_track_cell__for_table_column__item_ (item, a_outline_view__item, a_cell__item, a_table_column__item, a_item__item)
		end

	outline_view__data_cell_for_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT): detachable NS_CELL
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__data_cell_for_table_column__item_: has_outline_view__data_cell_for_table_column__item_
		local
			result_pointer: POINTER
			a_outline_view__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_outline_view__data_cell_for_table_column__item_ (item, a_outline_view__item, a_table_column__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like outline_view__data_cell_for_table_column__item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like outline_view__data_cell_for_table_column__item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	outline_view__is_group_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__is_group_item_: has_outline_view__is_group_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__is_group_item_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__should_expand_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_expand_item_: has_outline_view__should_expand_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_expand_item_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__should_collapse_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_collapse_item_: has_outline_view__should_collapse_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_collapse_item_ (item, a_outline_view__item, a_item__item)
		end

	outline_view__will_display_outline_cell__for_table_column__item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_cell: detachable NS_OBJECT; a_table_column: detachable NS_TABLE_COLUMN; a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__will_display_outline_cell__for_table_column__item_: has_outline_view__will_display_outline_cell__for_table_column__item_
		local
			a_outline_view__item: POINTER
			a_cell__item: POINTER
			a_table_column__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_table_column as a_table_column_attached then
				a_table_column__item := a_table_column_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_outline_view__will_display_outline_cell__for_table_column__item_ (item, a_outline_view__item, a_cell__item, a_table_column__item, a_item__item)
		end

	outline_view__size_to_fit_width_of_column_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_column: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__size_to_fit_width_of_column_: has_outline_view__size_to_fit_width_of_column_
		local
			a_outline_view__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			Result := objc_outline_view__size_to_fit_width_of_column_ (item, a_outline_view__item, a_column)
		end

	outline_view__should_reorder_column__to_column_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_column_index: INTEGER_64; a_new_column_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_reorder_column__to_column_: has_outline_view__should_reorder_column__to_column_
		local
			a_outline_view__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			Result := objc_outline_view__should_reorder_column__to_column_ (item, a_outline_view__item, a_column_index, a_new_column_index)
		end

	outline_view__should_show_outline_cell_for_item_ (a_outline_view: detachable NS_OUTLINE_VIEW; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_outline_view__should_show_outline_cell_for_item_: has_outline_view__should_show_outline_cell_for_item_
		local
			a_outline_view__item: POINTER
			a_item__item: POINTER
		do
			if attached a_outline_view as a_outline_view_attached then
				a_outline_view__item := a_outline_view_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_outline_view__should_show_outline_cell_for_item_ (item, a_outline_view__item, a_item__item)
		end

feature -- Status Report

	has_outline_view__will_display_cell__for_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__will_display_cell__for_table_column__item_ (item)
		end

	has_outline_view__should_edit_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_edit_table_column__item_ (item)
		end

	has_selection_should_change_in_outline_view_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_selection_should_change_in_outline_view_ (item)
		end

	has_outline_view__should_select_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_select_item_ (item)
		end

	has_outline_view__selection_indexes_for_proposed_selection_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__selection_indexes_for_proposed_selection_ (item)
		end

	has_outline_view__should_select_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_select_table_column_ (item)
		end

	has_outline_view__mouse_down_in_header_of_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__mouse_down_in_header_of_table_column_ (item)
		end

	has_outline_view__did_click_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__did_click_table_column_ (item)
		end

	has_outline_view__did_drag_table_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__did_drag_table_column_ (item)
		end

--	has_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_ (item)
--		end

	has_outline_view__height_of_row_by_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__height_of_row_by_item_ (item)
		end

	has_outline_view__type_select_string_for_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__type_select_string_for_table_column__item_ (item)
		end

	has_outline_view__next_type_select_match_from_item__to_item__for_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__next_type_select_match_from_item__to_item__for_string_ (item)
		end

	has_outline_view__should_type_select_for_event__with_current_search_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_type_select_for_event__with_current_search_string_ (item)
		end

	has_outline_view__should_show_cell_expansion_for_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_show_cell_expansion_for_table_column__item_ (item)
		end

	has_outline_view__should_track_cell__for_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_track_cell__for_table_column__item_ (item)
		end

	has_outline_view__data_cell_for_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__data_cell_for_table_column__item_ (item)
		end

	has_outline_view__is_group_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__is_group_item_ (item)
		end

	has_outline_view__should_expand_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_expand_item_ (item)
		end

	has_outline_view__should_collapse_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_collapse_item_ (item)
		end

	has_outline_view__will_display_outline_cell__for_table_column__item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__will_display_outline_cell__for_table_column__item_ (item)
		end

	has_outline_view__size_to_fit_width_of_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__size_to_fit_width_of_column_ (item)
		end

	has_outline_view__should_reorder_column__to_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_reorder_column__to_column_ (item)
		end

	has_outline_view__should_show_outline_cell_for_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_outline_view__should_show_outline_cell_for_item_ (item)
		end

feature -- Status Report Externals

	objc_has_outline_view__will_display_cell__for_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:willDisplayCell:forTableColumn:item:)];
			 ]"
		end

	objc_has_outline_view__should_edit_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldEditTableColumn:item:)];
			 ]"
		end

	objc_has_selection_should_change_in_outline_view_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(selectionShouldChangeInOutlineView:)];
			 ]"
		end

	objc_has_outline_view__should_select_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldSelectItem:)];
			 ]"
		end

	objc_has_outline_view__selection_indexes_for_proposed_selection_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:selectionIndexesForProposedSelection:)];
			 ]"
		end

	objc_has_outline_view__should_select_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldSelectTableColumn:)];
			 ]"
		end

	objc_has_outline_view__mouse_down_in_header_of_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:mouseDownInHeaderOfTableColumn:)];
			 ]"
		end

	objc_has_outline_view__did_click_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:didClickTableColumn:)];
			 ]"
		end

	objc_has_outline_view__did_drag_table_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:didDragTableColumn:)];
			 ]"
		end

--	objc_has_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(outlineView:toolTipForCell:rect:tableColumn:item:mouseLocation:)];
--			 ]"
--		end

	objc_has_outline_view__height_of_row_by_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:heightOfRowByItem:)];
			 ]"
		end

	objc_has_outline_view__type_select_string_for_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:typeSelectStringForTableColumn:item:)];
			 ]"
		end

	objc_has_outline_view__next_type_select_match_from_item__to_item__for_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:nextTypeSelectMatchFromItem:toItem:forString:)];
			 ]"
		end

	objc_has_outline_view__should_type_select_for_event__with_current_search_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldTypeSelectForEvent:withCurrentSearchString:)];
			 ]"
		end

	objc_has_outline_view__should_show_cell_expansion_for_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldShowCellExpansionForTableColumn:item:)];
			 ]"
		end

	objc_has_outline_view__should_track_cell__for_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldTrackCell:forTableColumn:item:)];
			 ]"
		end

	objc_has_outline_view__data_cell_for_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:dataCellForTableColumn:item:)];
			 ]"
		end

	objc_has_outline_view__is_group_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:isGroupItem:)];
			 ]"
		end

	objc_has_outline_view__should_expand_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldExpandItem:)];
			 ]"
		end

	objc_has_outline_view__should_collapse_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldCollapseItem:)];
			 ]"
		end

	objc_has_outline_view__will_display_outline_cell__for_table_column__item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:willDisplayOutlineCell:forTableColumn:item:)];
			 ]"
		end

	objc_has_outline_view__size_to_fit_width_of_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:sizeToFitWidthOfColumn:)];
			 ]"
		end

	objc_has_outline_view__should_reorder_column__to_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldReorderColumn:toColumn:)];
			 ]"
		end

	objc_has_outline_view__should_show_outline_cell_for_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(outlineView:shouldShowOutlineCellForItem:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_outline_view__will_display_cell__for_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_cell: POINTER; a_table_column: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view willDisplayCell:$a_cell forTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_outline_view__should_edit_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldEditTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_selection_should_change_in_outline_view_ (an_item: POINTER; a_outline_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item selectionShouldChangeInOutlineView:$a_outline_view];
			 ]"
		end

	objc_outline_view__should_select_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldSelectItem:$a_item];
			 ]"
		end

	objc_outline_view__selection_indexes_for_proposed_selection_ (an_item: POINTER; a_outline_view: POINTER; a_proposed_selection_indexes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view selectionIndexesForProposedSelection:$a_proposed_selection_indexes];
			 ]"
		end

	objc_outline_view__should_select_table_column_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldSelectTableColumn:$a_table_column];
			 ]"
		end

	objc_outline_view__mouse_down_in_header_of_table_column_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view mouseDownInHeaderOfTableColumn:$a_table_column];
			 ]"
		end

	objc_outline_view__did_click_table_column_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view didClickTableColumn:$a_table_column];
			 ]"
		end

	objc_outline_view__did_drag_table_column_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view didDragTableColumn:$a_table_column];
			 ]"
		end

--	objc_outline_view__tool_tip_for_cell__rect__table_column__item__mouse_location_ (an_item: POINTER; a_outline_view: POINTER; a_cell: POINTER; a_rect: UNSUPPORTED_TYPE; a_table_column: POINTER; a_item: POINTER; a_mouse_location: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view toolTipForCell:$a_cell rect: tableColumn:$a_table_column item:$a_item mouseLocation:*((NSPoint *)$a_mouse_location)];
--			 ]"
--		end

	objc_outline_view__height_of_row_by_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view heightOfRowByItem:$a_item];
			 ]"
		end

	objc_outline_view__type_select_string_for_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view typeSelectStringForTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_outline_view__next_type_select_match_from_item__to_item__for_string_ (an_item: POINTER; a_outline_view: POINTER; a_start_item: POINTER; a_end_item: POINTER; a_search_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view nextTypeSelectMatchFromItem:$a_start_item toItem:$a_end_item forString:$a_search_string];
			 ]"
		end

	objc_outline_view__should_type_select_for_event__with_current_search_string_ (an_item: POINTER; a_outline_view: POINTER; a_event: POINTER; a_search_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldTypeSelectForEvent:$a_event withCurrentSearchString:$a_search_string];
			 ]"
		end

	objc_outline_view__should_show_cell_expansion_for_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldShowCellExpansionForTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_outline_view__should_track_cell__for_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_cell: POINTER; a_table_column: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldTrackCell:$a_cell forTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_outline_view__data_cell_for_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_table_column: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view dataCellForTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_outline_view__is_group_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view isGroupItem:$a_item];
			 ]"
		end

	objc_outline_view__should_expand_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldExpandItem:$a_item];
			 ]"
		end

	objc_outline_view__should_collapse_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldCollapseItem:$a_item];
			 ]"
		end

	objc_outline_view__will_display_outline_cell__for_table_column__item_ (an_item: POINTER; a_outline_view: POINTER; a_cell: POINTER; a_table_column: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view willDisplayOutlineCell:$a_cell forTableColumn:$a_table_column item:$a_item];
			 ]"
		end

	objc_outline_view__size_to_fit_width_of_column_ (an_item: POINTER; a_outline_view: POINTER; a_column: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view sizeToFitWidthOfColumn:$a_column];
			 ]"
		end

	objc_outline_view__should_reorder_column__to_column_ (an_item: POINTER; a_outline_view: POINTER; a_column_index: INTEGER_64; a_new_column_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldReorderColumn:$a_column_index toColumn:$a_new_column_index];
			 ]"
		end

	objc_outline_view__should_show_outline_cell_for_item_ (an_item: POINTER; a_outline_view: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSOutlineViewDelegate>)$an_item outlineView:$a_outline_view shouldShowOutlineCellForItem:$a_item];
			 ]"
		end

end
