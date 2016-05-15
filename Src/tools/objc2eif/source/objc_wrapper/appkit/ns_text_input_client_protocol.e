note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_INPUT_CLIENT_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	insert_text__replacement_range_ (a_string: detachable NS_OBJECT; a_replacement_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_insert_text__replacement_range_ (item, a_string__item, a_replacement_range.item)
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

	set_marked_text__selected_range__replacement_range_ (a_string: detachable NS_OBJECT; a_selected_range: NS_RANGE; a_replacement_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_marked_text__selected_range__replacement_range_ (item, a_string__item, a_selected_range.item, a_replacement_range.item)
		end

	unmark_text
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unmark_text (item)
		end

	selected_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_selected_range (item, Result.item)
		end

	marked_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_marked_range (item, Result.item)
		end

	has_marked_text: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_marked_text (item)
		end

--	attributed_substring_for_proposed_range__actual_range_ (a_range: NS_RANGE; a_actual_range: UNSUPPORTED_TYPE): detachable NS_ATTRIBUTED_STRING
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_actual_range__item: POINTER
--		do
--			if attached a_actual_range as a_actual_range_attached then
--				a_actual_range__item := a_actual_range_attached.item
--			end
--			result_pointer := objc_attributed_substring_for_proposed_range__actual_range_ (item, a_range.item, a_actual_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attributed_substring_for_proposed_range__actual_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attributed_substring_for_proposed_range__actual_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

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

--	first_rect_for_character_range__actual_range_ (a_range: NS_RANGE; a_actual_range: UNSUPPORTED_TYPE): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_range__item: POINTER
--		do
--			if attached a_actual_range as a_actual_range_attached then
--				a_actual_range__item := a_actual_range_attached.item
--			end
--			create Result.make
--			objc_first_rect_for_character_range__actual_range_ (item, Result.item, a_range.item, a_actual_range__item)
--		end

	character_index_for_point_ (a_point: NS_POINT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_index_for_point_ (item, a_point.item)
		end

feature {NONE} -- Required Methods Externals

	objc_insert_text__replacement_range_ (an_item: POINTER; a_string: POINTER; a_replacement_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInputClient>)$an_item insertText:$a_string replacementRange:*((NSRange *)$a_replacement_range)];
			 ]"
		end

	objc_do_command_by_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInputClient>)$an_item doCommandBySelector:$a_selector];
			 ]"
		end

	objc_set_marked_text__selected_range__replacement_range_ (an_item: POINTER; a_string: POINTER; a_selected_range: POINTER; a_replacement_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInputClient>)$an_item setMarkedText:$a_string selectedRange:*((NSRange *)$a_selected_range) replacementRange:*((NSRange *)$a_replacement_range)];
			 ]"
		end

	objc_unmark_text (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSTextInputClient>)$an_item unmarkText];
			 ]"
		end

	objc_selected_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(id <NSTextInputClient>)$an_item selectedRange];
			 ]"
		end

	objc_marked_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(id <NSTextInputClient>)$an_item markedRange];
			 ]"
		end

	objc_has_marked_text (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInputClient>)$an_item hasMarkedText];
			 ]"
		end

--	objc_attributed_substring_for_proposed_range__actual_range_ (an_item: POINTER; a_range: POINTER; a_actual_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSTextInputClient>)$an_item attributedSubstringForProposedRange:*((NSRange *)$a_range) actualRange:];
--			 ]"
--		end

	objc_valid_attributes_for_marked_text (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextInputClient>)$an_item validAttributesForMarkedText];
			 ]"
		end

--	objc_first_rect_for_character_range__actual_range_ (an_item: POINTER; result_pointer: POINTER; a_range: POINTER; a_actual_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(id <NSTextInputClient>)$an_item firstRectForCharacterRange:*((NSRange *)$a_range) actualRange:];
--			 ]"
--		end

	objc_character_index_for_point_ (an_item: POINTER; a_point: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInputClient>)$an_item characterIndexForPoint:*((NSPoint *)$a_point)];
			 ]"
		end

feature -- Optional Methods

	attributed_string: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_attributed_string: has_attributed_string
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	fraction_of_distance_through_glyph_for_point_ (a_point: NS_POINT): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_fraction_of_distance_through_glyph_for_point_: has_fraction_of_distance_through_glyph_for_point_
		local
		do
			Result := objc_fraction_of_distance_through_glyph_for_point_ (item, a_point.item)
		end

	baseline_delta_for_character_at_index_ (an_index: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_baseline_delta_for_character_at_index_: has_baseline_delta_for_character_at_index_
		local
		do
			Result := objc_baseline_delta_for_character_at_index_ (item, an_index)
		end

	window_level: INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_window_level: has_window_level
		local
		do
			Result := objc_window_level (item)
		end

	draws_vertically_for_character_at_index_ (a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_draws_vertically_for_character_at_index_: has_draws_vertically_for_character_at_index_
		local
		do
			Result := objc_draws_vertically_for_character_at_index_ (item, a_char_index)
		end

feature -- Status Report

	has_attributed_string: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_attributed_string (item)
		end

	has_fraction_of_distance_through_glyph_for_point_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_fraction_of_distance_through_glyph_for_point_ (item)
		end

	has_baseline_delta_for_character_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_baseline_delta_for_character_at_index_ (item)
		end

	has_window_level: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_window_level (item)
		end

	has_draws_vertically_for_character_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_draws_vertically_for_character_at_index_ (item)
		end

feature -- Status Report Externals

	objc_has_attributed_string (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(attributedString)];
			 ]"
		end

	objc_has_fraction_of_distance_through_glyph_for_point_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(fractionOfDistanceThroughGlyphForPoint:)];
			 ]"
		end

	objc_has_baseline_delta_for_character_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(baselineDeltaForCharacterAtIndex:)];
			 ]"
		end

	objc_has_window_level (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(windowLevel)];
			 ]"
		end

	objc_has_draws_vertically_for_character_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(drawsVerticallyForCharacterAtIndex:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSTextInputClient>)$an_item attributedString];
			 ]"
		end

	objc_fraction_of_distance_through_glyph_for_point_ (an_item: POINTER; a_point: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInputClient>)$an_item fractionOfDistanceThroughGlyphForPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_baseline_delta_for_character_at_index_ (an_item: POINTER; a_an_index: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInputClient>)$an_item baselineDeltaForCharacterAtIndex:$a_an_index];
			 ]"
		end

	objc_window_level (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInputClient>)$an_item windowLevel];
			 ]"
		end

	objc_draws_vertically_for_character_at_index_ (an_item: POINTER; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSTextInputClient>)$an_item drawsVerticallyForCharacterAtIndex:$a_char_index];
			 ]"
		end

end
