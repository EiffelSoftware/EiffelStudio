note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_BROWSER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	browser__number_of_rows_in_column_ (a_sender: detachable NS_BROWSER; a_column: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_browser__number_of_rows_in_column_: has_browser__number_of_rows_in_column_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_browser__number_of_rows_in_column_ (item, a_sender__item, a_column)
		end

	browser__create_rows_for_column__in_matrix_ (a_sender: detachable NS_BROWSER; a_column: INTEGER_64; a_matrix: detachable NS_MATRIX)
			-- Auto generated Objective-C wrapper.
		require
			has_browser__create_rows_for_column__in_matrix_: has_browser__create_rows_for_column__in_matrix_
		local
			a_sender__item: POINTER
			a_matrix__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_matrix as a_matrix_attached then
				a_matrix__item := a_matrix_attached.item
			end
			objc_browser__create_rows_for_column__in_matrix_ (item, a_sender__item, a_column, a_matrix__item)
		end

	browser__number_of_children_of_item_ (a_browser: detachable NS_BROWSER; a_item: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_browser__number_of_children_of_item_: has_browser__number_of_children_of_item_
		local
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_browser__number_of_children_of_item_ (item, a_browser__item, a_item__item)
		end

	browser__child__of_item_ (a_browser: detachable NS_BROWSER; a_index: INTEGER_64; a_item: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_browser__child__of_item_: has_browser__child__of_item_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_browser__child__of_item_ (item, a_browser__item, a_index, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__child__of_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__child__of_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__is_leaf_item_ (a_browser: detachable NS_BROWSER; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__is_leaf_item_: has_browser__is_leaf_item_
		local
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_browser__is_leaf_item_ (item, a_browser__item, a_item__item)
		end

	browser__object_value_for_item_ (a_browser: detachable NS_BROWSER; a_item: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_browser__object_value_for_item_: has_browser__object_value_for_item_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_browser__object_value_for_item_ (item, a_browser__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__object_value_for_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__object_value_for_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__height_of_row__in_column_ (a_browser: detachable NS_BROWSER; a_row: INTEGER_64; a_column_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_browser__height_of_row__in_column_: has_browser__height_of_row__in_column_
		local
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			Result := objc_browser__height_of_row__in_column_ (item, a_browser__item, a_row, a_column_index)
		end

	root_item_for_browser_ (a_browser: detachable NS_BROWSER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_root_item_for_browser_: has_root_item_for_browser_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			result_pointer := objc_root_item_for_browser_ (item, a_browser__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like root_item_for_browser_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like root_item_for_browser_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__set_object_value__for_item_ (a_browser: detachable NS_BROWSER; a_object: detachable NS_OBJECT; a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_browser__set_object_value__for_item_: has_browser__set_object_value__for_item_
		local
			a_browser__item: POINTER
			a_object__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_browser__set_object_value__for_item_ (item, a_browser__item, a_object__item, a_item__item)
		end

	browser__should_edit_item_ (a_browser: detachable NS_BROWSER; a_item: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__should_edit_item_: has_browser__should_edit_item_
		local
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			Result := objc_browser__should_edit_item_ (item, a_browser__item, a_item__item)
		end

	browser__will_display_cell__at_row__column_ (a_sender: detachable NS_BROWSER; a_cell: detachable NS_OBJECT; a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		require
			has_browser__will_display_cell__at_row__column_: has_browser__will_display_cell__at_row__column_
		local
			a_sender__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_browser__will_display_cell__at_row__column_ (item, a_sender__item, a_cell__item, a_row, a_column)
		end

	browser__title_of_column_ (a_sender: detachable NS_BROWSER; a_column: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_browser__title_of_column_: has_browser__title_of_column_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			result_pointer := objc_browser__title_of_column_ (item, a_sender__item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__title_of_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__title_of_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__select_cell_with_string__in_column_ (a_sender: detachable NS_BROWSER; a_title: detachable NS_STRING; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__select_cell_with_string__in_column_: has_browser__select_cell_with_string__in_column_
		local
			a_sender__item: POINTER
			a_title__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			Result := objc_browser__select_cell_with_string__in_column_ (item, a_sender__item, a_title__item, a_column)
		end

	browser__select_row__in_column_ (a_sender: detachable NS_BROWSER; a_row: INTEGER_64; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__select_row__in_column_: has_browser__select_row__in_column_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_browser__select_row__in_column_ (item, a_sender__item, a_row, a_column)
		end

	browser__is_column_valid_ (a_sender: detachable NS_BROWSER; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__is_column_valid_: has_browser__is_column_valid_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_browser__is_column_valid_ (item, a_sender__item, a_column)
		end

	browser_will_scroll_ (a_sender: detachable NS_BROWSER)
			-- Auto generated Objective-C wrapper.
		require
			has_browser_will_scroll_: has_browser_will_scroll_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_browser_will_scroll_ (item, a_sender__item)
		end

	browser_did_scroll_ (a_sender: detachable NS_BROWSER)
			-- Auto generated Objective-C wrapper.
		require
			has_browser_did_scroll_: has_browser_did_scroll_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_browser_did_scroll_ (item, a_sender__item)
		end

	browser__should_size_column__for_user_resize__to_width_ (a_browser: detachable NS_BROWSER; a_column_index: INTEGER_64; a_for_user_resize: BOOLEAN; a_suggested_width: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_browser__should_size_column__for_user_resize__to_width_: has_browser__should_size_column__for_user_resize__to_width_
		local
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			Result := objc_browser__should_size_column__for_user_resize__to_width_ (item, a_browser__item, a_column_index, a_for_user_resize, a_suggested_width)
		end

	browser__size_to_fit_width_of_column_ (a_browser: detachable NS_BROWSER; a_column_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_browser__size_to_fit_width_of_column_: has_browser__size_to_fit_width_of_column_
		local
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			Result := objc_browser__size_to_fit_width_of_column_ (item, a_browser__item, a_column_index)
		end

	browser_column_configuration_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_browser_column_configuration_did_change_: has_browser_column_configuration_did_change_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_browser_column_configuration_did_change_ (item, a_notification__item)
		end

	browser__should_show_cell_expansion_for_row__column_ (a_browser: detachable NS_BROWSER; a_row: INTEGER_64; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__should_show_cell_expansion_for_row__column_: has_browser__should_show_cell_expansion_for_row__column_
		local
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			Result := objc_browser__should_show_cell_expansion_for_row__column_ (item, a_browser__item, a_row, a_column)
		end

	browser__write_rows_with_indexes__in_column__to_pasteboard_ (a_browser: detachable NS_BROWSER; a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64; a_pasteboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__write_rows_with_indexes__in_column__to_pasteboard_: has_browser__write_rows_with_indexes__in_column__to_pasteboard_
		local
			a_browser__item: POINTER
			a_row_indexes__item: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			Result := objc_browser__write_rows_with_indexes__in_column__to_pasteboard_ (item, a_browser__item, a_row_indexes__item, a_column, a_pasteboard__item)
		end

	browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_ (a_browser: detachable NS_BROWSER; a_drop_destination: detachable NS_URL; a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_: has_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
			a_drop_destination__item: POINTER
			a_row_indexes__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_drop_destination as a_drop_destination_attached then
				a_drop_destination__item := a_drop_destination_attached.item
			end
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			result_pointer := objc_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_ (item, a_browser__item, a_drop_destination__item, a_row_indexes__item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__can_drag_rows_with_indexes__in_column__with_event_ (a_browser: detachable NS_BROWSER; a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64; a_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__can_drag_rows_with_indexes__in_column__with_event_: has_browser__can_drag_rows_with_indexes__in_column__with_event_
		local
			a_browser__item: POINTER
			a_row_indexes__item: POINTER
			a_event__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_browser__can_drag_rows_with_indexes__in_column__with_event_ (item, a_browser__item, a_row_indexes__item, a_column, a_event__item)
		end

--	browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (a_browser: detachable NS_BROWSER; a_row_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64; a_event: detachable NS_EVENT; a_drag_image_offset: UNSUPPORTED_TYPE): detachable NS_IMAGE
--			-- Auto generated Objective-C wrapper.
--		require
--			has_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_: has_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_
--		local
--			result_pointer: POINTER
--			a_browser__item: POINTER
--			a_row_indexes__item: POINTER
--			a_event__item: POINTER
--			a_drag_image_offset__item: POINTER
--		do
--			if attached a_browser as a_browser_attached then
--				a_browser__item := a_browser_attached.item
--			end
--			if attached a_row_indexes as a_row_indexes_attached then
--				a_row_indexes__item := a_row_indexes_attached.item
--			end
--			if attached a_event as a_event_attached then
--				a_event__item := a_event_attached.item
--			end
--			if attached a_drag_image_offset as a_drag_image_offset_attached then
--				a_drag_image_offset__item := a_drag_image_offset_attached.item
--			end
--			result_pointer := objc_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (item, a_browser__item, a_row_indexes__item, a_column, a_event__item, a_drag_image_offset__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	browser__validate_drop__proposed_row__column__drop_operation_ (a_browser: detachable NS_BROWSER; a_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_row: UNSUPPORTED_TYPE; a_column: UNSUPPORTED_TYPE; a_drop_operation: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		require
--			has_browser__validate_drop__proposed_row__column__drop_operation_: has_browser__validate_drop__proposed_row__column__drop_operation_
--		local
--			a_browser__item: POINTER
--			a_info__item: POINTER
--			a_row__item: POINTER
--			a_column__item: POINTER
--			a_drop_operation__item: POINTER
--		do
--			if attached a_browser as a_browser_attached then
--				a_browser__item := a_browser_attached.item
--			end
--			if attached a_info as a_info_attached then
--				a_info__item := a_info_attached.item
--			end
--			if attached a_row as a_row_attached then
--				a_row__item := a_row_attached.item
--			end
--			if attached a_column as a_column_attached then
--				a_column__item := a_column_attached.item
--			end
--			if attached a_drop_operation as a_drop_operation_attached then
--				a_drop_operation__item := a_drop_operation_attached.item
--			end
--			Result := objc_browser__validate_drop__proposed_row__column__drop_operation_ (item, a_browser__item, a_info__item, a_row__item, a_column__item, a_drop_operation__item)
--		end

	browser__accept_drop__at_row__column__drop_operation_ (a_browser: detachable NS_BROWSER; a_info: detachable NS_DRAGGING_INFO_PROTOCOL; a_row: INTEGER_64; a_column: INTEGER_64; a_drop_operation: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__accept_drop__at_row__column__drop_operation_: has_browser__accept_drop__at_row__column__drop_operation_
		local
			a_browser__item: POINTER
			a_info__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			Result := objc_browser__accept_drop__at_row__column__drop_operation_ (item, a_browser__item, a_info__item, a_row, a_column, a_drop_operation)
		end

	browser__type_select_string_for_row__in_column_ (a_browser: detachable NS_BROWSER; a_row: INTEGER_64; a_column: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_browser__type_select_string_for_row__in_column_: has_browser__type_select_string_for_row__in_column_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			result_pointer := objc_browser__type_select_string_for_row__in_column_ (item, a_browser__item, a_row, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__type_select_string_for_row__in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__type_select_string_for_row__in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__should_type_select_for_event__with_current_search_string_ (a_browser: detachable NS_BROWSER; a_event: detachable NS_EVENT; a_search_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_browser__should_type_select_for_event__with_current_search_string_: has_browser__should_type_select_for_event__with_current_search_string_
		local
			a_browser__item: POINTER
			a_event__item: POINTER
			a_search_string__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			Result := objc_browser__should_type_select_for_event__with_current_search_string_ (item, a_browser__item, a_event__item, a_search_string__item)
		end

	browser__next_type_select_match_from_row__to_row__in_column__for_string_ (a_browser: detachable NS_BROWSER; a_start_row: INTEGER_64; a_end_row: INTEGER_64; a_column: INTEGER_64; a_search_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_browser__next_type_select_match_from_row__to_row__in_column__for_string_: has_browser__next_type_select_match_from_row__to_row__in_column__for_string_
		local
			a_browser__item: POINTER
			a_search_string__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			Result := objc_browser__next_type_select_match_from_row__to_row__in_column__for_string_ (item, a_browser__item, a_start_row, a_end_row, a_column, a_search_string__item)
		end

	browser__preview_view_controller_for_leaf_item_ (a_browser: detachable NS_BROWSER; a_item: detachable NS_OBJECT): detachable NS_VIEW_CONTROLLER
			-- Auto generated Objective-C wrapper.
		require
			has_browser__preview_view_controller_for_leaf_item_: has_browser__preview_view_controller_for_leaf_item_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_browser__preview_view_controller_for_leaf_item_ (item, a_browser__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__preview_view_controller_for_leaf_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__preview_view_controller_for_leaf_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__header_view_controller_for_item_ (a_browser: detachable NS_BROWSER; a_item: detachable NS_OBJECT): detachable NS_VIEW_CONTROLLER
			-- Auto generated Objective-C wrapper.
		require
			has_browser__header_view_controller_for_item_: has_browser__header_view_controller_for_item_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
			a_item__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_browser__header_view_controller_for_item_ (item, a_browser__item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__header_view_controller_for_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__header_view_controller_for_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	browser__did_change_last_column__to_column_ (a_browser: detachable NS_BROWSER; a_old_last_column: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		require
			has_browser__did_change_last_column__to_column_: has_browser__did_change_last_column__to_column_
		local
			a_browser__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			objc_browser__did_change_last_column__to_column_ (item, a_browser__item, a_old_last_column, a_column)
		end

	browser__selection_indexes_for_proposed_selection__in_column_ (a_browser: detachable NS_BROWSER; a_proposed_selection_indexes: detachable NS_INDEX_SET; a_column: INTEGER_64): detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		require
			has_browser__selection_indexes_for_proposed_selection__in_column_: has_browser__selection_indexes_for_proposed_selection__in_column_
		local
			result_pointer: POINTER
			a_browser__item: POINTER
			a_proposed_selection_indexes__item: POINTER
		do
			if attached a_browser as a_browser_attached then
				a_browser__item := a_browser_attached.item
			end
			if attached a_proposed_selection_indexes as a_proposed_selection_indexes_attached then
				a_proposed_selection_indexes__item := a_proposed_selection_indexes_attached.item
			end
			result_pointer := objc_browser__selection_indexes_for_proposed_selection__in_column_ (item, a_browser__item, a_proposed_selection_indexes__item, a_column)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like browser__selection_indexes_for_proposed_selection__in_column_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like browser__selection_indexes_for_proposed_selection__in_column_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_browser__number_of_rows_in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__number_of_rows_in_column_ (item)
		end

	has_browser__create_rows_for_column__in_matrix_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__create_rows_for_column__in_matrix_ (item)
		end

	has_browser__number_of_children_of_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__number_of_children_of_item_ (item)
		end

	has_browser__child__of_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__child__of_item_ (item)
		end

	has_browser__is_leaf_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__is_leaf_item_ (item)
		end

	has_browser__object_value_for_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__object_value_for_item_ (item)
		end

	has_browser__height_of_row__in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__height_of_row__in_column_ (item)
		end

	has_root_item_for_browser_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_root_item_for_browser_ (item)
		end

	has_browser__set_object_value__for_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__set_object_value__for_item_ (item)
		end

	has_browser__should_edit_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__should_edit_item_ (item)
		end

	has_browser__will_display_cell__at_row__column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__will_display_cell__at_row__column_ (item)
		end

	has_browser__title_of_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__title_of_column_ (item)
		end

	has_browser__select_cell_with_string__in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__select_cell_with_string__in_column_ (item)
		end

	has_browser__select_row__in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__select_row__in_column_ (item)
		end

	has_browser__is_column_valid_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__is_column_valid_ (item)
		end

	has_browser_will_scroll_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser_will_scroll_ (item)
		end

	has_browser_did_scroll_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser_did_scroll_ (item)
		end

	has_browser__should_size_column__for_user_resize__to_width_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__should_size_column__for_user_resize__to_width_ (item)
		end

	has_browser__size_to_fit_width_of_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__size_to_fit_width_of_column_ (item)
		end

	has_browser_column_configuration_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser_column_configuration_did_change_ (item)
		end

	has_browser__should_show_cell_expansion_for_row__column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__should_show_cell_expansion_for_row__column_ (item)
		end

	has_browser__write_rows_with_indexes__in_column__to_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__write_rows_with_indexes__in_column__to_pasteboard_ (item)
		end

	has_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_ (item)
		end

	has_browser__can_drag_rows_with_indexes__in_column__with_event_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__can_drag_rows_with_indexes__in_column__with_event_ (item)
		end

--	has_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (item)
--		end

--	has_browser__validate_drop__proposed_row__column__drop_operation_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_browser__validate_drop__proposed_row__column__drop_operation_ (item)
--		end

	has_browser__accept_drop__at_row__column__drop_operation_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__accept_drop__at_row__column__drop_operation_ (item)
		end

	has_browser__type_select_string_for_row__in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__type_select_string_for_row__in_column_ (item)
		end

	has_browser__should_type_select_for_event__with_current_search_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__should_type_select_for_event__with_current_search_string_ (item)
		end

	has_browser__next_type_select_match_from_row__to_row__in_column__for_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__next_type_select_match_from_row__to_row__in_column__for_string_ (item)
		end

	has_browser__preview_view_controller_for_leaf_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__preview_view_controller_for_leaf_item_ (item)
		end

	has_browser__header_view_controller_for_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__header_view_controller_for_item_ (item)
		end

	has_browser__did_change_last_column__to_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__did_change_last_column__to_column_ (item)
		end

	has_browser__selection_indexes_for_proposed_selection__in_column_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_browser__selection_indexes_for_proposed_selection__in_column_ (item)
		end

feature -- Status Report Externals

	objc_has_browser__number_of_rows_in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:numberOfRowsInColumn:)];
			 ]"
		end

	objc_has_browser__create_rows_for_column__in_matrix_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:createRowsForColumn:inMatrix:)];
			 ]"
		end

	objc_has_browser__number_of_children_of_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:numberOfChildrenOfItem:)];
			 ]"
		end

	objc_has_browser__child__of_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:child:ofItem:)];
			 ]"
		end

	objc_has_browser__is_leaf_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:isLeafItem:)];
			 ]"
		end

	objc_has_browser__object_value_for_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:objectValueForItem:)];
			 ]"
		end

	objc_has_browser__height_of_row__in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:heightOfRow:inColumn:)];
			 ]"
		end

	objc_has_root_item_for_browser_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(rootItemForBrowser:)];
			 ]"
		end

	objc_has_browser__set_object_value__for_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:setObjectValue:forItem:)];
			 ]"
		end

	objc_has_browser__should_edit_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:shouldEditItem:)];
			 ]"
		end

	objc_has_browser__will_display_cell__at_row__column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:willDisplayCell:atRow:column:)];
			 ]"
		end

	objc_has_browser__title_of_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:titleOfColumn:)];
			 ]"
		end

	objc_has_browser__select_cell_with_string__in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:selectCellWithString:inColumn:)];
			 ]"
		end

	objc_has_browser__select_row__in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:selectRow:inColumn:)];
			 ]"
		end

	objc_has_browser__is_column_valid_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:isColumnValid:)];
			 ]"
		end

	objc_has_browser_will_scroll_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browserWillScroll:)];
			 ]"
		end

	objc_has_browser_did_scroll_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browserDidScroll:)];
			 ]"
		end

	objc_has_browser__should_size_column__for_user_resize__to_width_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:shouldSizeColumn:forUserResize:toWidth:)];
			 ]"
		end

	objc_has_browser__size_to_fit_width_of_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:sizeToFitWidthOfColumn:)];
			 ]"
		end

	objc_has_browser_column_configuration_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browserColumnConfigurationDidChange:)];
			 ]"
		end

	objc_has_browser__should_show_cell_expansion_for_row__column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:shouldShowCellExpansionForRow:column:)];
			 ]"
		end

	objc_has_browser__write_rows_with_indexes__in_column__to_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:writeRowsWithIndexes:inColumn:toPasteboard:)];
			 ]"
		end

	objc_has_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:namesOfPromisedFilesDroppedAtDestination:forDraggedRowsWithIndexes:inColumn:)];
			 ]"
		end

	objc_has_browser__can_drag_rows_with_indexes__in_column__with_event_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:canDragRowsWithIndexes:inColumn:withEvent:)];
			 ]"
		end

--	objc_has_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(browser:draggingImageForRowsWithIndexes:inColumn:withEvent:offset:)];
--			 ]"
--		end

--	objc_has_browser__validate_drop__proposed_row__column__drop_operation_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(browser:validateDrop:proposedRow:column:dropOperation:)];
--			 ]"
--		end

	objc_has_browser__accept_drop__at_row__column__drop_operation_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:acceptDrop:atRow:column:dropOperation:)];
			 ]"
		end

	objc_has_browser__type_select_string_for_row__in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:typeSelectStringForRow:inColumn:)];
			 ]"
		end

	objc_has_browser__should_type_select_for_event__with_current_search_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:shouldTypeSelectForEvent:withCurrentSearchString:)];
			 ]"
		end

	objc_has_browser__next_type_select_match_from_row__to_row__in_column__for_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:nextTypeSelectMatchFromRow:toRow:inColumn:forString:)];
			 ]"
		end

	objc_has_browser__preview_view_controller_for_leaf_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:previewViewControllerForLeafItem:)];
			 ]"
		end

	objc_has_browser__header_view_controller_for_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:headerViewControllerForItem:)];
			 ]"
		end

	objc_has_browser__did_change_last_column__to_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:didChangeLastColumn:toColumn:)];
			 ]"
		end

	objc_has_browser__selection_indexes_for_proposed_selection__in_column_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(browser:selectionIndexesForProposedSelection:inColumn:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_browser__number_of_rows_in_column_ (an_item: POINTER; a_sender: POINTER; a_column: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_sender numberOfRowsInColumn:$a_column];
			 ]"
		end

	objc_browser__create_rows_for_column__in_matrix_ (an_item: POINTER; a_sender: POINTER; a_column: INTEGER_64; a_matrix: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browser:$a_sender createRowsForColumn:$a_column inMatrix:$a_matrix];
			 ]"
		end

	objc_browser__number_of_children_of_item_ (an_item: POINTER; a_browser: POINTER; a_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser numberOfChildrenOfItem:$a_item];
			 ]"
		end

	objc_browser__child__of_item_ (an_item: POINTER; a_browser: POINTER; a_index: INTEGER_64; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser child:$a_index ofItem:$a_item];
			 ]"
		end

	objc_browser__is_leaf_item_ (an_item: POINTER; a_browser: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser isLeafItem:$a_item];
			 ]"
		end

	objc_browser__object_value_for_item_ (an_item: POINTER; a_browser: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser objectValueForItem:$a_item];
			 ]"
		end

	objc_browser__height_of_row__in_column_ (an_item: POINTER; a_browser: POINTER; a_row: INTEGER_64; a_column_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser heightOfRow:$a_row inColumn:$a_column_index];
			 ]"
		end

	objc_root_item_for_browser_ (an_item: POINTER; a_browser: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item rootItemForBrowser:$a_browser];
			 ]"
		end

	objc_browser__set_object_value__for_item_ (an_item: POINTER; a_browser: POINTER; a_object: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browser:$a_browser setObjectValue:$a_object forItem:$a_item];
			 ]"
		end

	objc_browser__should_edit_item_ (an_item: POINTER; a_browser: POINTER; a_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser shouldEditItem:$a_item];
			 ]"
		end

	objc_browser__will_display_cell__at_row__column_ (an_item: POINTER; a_sender: POINTER; a_cell: POINTER; a_row: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browser:$a_sender willDisplayCell:$a_cell atRow:$a_row column:$a_column];
			 ]"
		end

	objc_browser__title_of_column_ (an_item: POINTER; a_sender: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_sender titleOfColumn:$a_column];
			 ]"
		end

	objc_browser__select_cell_with_string__in_column_ (an_item: POINTER; a_sender: POINTER; a_title: POINTER; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_sender selectCellWithString:$a_title inColumn:$a_column];
			 ]"
		end

	objc_browser__select_row__in_column_ (an_item: POINTER; a_sender: POINTER; a_row: INTEGER_64; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_sender selectRow:$a_row inColumn:$a_column];
			 ]"
		end

	objc_browser__is_column_valid_ (an_item: POINTER; a_sender: POINTER; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_sender isColumnValid:$a_column];
			 ]"
		end

	objc_browser_will_scroll_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browserWillScroll:$a_sender];
			 ]"
		end

	objc_browser_did_scroll_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browserDidScroll:$a_sender];
			 ]"
		end

	objc_browser__should_size_column__for_user_resize__to_width_ (an_item: POINTER; a_browser: POINTER; a_column_index: INTEGER_64; a_for_user_resize: BOOLEAN; a_suggested_width: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser shouldSizeColumn:$a_column_index forUserResize:$a_for_user_resize toWidth:$a_suggested_width];
			 ]"
		end

	objc_browser__size_to_fit_width_of_column_ (an_item: POINTER; a_browser: POINTER; a_column_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser sizeToFitWidthOfColumn:$a_column_index];
			 ]"
		end

	objc_browser_column_configuration_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browserColumnConfigurationDidChange:$a_notification];
			 ]"
		end

	objc_browser__should_show_cell_expansion_for_row__column_ (an_item: POINTER; a_browser: POINTER; a_row: INTEGER_64; a_column: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser shouldShowCellExpansionForRow:$a_row column:$a_column];
			 ]"
		end

	objc_browser__write_rows_with_indexes__in_column__to_pasteboard_ (an_item: POINTER; a_browser: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64; a_pasteboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser writeRowsWithIndexes:$a_row_indexes inColumn:$a_column toPasteboard:$a_pasteboard];
			 ]"
		end

	objc_browser__names_of_promised_files_dropped_at_destination__for_dragged_rows_with_indexes__in_column_ (an_item: POINTER; a_browser: POINTER; a_drop_destination: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser namesOfPromisedFilesDroppedAtDestination:$a_drop_destination forDraggedRowsWithIndexes:$a_row_indexes inColumn:$a_column];
			 ]"
		end

	objc_browser__can_drag_rows_with_indexes__in_column__with_event_ (an_item: POINTER; a_browser: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64; a_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser canDragRowsWithIndexes:$a_row_indexes inColumn:$a_column withEvent:$a_event];
			 ]"
		end

--	objc_browser__dragging_image_for_rows_with_indexes__in_column__with_event__offset_ (an_item: POINTER; a_browser: POINTER; a_row_indexes: POINTER; a_column: INTEGER_64; a_event: POINTER; a_drag_image_offset: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser draggingImageForRowsWithIndexes:$a_row_indexes inColumn:$a_column withEvent:$a_event offset:];
--			 ]"
--		end

--	objc_browser__validate_drop__proposed_row__column__drop_operation_ (an_item: POINTER; a_browser: POINTER; a_info: POINTER; a_row: UNSUPPORTED_TYPE; a_column: UNSUPPORTED_TYPE; a_drop_operation: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser validateDrop:$a_info proposedRow: column: dropOperation:];
--			 ]"
--		end

	objc_browser__accept_drop__at_row__column__drop_operation_ (an_item: POINTER; a_browser: POINTER; a_info: POINTER; a_row: INTEGER_64; a_column: INTEGER_64; a_drop_operation: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser acceptDrop:$a_info atRow:$a_row column:$a_column dropOperation:$a_drop_operation];
			 ]"
		end

	objc_browser__type_select_string_for_row__in_column_ (an_item: POINTER; a_browser: POINTER; a_row: INTEGER_64; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser typeSelectStringForRow:$a_row inColumn:$a_column];
			 ]"
		end

	objc_browser__should_type_select_for_event__with_current_search_string_ (an_item: POINTER; a_browser: POINTER; a_event: POINTER; a_search_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser shouldTypeSelectForEvent:$a_event withCurrentSearchString:$a_search_string];
			 ]"
		end

	objc_browser__next_type_select_match_from_row__to_row__in_column__for_string_ (an_item: POINTER; a_browser: POINTER; a_start_row: INTEGER_64; a_end_row: INTEGER_64; a_column: INTEGER_64; a_search_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSBrowserDelegate>)$an_item browser:$a_browser nextTypeSelectMatchFromRow:$a_start_row toRow:$a_end_row inColumn:$a_column forString:$a_search_string];
			 ]"
		end

	objc_browser__preview_view_controller_for_leaf_item_ (an_item: POINTER; a_browser: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser previewViewControllerForLeafItem:$a_item];
			 ]"
		end

	objc_browser__header_view_controller_for_item_ (an_item: POINTER; a_browser: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser headerViewControllerForItem:$a_item];
			 ]"
		end

	objc_browser__did_change_last_column__to_column_ (an_item: POINTER; a_browser: POINTER; a_old_last_column: INTEGER_64; a_column: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSBrowserDelegate>)$an_item browser:$a_browser didChangeLastColumn:$a_old_last_column toColumn:$a_column];
			 ]"
		end

	objc_browser__selection_indexes_for_proposed_selection__in_column_ (an_item: POINTER; a_browser: POINTER; a_proposed_selection_indexes: POINTER; a_column: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSBrowserDelegate>)$an_item browser:$a_browser selectionIndexesForProposedSelection:$a_proposed_selection_indexes inColumn:$a_column];
			 ]"
		end

end
