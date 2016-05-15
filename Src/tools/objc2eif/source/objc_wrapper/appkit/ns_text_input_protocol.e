note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_INPUT_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	insert_text_ (a_string: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_insert_text_ (item, a_string__item)
		end

	do_command_by_selector_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_do_command_by_selector_ (item, a_selector__item)
		end

	set_marked_text__selected_range_ (a_string: detachable NS_OBJECT; a_sel_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_marked_text__selected_range_ (item, a_string__item, a_sel_range.item)
		end

	unmark_text
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unmark_text (item)
		end

	has_marked_text: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_marked_text (item)
		end

	conversation_identifier: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_conversation_identifier (item)
		end

	attributed_substring_from_range_ (a_the_range: NS_RANGE): detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_substring_from_range_ (item, a_the_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_substring_from_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_substring_from_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	marked_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_marked_range (item, Result.item)
		end

	selected_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_selected_range (item, Result.item)
		end

	first_rect_for_character_range_ (a_the_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_first_rect_for_character_range_ (item, Result.item, a_the_range.item)
		end

	character_index_for_point_ (a_the_point: NS_POINT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_index_for_point_ (item, a_the_point.item)
		end

	valid_attributes_for_marked_text: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_valid_attributes_for_marked_text (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like valid_attributes_for_marked_text} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like valid_attributes_for_marked_text} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

	objc_insert_text_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInput>)$an_item insertText:$a_string];
			 ]"
		end

	objc_do_command_by_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInput>)$an_item doCommandBySelector:$a_selector];
			 ]"
		end

	objc_set_marked_text__selected_range_ (an_item: POINTER; a_string: POINTER; a_sel_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInput>)$an_item setMarkedText:$a_string selectedRange:*((NSRange *)$a_sel_range)];
			 ]"
		end

	objc_unmark_text (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInput>)$an_item unmarkText];
			 ]"
		end

	objc_has_marked_text (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInput>)$an_item hasMarkedText];
			 ]"
		end

	objc_conversation_identifier (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInput>)$an_item conversationIdentifier];
			 ]"
		end

	objc_attributed_substring_from_range_ (an_item: POINTER; a_the_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextInput>)$an_item attributedSubstringFromRange:*((NSRange *)$a_the_range)];
			 ]"
		end

	objc_marked_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(id <NSTextInput>)$an_item markedRange];
			 ]"
		end

	objc_selected_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(id <NSTextInput>)$an_item selectedRange];
			 ]"
		end

	objc_first_rect_for_character_range_ (an_item: POINTER; result_pointer: POINTER; a_the_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSTextInput>)$an_item firstRectForCharacterRange:*((NSRange *)$a_the_range)];
			 ]"
		end

	objc_character_index_for_point_ (an_item: POINTER; a_the_point: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInput>)$an_item characterIndexForPoint:*((NSPoint *)$a_the_point)];
			 ]"
		end

	objc_valid_attributes_for_marked_text (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextInput>)$an_item validAttributesForMarkedText];
			 ]"
		end

end
