note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_CONTROL_TEXT_EDITING_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	control__text_should_begin_editing_ (a_control: detachable NS_CONTROL; a_field_editor: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_control__text_should_begin_editing_: has_control__text_should_begin_editing_
		local
			a_control__item: POINTER
			a_field_editor__item: POINTER
		do
			if attached a_control as a_control_attached then
				a_control__item := a_control_attached.item
			end
			if attached a_field_editor as a_field_editor_attached then
				a_field_editor__item := a_field_editor_attached.item
			end
			Result := objc_control__text_should_begin_editing_ (item, a_control__item, a_field_editor__item)
		end

	control__text_should_end_editing_ (a_control: detachable NS_CONTROL; a_field_editor: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_control__text_should_end_editing_: has_control__text_should_end_editing_
		local
			a_control__item: POINTER
			a_field_editor__item: POINTER
		do
			if attached a_control as a_control_attached then
				a_control__item := a_control_attached.item
			end
			if attached a_field_editor as a_field_editor_attached then
				a_field_editor__item := a_field_editor_attached.item
			end
			Result := objc_control__text_should_end_editing_ (item, a_control__item, a_field_editor__item)
		end

	control__did_fail_to_format_string__error_description_ (a_control: detachable NS_CONTROL; a_string: detachable NS_STRING; a_error: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_control__did_fail_to_format_string__error_description_: has_control__did_fail_to_format_string__error_description_
		local
			a_control__item: POINTER
			a_string__item: POINTER
			a_error__item: POINTER
		do
			if attached a_control as a_control_attached then
				a_control__item := a_control_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			Result := objc_control__did_fail_to_format_string__error_description_ (item, a_control__item, a_string__item, a_error__item)
		end

	control__did_fail_to_validate_partial_string__error_description_ (a_control: detachable NS_CONTROL; a_string: detachable NS_STRING; a_error: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_control__did_fail_to_validate_partial_string__error_description_: has_control__did_fail_to_validate_partial_string__error_description_
		local
			a_control__item: POINTER
			a_string__item: POINTER
			a_error__item: POINTER
		do
			if attached a_control as a_control_attached then
				a_control__item := a_control_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			objc_control__did_fail_to_validate_partial_string__error_description_ (item, a_control__item, a_string__item, a_error__item)
		end

	control__is_valid_object_ (a_control: detachable NS_CONTROL; a_obj: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_control__is_valid_object_: has_control__is_valid_object_
		local
			a_control__item: POINTER
			a_obj__item: POINTER
		do
			if attached a_control as a_control_attached then
				a_control__item := a_control_attached.item
			end
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			Result := objc_control__is_valid_object_ (item, a_control__item, a_obj__item)
		end

	control__text_view__do_command_by_selector_ (a_control: detachable NS_CONTROL; a_text_view: detachable NS_TEXT_VIEW; a_command_selector: detachable OBJC_SELECTOR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_control__text_view__do_command_by_selector_: has_control__text_view__do_command_by_selector_
		local
			a_control__item: POINTER
			a_text_view__item: POINTER
			a_command_selector__item: POINTER
		do
			if attached a_control as a_control_attached then
				a_control__item := a_control_attached.item
			end
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			if attached a_command_selector as a_command_selector_attached then
				a_command_selector__item := a_command_selector_attached.item
			end
			Result := objc_control__text_view__do_command_by_selector_ (item, a_control__item, a_text_view__item, a_command_selector__item)
		end

--	control__text_view__completions__for_partial_word_range__index_of_selected_item_ (a_control: detachable NS_CONTROL; a_text_view: detachable NS_TEXT_VIEW; a_words: detachable NS_ARRAY; a_char_range: NS_RANGE; a_index: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		require
--			has_control__text_view__completions__for_partial_word_range__index_of_selected_item_: has_control__text_view__completions__for_partial_word_range__index_of_selected_item_
--		local
--			result_pointer: POINTER
--			a_control__item: POINTER
--			a_text_view__item: POINTER
--			a_words__item: POINTER
--			a_index__item: POINTER
--		do
--			if attached a_control as a_control_attached then
--				a_control__item := a_control_attached.item
--			end
--			if attached a_text_view as a_text_view_attached then
--				a_text_view__item := a_text_view_attached.item
--			end
--			if attached a_words as a_words_attached then
--				a_words__item := a_words_attached.item
--			end
--			if attached a_index as a_index_attached then
--				a_index__item := a_index_attached.item
--			end
--			result_pointer := objc_control__text_view__completions__for_partial_word_range__index_of_selected_item_ (item, a_control__item, a_text_view__item, a_words__item, a_char_range.item, a_index__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like control__text_view__completions__for_partial_word_range__index_of_selected_item_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like control__text_view__completions__for_partial_word_range__index_of_selected_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature -- Status Report

	has_control__text_should_begin_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_control__text_should_begin_editing_ (item)
		end

	has_control__text_should_end_editing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_control__text_should_end_editing_ (item)
		end

	has_control__did_fail_to_format_string__error_description_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_control__did_fail_to_format_string__error_description_ (item)
		end

	has_control__did_fail_to_validate_partial_string__error_description_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_control__did_fail_to_validate_partial_string__error_description_ (item)
		end

	has_control__is_valid_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_control__is_valid_object_ (item)
		end

	has_control__text_view__do_command_by_selector_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_control__text_view__do_command_by_selector_ (item)
		end

--	has_control__text_view__completions__for_partial_word_range__index_of_selected_item_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_control__text_view__completions__for_partial_word_range__index_of_selected_item_ (item)
--		end

feature -- Status Report Externals

	objc_has_control__text_should_begin_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(control:textShouldBeginEditing:)];
			 ]"
		end

	objc_has_control__text_should_end_editing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(control:textShouldEndEditing:)];
			 ]"
		end

	objc_has_control__did_fail_to_format_string__error_description_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(control:didFailToFormatString:errorDescription:)];
			 ]"
		end

	objc_has_control__did_fail_to_validate_partial_string__error_description_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(control:didFailToValidatePartialString:errorDescription:)];
			 ]"
		end

	objc_has_control__is_valid_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(control:isValidObject:)];
			 ]"
		end

	objc_has_control__text_view__do_command_by_selector_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(control:textView:doCommandBySelector:)];
			 ]"
		end

--	objc_has_control__text_view__completions__for_partial_word_range__index_of_selected_item_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(control:textView:completions:forPartialWordRange:indexOfSelectedItem:)];
--			 ]"
--		end

feature {NONE} -- Optional Methods Externals

	objc_control__text_should_begin_editing_ (an_item: POINTER; a_control: POINTER; a_field_editor: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSControlTextEditingDelegate>)$an_item control:$a_control textShouldBeginEditing:$a_field_editor];
			 ]"
		end

	objc_control__text_should_end_editing_ (an_item: POINTER; a_control: POINTER; a_field_editor: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSControlTextEditingDelegate>)$an_item control:$a_control textShouldEndEditing:$a_field_editor];
			 ]"
		end

	objc_control__did_fail_to_format_string__error_description_ (an_item: POINTER; a_control: POINTER; a_string: POINTER; a_error: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSControlTextEditingDelegate>)$an_item control:$a_control didFailToFormatString:$a_string errorDescription:$a_error];
			 ]"
		end

	objc_control__did_fail_to_validate_partial_string__error_description_ (an_item: POINTER; a_control: POINTER; a_string: POINTER; a_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSControlTextEditingDelegate>)$an_item control:$a_control didFailToValidatePartialString:$a_string errorDescription:$a_error];
			 ]"
		end

	objc_control__is_valid_object_ (an_item: POINTER; a_control: POINTER; a_obj: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSControlTextEditingDelegate>)$an_item control:$a_control isValidObject:$a_obj];
			 ]"
		end

	objc_control__text_view__do_command_by_selector_ (an_item: POINTER; a_control: POINTER; a_text_view: POINTER; a_command_selector: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSControlTextEditingDelegate>)$an_item control:$a_control textView:$a_text_view doCommandBySelector:$a_command_selector];
			 ]"
		end

--	objc_control__text_view__completions__for_partial_word_range__index_of_selected_item_ (an_item: POINTER; a_control: POINTER; a_text_view: POINTER; a_words: POINTER; a_char_range: POINTER; a_index: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSControlTextEditingDelegate>)$an_item control:$a_control textView:$a_text_view completions:$a_words forPartialWordRange:*((NSRange *)$a_char_range) indexOfSelectedItem:];
--			 ]"
--		end

end
