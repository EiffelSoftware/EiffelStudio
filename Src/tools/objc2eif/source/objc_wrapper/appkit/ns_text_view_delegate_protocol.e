note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_VIEW_DELEGATE_PROTOCOL

inherit
	NS_TEXT_DELEGATE_PROTOCOL

feature -- Optional Methods

	text_view__clicked_on_link__at_index_ (a_text_view: detachable NS_TEXT_VIEW; a_link: detachable NS_OBJECT; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__clicked_on_link__at_index_: has_text_view__clicked_on_link__at_index_
		local
			a_text_view__item: POINTER
			a_link__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_link as a_link_attached then
				a_link__item := a_link_attached.item
			end
			Result := objc_text_view__clicked_on_link__at_index_ (item, a_text_view__item, a_link__item, a_char_index)
		end

	text_view__clicked_on_cell__in_rect__at_index_ (a_text_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_cell_frame: NS_RECT; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__clicked_on_cell__in_rect__at_index_: has_text_view__clicked_on_cell__in_rect__at_index_
		local
			a_text_view__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_text_view__clicked_on_cell__in_rect__at_index_ (item, a_text_view__item, a_cell__item, a_cell_frame.item, a_char_index)
		end

	text_view__double_clicked_on_cell__in_rect__at_index_ (a_text_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_cell_frame: NS_RECT; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__double_clicked_on_cell__in_rect__at_index_: has_text_view__double_clicked_on_cell__in_rect__at_index_
		local
			a_text_view__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_text_view__double_clicked_on_cell__in_rect__at_index_ (item, a_text_view__item, a_cell__item, a_cell_frame.item, a_char_index)
		end

	text_view__dragged_cell__in_rect__event__at_index_ (a_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_rect: NS_RECT; a_event: detachable NS_EVENT; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__dragged_cell__in_rect__event__at_index_: has_text_view__dragged_cell__in_rect__event__at_index_
		local
			a_view__item: POINTER
			a_cell__item: POINTER
			a_event__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_text_view__dragged_cell__in_rect__event__at_index_ (item, a_view__item, a_cell__item, a_rect.item, a_event__item, a_char_index)
		end

	text_view__writable_pasteboard_types_for_cell__at_index_ (a_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_char_index: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__writable_pasteboard_types_for_cell__at_index_: has_text_view__writable_pasteboard_types_for_cell__at_index_
		local
			result_pointer: POINTER
			a_view__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			result_pointer := objc_text_view__writable_pasteboard_types_for_cell__at_index_ (item, a_view__item, a_cell__item, a_char_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view__writable_pasteboard_types_for_cell__at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view__writable_pasteboard_types_for_cell__at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_view__write_cell__at_index__to_pasteboard__type_ (a_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_char_index: NATURAL_64; a_pboard: detachable NS_PASTEBOARD; a_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__write_cell__at_index__to_pasteboard__type_: has_text_view__write_cell__at_index__to_pasteboard__type_
		local
			a_view__item: POINTER
			a_cell__item: POINTER
			a_pboard__item: POINTER
			a_type__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			Result := objc_text_view__write_cell__at_index__to_pasteboard__type_ (item, a_view__item, a_cell__item, a_char_index, a_pboard__item, a_type__item)
		end

	text_view__will_change_selection_from_character_range__to_character_range_ (a_text_view: detachable NS_TEXT_VIEW; a_old_selected_char_range: NS_RANGE; a_new_selected_char_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__will_change_selection_from_character_range__to_character_range_: has_text_view__will_change_selection_from_character_range__to_character_range_
		local
			a_text_view__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			create Result.make
			objc_text_view__will_change_selection_from_character_range__to_character_range_ (item, Result.item, a_text_view__item, a_old_selected_char_range.item, a_new_selected_char_range.item)
		end

	text_view__will_change_selection_from_character_ranges__to_character_ranges_ (a_text_view: detachable NS_TEXT_VIEW; a_old_selected_char_ranges: detachable NS_ARRAY; a_new_selected_char_ranges: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__will_change_selection_from_character_ranges__to_character_ranges_: has_text_view__will_change_selection_from_character_ranges__to_character_ranges_
		local
			result_pointer: POINTER
			a_text_view__item: POINTER
			a_old_selected_char_ranges__item: POINTER
			a_new_selected_char_ranges__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_old_selected_char_ranges as a_old_selected_char_ranges_attached then
				a_old_selected_char_ranges__item := a_old_selected_char_ranges_attached.item
			end
			if attached a_new_selected_char_ranges as a_new_selected_char_ranges_attached then
				a_new_selected_char_ranges__item := a_new_selected_char_ranges_attached.item
			end
			result_pointer := objc_text_view__will_change_selection_from_character_ranges__to_character_ranges_ (item, a_text_view__item, a_old_selected_char_ranges__item, a_new_selected_char_ranges__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view__will_change_selection_from_character_ranges__to_character_ranges_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view__will_change_selection_from_character_ranges__to_character_ranges_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_view__should_change_text_in_ranges__replacement_strings_ (a_text_view: detachable NS_TEXT_VIEW; a_affected_ranges: detachable NS_ARRAY; a_replacement_strings: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__should_change_text_in_ranges__replacement_strings_: has_text_view__should_change_text_in_ranges__replacement_strings_
		local
			a_text_view__item: POINTER
			a_affected_ranges__item: POINTER
			a_replacement_strings__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_affected_ranges as a_affected_ranges_attached then
				a_affected_ranges__item := a_affected_ranges_attached.item
			end
			if attached a_replacement_strings as a_replacement_strings_attached then
				a_replacement_strings__item := a_replacement_strings_attached.item
			end
			Result := objc_text_view__should_change_text_in_ranges__replacement_strings_ (item, a_text_view__item, a_affected_ranges__item, a_replacement_strings__item)
		end

	text_view__should_change_typing_attributes__to_attributes_ (a_text_view: detachable NS_TEXT_VIEW; a_old_typing_attributes: detachable NS_DICTIONARY; a_new_typing_attributes: detachable NS_DICTIONARY): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__should_change_typing_attributes__to_attributes_: has_text_view__should_change_typing_attributes__to_attributes_
		local
			result_pointer: POINTER
			a_text_view__item: POINTER
			a_old_typing_attributes__item: POINTER
			a_new_typing_attributes__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_old_typing_attributes as a_old_typing_attributes_attached then
				a_old_typing_attributes__item := a_old_typing_attributes_attached.item
			end
			if attached a_new_typing_attributes as a_new_typing_attributes_attached then
				a_new_typing_attributes__item := a_new_typing_attributes_attached.item
			end
			result_pointer := objc_text_view__should_change_typing_attributes__to_attributes_ (item, a_text_view__item, a_old_typing_attributes__item, a_new_typing_attributes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view__should_change_typing_attributes__to_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view__should_change_typing_attributes__to_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_view_did_change_selection_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view_did_change_selection_: has_text_view_did_change_selection_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_view_did_change_selection_ (item, a_notification__item)
		end

	text_view_did_change_typing_attributes_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view_did_change_typing_attributes_: has_text_view_did_change_typing_attributes_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_view_did_change_typing_attributes_ (item, a_notification__item)
		end

	text_view__will_display_tool_tip__for_character_at_index_ (a_text_view: detachable NS_TEXT_VIEW; a_tooltip: detachable NS_STRING; a_character_index: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__will_display_tool_tip__for_character_at_index_: has_text_view__will_display_tool_tip__for_character_at_index_
		local
			result_pointer: POINTER
			a_text_view__item: POINTER
			a_tooltip__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_tooltip as a_tooltip_attached then
				a_tooltip__item := a_tooltip_attached.item
			end
			result_pointer := objc_text_view__will_display_tool_tip__for_character_at_index_ (item, a_text_view__item, a_tooltip__item, a_character_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view__will_display_tool_tip__for_character_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view__will_display_tool_tip__for_character_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	text_view__completions__for_partial_word_range__index_of_selected_item_ (a_text_view: detachable NS_TEXT_VIEW; a_words: detachable NS_ARRAY; a_char_range: NS_RANGE; a_index: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		require
--			has_text_view__completions__for_partial_word_range__index_of_selected_item_: has_text_view__completions__for_partial_word_range__index_of_selected_item_
--		local
--			result_pointer: POINTER
--			a_text_view__item: POINTER
--			a_words__item: POINTER
--			a_index__item: POINTER
--		do
--			if attached a_text_view as a_text_view_attached then
--				a_text_view__item := a_text_view_attached.item
--			end
--			if attached a_words as a_words_attached then
--				a_words__item := a_words_attached.item
--			end
--			if attached a_index as a_index_attached then
--				a_index__item := a_index_attached.item
--			end
--			result_pointer := objc_text_view__completions__for_partial_word_range__index_of_selected_item_ (item, a_text_view__item, a_words__item, a_char_range.item, a_index__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like text_view__completions__for_partial_word_range__index_of_selected_item_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like text_view__completions__for_partial_word_range__index_of_selected_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	text_view__should_change_text_in_range__replacement_string_ (a_text_view: detachable NS_TEXT_VIEW; a_affected_char_range: NS_RANGE; a_replacement_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__should_change_text_in_range__replacement_string_: has_text_view__should_change_text_in_range__replacement_string_
		local
			a_text_view__item: POINTER
			a_replacement_string__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_replacement_string as a_replacement_string_attached then
				a_replacement_string__item := a_replacement_string_attached.item
			end
			Result := objc_text_view__should_change_text_in_range__replacement_string_ (item, a_text_view__item, a_affected_char_range.item, a_replacement_string__item)
		end

	text_view__do_command_by_selector_ (a_text_view: detachable NS_TEXT_VIEW; a_command_selector: detachable OBJC_SELECTOR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__do_command_by_selector_: has_text_view__do_command_by_selector_
		local
			a_text_view__item: POINTER
			a_command_selector__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_command_selector as a_command_selector_attached then
				a_command_selector__item := a_command_selector_attached.item
			end
			Result := objc_text_view__do_command_by_selector_ (item, a_text_view__item, a_command_selector__item)
		end

	text_view__should_set_spelling_state__range_ (a_text_view: detachable NS_TEXT_VIEW; a_value: INTEGER_64; a_affected_char_range: NS_RANGE): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__should_set_spelling_state__range_: has_text_view__should_set_spelling_state__range_
		local
			a_text_view__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			Result := objc_text_view__should_set_spelling_state__range_ (item, a_text_view__item, a_value, a_affected_char_range.item)
		end

	text_view__menu__for_event__at_index_ (a_view: detachable NS_TEXT_VIEW; a_menu: detachable NS_MENU; a_event: detachable NS_EVENT; a_char_index: NATURAL_64): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__menu__for_event__at_index_: has_text_view__menu__for_event__at_index_
		local
			result_pointer: POINTER
			a_view__item: POINTER
			a_menu__item: POINTER
			a_event__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			result_pointer := objc_text_view__menu__for_event__at_index_ (item, a_view__item, a_menu__item, a_event__item, a_char_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view__menu__for_event__at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view__menu__for_event__at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	text_view__will_check_text_in_range__options__types_ (a_view: detachable NS_TEXT_VIEW; a_range: NS_RANGE; a_options: detachable NS_DICTIONARY; a_checking_types: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		require
--			has_text_view__will_check_text_in_range__options__types_: has_text_view__will_check_text_in_range__options__types_
--		local
--			result_pointer: POINTER
--			a_view__item: POINTER
--			a_options__item: POINTER
--			a_checking_types__item: POINTER
--		do
--			if attached a_view as a_view_attached then
--				a_view__item := a_view_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_checking_types as a_checking_types_attached then
--				a_checking_types__item := a_checking_types_attached.item
--			end
--			result_pointer := objc_text_view__will_check_text_in_range__options__types_ (item, a_view__item, a_range.item, a_options__item, a_checking_types__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like text_view__will_check_text_in_range__options__types_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like text_view__will_check_text_in_range__options__types_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	text_view__did_check_text_in_range__types__options__results__orthography__word_count_ (a_view: detachable NS_TEXT_VIEW; a_range: NS_RANGE; a_checking_types: NATURAL_64; a_options: detachable NS_DICTIONARY; a_results: detachable NS_ARRAY; a_orthography: detachable NS_ORTHOGRAPHY; a_word_count: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__did_check_text_in_range__types__options__results__orthography__word_count_: has_text_view__did_check_text_in_range__types__options__results__orthography__word_count_
		local
			result_pointer: POINTER
			a_view__item: POINTER
			a_options__item: POINTER
			a_results__item: POINTER
			a_orthography__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			if attached a_results as a_results_attached then
				a_results__item := a_results_attached.item
			end
			if attached a_orthography as a_orthography_attached then
				a_orthography__item := a_orthography_attached.item
			end
			result_pointer := objc_text_view__did_check_text_in_range__types__options__results__orthography__word_count_ (item, a_view__item, a_range.item, a_checking_types, a_options__item, a_results__item, a_orthography__item, a_word_count)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view__did_check_text_in_range__types__options__results__orthography__word_count_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view__did_check_text_in_range__types__options__results__orthography__word_count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_view__clicked_on_link_ (a_text_view: detachable NS_TEXT_VIEW; a_link: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__clicked_on_link_: has_text_view__clicked_on_link_
		local
			a_text_view__item: POINTER
			a_link__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_link as a_link_attached then
				a_link__item := a_link_attached.item
			end
			Result := objc_text_view__clicked_on_link_ (item, a_text_view__item, a_link__item)
		end

	text_view__clicked_on_cell__in_rect_ (a_text_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_cell_frame: NS_RECT)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__clicked_on_cell__in_rect_: has_text_view__clicked_on_cell__in_rect_
		local
			a_text_view__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_text_view__clicked_on_cell__in_rect_ (item, a_text_view__item, a_cell__item, a_cell_frame.item)
		end

	text_view__double_clicked_on_cell__in_rect_ (a_text_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_cell_frame: NS_RECT)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__double_clicked_on_cell__in_rect_: has_text_view__double_clicked_on_cell__in_rect_
		local
			a_text_view__item: POINTER
			a_cell__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_text_view__double_clicked_on_cell__in_rect_ (item, a_text_view__item, a_cell__item, a_cell_frame.item)
		end

	text_view__dragged_cell__in_rect__event_ (a_view: detachable NS_TEXT_VIEW; a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL; a_rect: NS_RECT; a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		require
			has_text_view__dragged_cell__in_rect__event_: has_text_view__dragged_cell__in_rect__event_
		local
			a_view__item: POINTER
			a_cell__item: POINTER
			a_event__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_text_view__dragged_cell__in_rect__event_ (item, a_view__item, a_cell__item, a_rect.item, a_event__item)
		end

	undo_manager_for_text_view_ (a_view: detachable NS_TEXT_VIEW): detachable NS_UNDO_MANAGER
			-- Auto generated Objective-C wrapper.
		require
			has_undo_manager_for_text_view_: has_undo_manager_for_text_view_
		local
			result_pointer: POINTER
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			result_pointer := objc_undo_manager_for_text_view_ (item, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_manager_for_text_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_manager_for_text_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_text_view__clicked_on_link__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__clicked_on_link__at_index_ (item)
		end

	has_text_view__clicked_on_cell__in_rect__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__clicked_on_cell__in_rect__at_index_ (item)
		end

	has_text_view__double_clicked_on_cell__in_rect__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__double_clicked_on_cell__in_rect__at_index_ (item)
		end

	has_text_view__dragged_cell__in_rect__event__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__dragged_cell__in_rect__event__at_index_ (item)
		end

	has_text_view__writable_pasteboard_types_for_cell__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__writable_pasteboard_types_for_cell__at_index_ (item)
		end

	has_text_view__write_cell__at_index__to_pasteboard__type_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__write_cell__at_index__to_pasteboard__type_ (item)
		end

	has_text_view__will_change_selection_from_character_range__to_character_range_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__will_change_selection_from_character_range__to_character_range_ (item)
		end

	has_text_view__will_change_selection_from_character_ranges__to_character_ranges_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__will_change_selection_from_character_ranges__to_character_ranges_ (item)
		end

	has_text_view__should_change_text_in_ranges__replacement_strings_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__should_change_text_in_ranges__replacement_strings_ (item)
		end

	has_text_view__should_change_typing_attributes__to_attributes_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__should_change_typing_attributes__to_attributes_ (item)
		end

	has_text_view_did_change_selection_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view_did_change_selection_ (item)
		end

	has_text_view_did_change_typing_attributes_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view_did_change_typing_attributes_ (item)
		end

	has_text_view__will_display_tool_tip__for_character_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__will_display_tool_tip__for_character_at_index_ (item)
		end

--	has_text_view__completions__for_partial_word_range__index_of_selected_item_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_text_view__completions__for_partial_word_range__index_of_selected_item_ (item)
--		end

	has_text_view__should_change_text_in_range__replacement_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__should_change_text_in_range__replacement_string_ (item)
		end

	has_text_view__do_command_by_selector_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__do_command_by_selector_ (item)
		end

	has_text_view__should_set_spelling_state__range_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__should_set_spelling_state__range_ (item)
		end

	has_text_view__menu__for_event__at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__menu__for_event__at_index_ (item)
		end

--	has_text_view__will_check_text_in_range__options__types_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_text_view__will_check_text_in_range__options__types_ (item)
--		end

	has_text_view__did_check_text_in_range__types__options__results__orthography__word_count_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__did_check_text_in_range__types__options__results__orthography__word_count_ (item)
		end

	has_text_view__clicked_on_link_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__clicked_on_link_ (item)
		end

	has_text_view__clicked_on_cell__in_rect_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__clicked_on_cell__in_rect_ (item)
		end

	has_text_view__double_clicked_on_cell__in_rect_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__double_clicked_on_cell__in_rect_ (item)
		end

	has_text_view__dragged_cell__in_rect__event_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_text_view__dragged_cell__in_rect__event_ (item)
		end

	has_undo_manager_for_text_view_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_undo_manager_for_text_view_ (item)
		end

feature -- Status Report Externals

	objc_has_text_view__clicked_on_link__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:clickedOnLink:atIndex:)];
			 ]"
		end

	objc_has_text_view__clicked_on_cell__in_rect__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:clickedOnCell:inRect:atIndex:)];
			 ]"
		end

	objc_has_text_view__double_clicked_on_cell__in_rect__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:doubleClickedOnCell:inRect:atIndex:)];
			 ]"
		end

	objc_has_text_view__dragged_cell__in_rect__event__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:draggedCell:inRect:event:atIndex:)];
			 ]"
		end

	objc_has_text_view__writable_pasteboard_types_for_cell__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:writablePasteboardTypesForCell:atIndex:)];
			 ]"
		end

	objc_has_text_view__write_cell__at_index__to_pasteboard__type_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:writeCell:atIndex:toPasteboard:type:)];
			 ]"
		end

	objc_has_text_view__will_change_selection_from_character_range__to_character_range_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:willChangeSelectionFromCharacterRange:toCharacterRange:)];
			 ]"
		end

	objc_has_text_view__will_change_selection_from_character_ranges__to_character_ranges_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:willChangeSelectionFromCharacterRanges:toCharacterRanges:)];
			 ]"
		end

	objc_has_text_view__should_change_text_in_ranges__replacement_strings_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:shouldChangeTextInRanges:replacementStrings:)];
			 ]"
		end

	objc_has_text_view__should_change_typing_attributes__to_attributes_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:shouldChangeTypingAttributes:toAttributes:)];
			 ]"
		end

	objc_has_text_view_did_change_selection_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textViewDidChangeSelection:)];
			 ]"
		end

	objc_has_text_view_did_change_typing_attributes_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textViewDidChangeTypingAttributes:)];
			 ]"
		end

	objc_has_text_view__will_display_tool_tip__for_character_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:willDisplayToolTip:forCharacterAtIndex:)];
			 ]"
		end

--	objc_has_text_view__completions__for_partial_word_range__index_of_selected_item_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(textView:completions:forPartialWordRange:indexOfSelectedItem:)];
--			 ]"
--		end

	objc_has_text_view__should_change_text_in_range__replacement_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementString:)];
			 ]"
		end

	objc_has_text_view__do_command_by_selector_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:doCommandBySelector:)];
			 ]"
		end

	objc_has_text_view__should_set_spelling_state__range_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:shouldSetSpellingState:range:)];
			 ]"
		end

	objc_has_text_view__menu__for_event__at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:menu:forEvent:atIndex:)];
			 ]"
		end

--	objc_has_text_view__will_check_text_in_range__options__types_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(textView:willCheckTextInRange:options:types:)];
--			 ]"
--		end

	objc_has_text_view__did_check_text_in_range__types__options__results__orthography__word_count_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:didCheckTextInRange:types:options:results:orthography:wordCount:)];
			 ]"
		end

	objc_has_text_view__clicked_on_link_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:clickedOnLink:)];
			 ]"
		end

	objc_has_text_view__clicked_on_cell__in_rect_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:clickedOnCell:inRect:)];
			 ]"
		end

	objc_has_text_view__double_clicked_on_cell__in_rect_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:doubleClickedOnCell:inRect:)];
			 ]"
		end

	objc_has_text_view__dragged_cell__in_rect__event_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(textView:draggedCell:inRect:event:)];
			 ]"
		end

	objc_has_undo_manager_for_text_view_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(undoManagerForTextView:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_text_view__clicked_on_link__at_index_ (an_item: POINTER; a_text_view: POINTER; a_link: POINTER; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_text_view clickedOnLink:$a_link atIndex:$a_char_index];
			 ]"
		end

	objc_text_view__clicked_on_cell__in_rect__at_index_ (an_item: POINTER; a_text_view: POINTER; a_cell: POINTER; a_cell_frame: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textView:$a_text_view clickedOnCell:$a_cell inRect:*((NSRect *)$a_cell_frame) atIndex:$a_char_index];
			 ]"
		end

	objc_text_view__double_clicked_on_cell__in_rect__at_index_ (an_item: POINTER; a_text_view: POINTER; a_cell: POINTER; a_cell_frame: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textView:$a_text_view doubleClickedOnCell:$a_cell inRect:*((NSRect *)$a_cell_frame) atIndex:$a_char_index];
			 ]"
		end

	objc_text_view__dragged_cell__in_rect__event__at_index_ (an_item: POINTER; a_view: POINTER; a_cell: POINTER; a_rect: POINTER; a_event: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textView:$a_view draggedCell:$a_cell inRect:*((NSRect *)$a_rect) event:$a_event atIndex:$a_char_index];
			 ]"
		end

	objc_text_view__writable_pasteboard_types_for_cell__at_index_ (an_item: POINTER; a_view: POINTER; a_cell: POINTER; a_char_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_view writablePasteboardTypesForCell:$a_cell atIndex:$a_char_index];
			 ]"
		end

	objc_text_view__write_cell__at_index__to_pasteboard__type_ (an_item: POINTER; a_view: POINTER; a_cell: POINTER; a_char_index: NATURAL_64; a_pboard: POINTER; a_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_view writeCell:$a_cell atIndex:$a_char_index toPasteboard:$a_pboard type:$a_type];
			 ]"
		end

	objc_text_view__will_change_selection_from_character_range__to_character_range_ (an_item: POINTER; result_pointer: POINTER; a_text_view: POINTER; a_old_selected_char_range: POINTER; a_new_selected_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(id <NSTextViewDelegate>)$an_item textView:$a_text_view willChangeSelectionFromCharacterRange:*((NSRange *)$a_old_selected_char_range) toCharacterRange:*((NSRange *)$a_new_selected_char_range)];
			 ]"
		end

	objc_text_view__will_change_selection_from_character_ranges__to_character_ranges_ (an_item: POINTER; a_text_view: POINTER; a_old_selected_char_ranges: POINTER; a_new_selected_char_ranges: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_text_view willChangeSelectionFromCharacterRanges:$a_old_selected_char_ranges toCharacterRanges:$a_new_selected_char_ranges];
			 ]"
		end

	objc_text_view__should_change_text_in_ranges__replacement_strings_ (an_item: POINTER; a_text_view: POINTER; a_affected_ranges: POINTER; a_replacement_strings: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_text_view shouldChangeTextInRanges:$a_affected_ranges replacementStrings:$a_replacement_strings];
			 ]"
		end

	objc_text_view__should_change_typing_attributes__to_attributes_ (an_item: POINTER; a_text_view: POINTER; a_old_typing_attributes: POINTER; a_new_typing_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_text_view shouldChangeTypingAttributes:$a_old_typing_attributes toAttributes:$a_new_typing_attributes];
			 ]"
		end

	objc_text_view_did_change_selection_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textViewDidChangeSelection:$a_notification];
			 ]"
		end

	objc_text_view_did_change_typing_attributes_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textViewDidChangeTypingAttributes:$a_notification];
			 ]"
		end

	objc_text_view__will_display_tool_tip__for_character_at_index_ (an_item: POINTER; a_text_view: POINTER; a_tooltip: POINTER; a_character_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_text_view willDisplayToolTip:$a_tooltip forCharacterAtIndex:$a_character_index];
			 ]"
		end

--	objc_text_view__completions__for_partial_word_range__index_of_selected_item_ (an_item: POINTER; a_text_view: POINTER; a_words: POINTER; a_char_range: POINTER; a_index: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_text_view completions:$a_words forPartialWordRange:*((NSRange *)$a_char_range) indexOfSelectedItem:];
--			 ]"
--		end

	objc_text_view__should_change_text_in_range__replacement_string_ (an_item: POINTER; a_text_view: POINTER; a_affected_char_range: POINTER; a_replacement_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_text_view shouldChangeTextInRange:*((NSRange *)$a_affected_char_range) replacementString:$a_replacement_string];
			 ]"
		end

	objc_text_view__do_command_by_selector_ (an_item: POINTER; a_text_view: POINTER; a_command_selector: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_text_view doCommandBySelector:$a_command_selector];
			 ]"
		end

	objc_text_view__should_set_spelling_state__range_ (an_item: POINTER; a_text_view: POINTER; a_value: INTEGER_64; a_affected_char_range: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_text_view shouldSetSpellingState:$a_value range:*((NSRange *)$a_affected_char_range)];
			 ]"
		end

	objc_text_view__menu__for_event__at_index_ (an_item: POINTER; a_view: POINTER; a_menu: POINTER; a_event: POINTER; a_char_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_view menu:$a_menu forEvent:$a_event atIndex:$a_char_index];
			 ]"
		end

--	objc_text_view__will_check_text_in_range__options__types_ (an_item: POINTER; a_view: POINTER; a_range: POINTER; a_options: POINTER; a_checking_types: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_view willCheckTextInRange:*((NSRange *)$a_range) options:$a_options types:];
--			 ]"
--		end

	objc_text_view__did_check_text_in_range__types__options__results__orthography__word_count_ (an_item: POINTER; a_view: POINTER; a_range: POINTER; a_checking_types: NATURAL_64; a_options: POINTER; a_results: POINTER; a_orthography: POINTER; a_word_count: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item textView:$a_view didCheckTextInRange:*((NSRange *)$a_range) types:$a_checking_types options:$a_options results:$a_results orthography:$a_orthography wordCount:$a_word_count];
			 ]"
		end

	objc_text_view__clicked_on_link_ (an_item: POINTER; a_text_view: POINTER; a_link: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextViewDelegate>)$an_item textView:$a_text_view clickedOnLink:$a_link];
			 ]"
		end

	objc_text_view__clicked_on_cell__in_rect_ (an_item: POINTER; a_text_view: POINTER; a_cell: POINTER; a_cell_frame: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textView:$a_text_view clickedOnCell:$a_cell inRect:*((NSRect *)$a_cell_frame)];
			 ]"
		end

	objc_text_view__double_clicked_on_cell__in_rect_ (an_item: POINTER; a_text_view: POINTER; a_cell: POINTER; a_cell_frame: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textView:$a_text_view doubleClickedOnCell:$a_cell inRect:*((NSRect *)$a_cell_frame)];
			 ]"
		end

	objc_text_view__dragged_cell__in_rect__event_ (an_item: POINTER; a_view: POINTER; a_cell: POINTER; a_rect: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextViewDelegate>)$an_item textView:$a_view draggedCell:$a_cell inRect:*((NSRect *)$a_rect) event:$a_event];
			 ]"
		end

	objc_undo_manager_for_text_view_ (an_item: POINTER; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextViewDelegate>)$an_item undoManagerForTextView:$a_view];
			 ]"
		end

end
