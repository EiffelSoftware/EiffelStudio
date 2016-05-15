note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TYPESETTER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSTypesetter

	uses_font_leading: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_font_leading (item)
		end

	set_uses_font_leading_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_font_leading_ (item, a_flag)
		end

	typesetter_behavior: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_typesetter_behavior (item)
		end

	set_typesetter_behavior_ (a_behavior: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_typesetter_behavior_ (item, a_behavior)
		end

	hyphenation_factor: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hyphenation_factor (item)
		end

	set_hyphenation_factor_ (a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hyphenation_factor_ (item, a_factor)
		end

	line_fragment_padding: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_fragment_padding (item)
		end

	set_line_fragment_padding_ (a_padding: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_fragment_padding_ (item, a_padding)
		end

	substitute_font_for_font_ (a_original_font: detachable NS_FONT): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_original_font__item: POINTER
		do
			if attached a_original_font as a_original_font_attached then
				a_original_font__item := a_original_font_attached.item
			end
			result_pointer := objc_substitute_font_for_font_ (item, a_original_font__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substitute_font_for_font_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substitute_font_for_font_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_tab_for_glyph_location__writing_direction__max_location_ (a_glyph_location: REAL_64; a_direction: INTEGER_64; a_max_location: REAL_64): detachable NS_TEXT_TAB
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_tab_for_glyph_location__writing_direction__max_location_ (item, a_glyph_location, a_direction, a_max_location)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_tab_for_glyph_location__writing_direction__max_location_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_tab_for_glyph_location__writing_direction__max_location_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bidi_processing_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bidi_processing_enabled (item)
		end

	set_bidi_processing_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bidi_processing_enabled_ (item, a_flag)
		end

	set_attributed_string_ (a_attr_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_string__item: POINTER
		do
			if attached a_attr_string as a_attr_string_attached then
				a_attr_string__item := a_attr_string_attached.item
			end
			objc_set_attributed_string_ (item, a_attr_string__item)
		end

	attributed_string: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
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

	set_paragraph_glyph_range__separator_glyph_range_ (a_paragraph_range: NS_RANGE; a_paragraph_separator_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_paragraph_glyph_range__separator_glyph_range_ (item, a_paragraph_range.item, a_paragraph_separator_range.item)
		end

	paragraph_glyph_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_paragraph_glyph_range (item, Result.item)
		end

	paragraph_separator_glyph_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_paragraph_separator_glyph_range (item, Result.item)
		end

	paragraph_character_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_paragraph_character_range (item, Result.item)
		end

	paragraph_separator_character_range: NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_paragraph_separator_character_range (item, Result.item)
		end

--	layout_paragraph_at_point_ (a_line_fragment_origin: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_line_fragment_origin__item: POINTER
--		do
--			if attached a_line_fragment_origin as a_line_fragment_origin_attached then
--				a_line_fragment_origin__item := a_line_fragment_origin_attached.item
--			end
--			Result := objc_layout_paragraph_at_point_ (item, a_line_fragment_origin__item)
--		end

	begin_paragraph
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_begin_paragraph (item)
		end

	end_paragraph
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_paragraph (item)
		end

	begin_line_with_glyph_at_index_ (a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_begin_line_with_glyph_at_index_ (item, a_glyph_index)
		end

	end_line_with_glyph_range_ (a_line_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_line_with_glyph_range_ (item, a_line_glyph_range.item)
		end

	line_spacing_after_glyph_at_index__with_proposed_line_fragment_rect_ (a_glyph_index: NATURAL_64; a_rect: NS_RECT): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_spacing_after_glyph_at_index__with_proposed_line_fragment_rect_ (item, a_glyph_index, a_rect.item)
		end

	paragraph_spacing_before_glyph_at_index__with_proposed_line_fragment_rect_ (a_glyph_index: NATURAL_64; a_rect: NS_RECT): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_paragraph_spacing_before_glyph_at_index__with_proposed_line_fragment_rect_ (item, a_glyph_index, a_rect.item)
		end

	paragraph_spacing_after_glyph_at_index__with_proposed_line_fragment_rect_ (a_glyph_index: NATURAL_64; a_rect: NS_RECT): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_paragraph_spacing_after_glyph_at_index__with_proposed_line_fragment_rect_ (item, a_glyph_index, a_rect.item)
		end

--	get_line_fragment_rect__used_rect__for_paragraph_separator_glyph_range__at_proposed_origin_ (a_line_fragment_rect: UNSUPPORTED_TYPE; a_line_fragment_used_rect: UNSUPPORTED_TYPE; a_paragraph_separator_glyph_range: NS_RANGE; a_line_origin: NS_POINT)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_line_fragment_rect__item: POINTER
--			a_line_fragment_used_rect__item: POINTER
--		do
--			if attached a_line_fragment_rect as a_line_fragment_rect_attached then
--				a_line_fragment_rect__item := a_line_fragment_rect_attached.item
--			end
--			if attached a_line_fragment_used_rect as a_line_fragment_used_rect_attached then
--				a_line_fragment_used_rect__item := a_line_fragment_used_rect_attached.item
--			end
--			objc_get_line_fragment_rect__used_rect__for_paragraph_separator_glyph_range__at_proposed_origin_ (item, a_line_fragment_rect__item, a_line_fragment_used_rect__item, a_paragraph_separator_glyph_range.item, a_line_origin.item)
--		end

	attributes_for_extra_line_fragment: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributes_for_extra_line_fragment (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributes_for_extra_line_fragment} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributes_for_extra_line_fragment} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	action_for_control_character_at_index_ (a_char_index: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_action_for_control_character_at_index_ (item, a_char_index)
		end

	layout_manager: detachable NS_LAYOUT_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_layout_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like layout_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like layout_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_containers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_containers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_containers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_containers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_text_container: detachable NS_TEXT_CONTAINER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_text_container (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_text_container} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_text_container} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_paragraph_style: detachable NS_PARAGRAPH_STYLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_paragraph_style (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_paragraph_style} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_paragraph_style} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_hard_invalidation__for_glyph_range_ (a_flag: BOOLEAN; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hard_invalidation__for_glyph_range_ (item, a_flag, a_glyph_range.item)
		end

--	layout_glyphs_in_layout_manager__starting_at_glyph_index__max_number_of_line_fragments__next_glyph_index_ (a_layout_manager: detachable NS_LAYOUT_MANAGER; a_start_glyph_index: NATURAL_64; a_max_num_lines: NATURAL_64; a_next_glyph: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_layout_manager__item: POINTER
--			a_next_glyph__item: POINTER
--		do
--			if attached a_layout_manager as a_layout_manager_attached then
--				a_layout_manager__item := a_layout_manager_attached.item
--			end
--			if attached a_next_glyph as a_next_glyph_attached then
--				a_next_glyph__item := a_next_glyph_attached.item
--			end
--			objc_layout_glyphs_in_layout_manager__starting_at_glyph_index__max_number_of_line_fragments__next_glyph_index_ (item, a_layout_manager__item, a_start_glyph_index, a_max_num_lines, a_next_glyph__item)
--		end

	layout_characters_in_range__for_layout_manager__maximum_number_of_line_fragments_ (a_character_range: NS_RANGE; a_layout_manager: detachable NS_LAYOUT_MANAGER; a_max_num_lines: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_layout_manager__item: POINTER
		do
			if attached a_layout_manager as a_layout_manager_attached then
				a_layout_manager__item := a_layout_manager_attached.item
			end
			create Result.make
			objc_layout_characters_in_range__for_layout_manager__maximum_number_of_line_fragments_ (item, Result.item, a_character_range.item, a_layout_manager__item, a_max_num_lines)
		end

	baseline_offset_in_layout_manager__glyph_index_ (a_layout_mgr: detachable NS_LAYOUT_MANAGER; a_glyph_index: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_layout_mgr__item: POINTER
		do
			if attached a_layout_mgr as a_layout_mgr_attached then
				a_layout_mgr__item := a_layout_mgr_attached.item
			end
			Result := objc_baseline_offset_in_layout_manager__glyph_index_ (item, a_layout_mgr__item, a_glyph_index)
		end

feature {NONE} -- NSTypesetter Externals

	objc_uses_font_leading (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item usesFontLeading];
			 ]"
		end

	objc_set_uses_font_leading_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setUsesFontLeading:$a_flag];
			 ]"
		end

	objc_typesetter_behavior (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item typesetterBehavior];
			 ]"
		end

	objc_set_typesetter_behavior_ (an_item: POINTER; a_behavior: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setTypesetterBehavior:$a_behavior];
			 ]"
		end

	objc_hyphenation_factor (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item hyphenationFactor];
			 ]"
		end

	objc_set_hyphenation_factor_ (an_item: POINTER; a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setHyphenationFactor:$a_factor];
			 ]"
		end

	objc_line_fragment_padding (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item lineFragmentPadding];
			 ]"
		end

	objc_set_line_fragment_padding_ (an_item: POINTER; a_padding: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setLineFragmentPadding:$a_padding];
			 ]"
		end

	objc_substitute_font_for_font_ (an_item: POINTER; a_original_font: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item substituteFontForFont:$a_original_font];
			 ]"
		end

	objc_text_tab_for_glyph_location__writing_direction__max_location_ (an_item: POINTER; a_glyph_location: REAL_64; a_direction: INTEGER_64; a_max_location: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item textTabForGlyphLocation:$a_glyph_location writingDirection:$a_direction maxLocation:$a_max_location];
			 ]"
		end

	objc_bidi_processing_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item bidiProcessingEnabled];
			 ]"
		end

	objc_set_bidi_processing_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setBidiProcessingEnabled:$a_flag];
			 ]"
		end

	objc_set_attributed_string_ (an_item: POINTER; a_attr_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setAttributedString:$a_attr_string];
			 ]"
		end

	objc_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item attributedString];
			 ]"
		end

	objc_set_paragraph_glyph_range__separator_glyph_range_ (an_item: POINTER; a_paragraph_range: POINTER; a_paragraph_separator_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setParagraphGlyphRange:*((NSRange *)$a_paragraph_range) separatorGlyphRange:*((NSRange *)$a_paragraph_separator_range)];
			 ]"
		end

	objc_paragraph_glyph_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item paragraphGlyphRange];
			 ]"
		end

	objc_paragraph_separator_glyph_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item paragraphSeparatorGlyphRange];
			 ]"
		end

	objc_paragraph_character_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item paragraphCharacterRange];
			 ]"
		end

	objc_paragraph_separator_character_range (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item paragraphSeparatorCharacterRange];
			 ]"
		end

--	objc_layout_paragraph_at_point_ (an_item: POINTER; a_line_fragment_origin: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSTypesetter *)$an_item layoutParagraphAtPoint:];
--			 ]"
--		end

	objc_begin_paragraph (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item beginParagraph];
			 ]"
		end

	objc_end_paragraph (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item endParagraph];
			 ]"
		end

	objc_begin_line_with_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item beginLineWithGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_end_line_with_glyph_range_ (an_item: POINTER; a_line_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item endLineWithGlyphRange:*((NSRange *)$a_line_glyph_range)];
			 ]"
		end

	objc_line_spacing_after_glyph_at_index__with_proposed_line_fragment_rect_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_rect: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item lineSpacingAfterGlyphAtIndex:$a_glyph_index withProposedLineFragmentRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_paragraph_spacing_before_glyph_at_index__with_proposed_line_fragment_rect_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_rect: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item paragraphSpacingBeforeGlyphAtIndex:$a_glyph_index withProposedLineFragmentRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_paragraph_spacing_after_glyph_at_index__with_proposed_line_fragment_rect_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_rect: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item paragraphSpacingAfterGlyphAtIndex:$a_glyph_index withProposedLineFragmentRect:*((NSRect *)$a_rect)];
			 ]"
		end

--	objc_get_line_fragment_rect__used_rect__for_paragraph_separator_glyph_range__at_proposed_origin_ (an_item: POINTER; a_line_fragment_rect: UNSUPPORTED_TYPE; a_line_fragment_used_rect: UNSUPPORTED_TYPE; a_paragraph_separator_glyph_range: POINTER; a_line_origin: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item getLineFragmentRect: usedRect: forParagraphSeparatorGlyphRange:*((NSRange *)$a_paragraph_separator_glyph_range) atProposedOrigin:*((NSPoint *)$a_line_origin)];
--			 ]"
--		end

	objc_attributes_for_extra_line_fragment (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item attributesForExtraLineFragment];
			 ]"
		end

	objc_action_for_control_character_at_index_ (an_item: POINTER; a_char_index: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item actionForControlCharacterAtIndex:$a_char_index];
			 ]"
		end

	objc_layout_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item layoutManager];
			 ]"
		end

	objc_text_containers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item textContainers];
			 ]"
		end

	objc_current_text_container (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item currentTextContainer];
			 ]"
		end

	objc_current_paragraph_style (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTypesetter *)$an_item currentParagraphStyle];
			 ]"
		end

	objc_set_hard_invalidation__for_glyph_range_ (an_item: POINTER; a_flag: BOOLEAN; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setHardInvalidation:$a_flag forGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

--	objc_layout_glyphs_in_layout_manager__starting_at_glyph_index__max_number_of_line_fragments__next_glyph_index_ (an_item: POINTER; a_layout_manager: POINTER; a_start_glyph_index: NATURAL_64; a_max_num_lines: NATURAL_64; a_next_glyph: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item layoutGlyphsInLayoutManager:$a_layout_manager startingAtGlyphIndex:$a_start_glyph_index maxNumberOfLineFragments:$a_max_num_lines nextGlyphIndex:];
--			 ]"
--		end

	objc_layout_characters_in_range__for_layout_manager__maximum_number_of_line_fragments_ (an_item: POINTER; result_pointer: POINTER; a_character_range: POINTER; a_layout_manager: POINTER; a_max_num_lines: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item layoutCharactersInRange:*((NSRange *)$a_character_range) forLayoutManager:$a_layout_manager maximumNumberOfLineFragments:$a_max_num_lines];
			 ]"
		end

	objc_baseline_offset_in_layout_manager__glyph_index_ (an_item: POINTER; a_layout_mgr: POINTER; a_glyph_index: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item baselineOffsetInLayoutManager:$a_layout_mgr glyphIndex:$a_glyph_index];
			 ]"
		end

feature -- NSLayoutPhaseInterface

--	will_set_line_fragment_rect__for_glyph_range__used_rect__baseline_offset_ (a_line_rect: UNSUPPORTED_TYPE; a_glyph_range: NS_RANGE; a_used_rect: UNSUPPORTED_TYPE; a_baseline_offset: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_line_rect__item: POINTER
--			a_used_rect__item: POINTER
--			a_baseline_offset__item: POINTER
--		do
--			if attached a_line_rect as a_line_rect_attached then
--				a_line_rect__item := a_line_rect_attached.item
--			end
--			if attached a_used_rect as a_used_rect_attached then
--				a_used_rect__item := a_used_rect_attached.item
--			end
--			if attached a_baseline_offset as a_baseline_offset_attached then
--				a_baseline_offset__item := a_baseline_offset_attached.item
--			end
--			objc_will_set_line_fragment_rect__for_glyph_range__used_rect__baseline_offset_ (item, a_line_rect__item, a_glyph_range.item, a_used_rect__item, a_baseline_offset__item)
--		end

	should_break_line_by_word_before_character_at_index_ (a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_break_line_by_word_before_character_at_index_ (item, a_char_index)
		end

	should_break_line_by_hyphenating_before_character_at_index_ (a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_break_line_by_hyphenating_before_character_at_index_ (item, a_char_index)
		end

	hyphenation_factor_for_glyph_at_index_ (a_glyph_index: NATURAL_64): REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hyphenation_factor_for_glyph_at_index_ (item, a_glyph_index)
		end

	hyphen_character_for_glyph_at_index_ (a_glyph_index: NATURAL_64): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hyphen_character_for_glyph_at_index_ (item, a_glyph_index)
		end

	bounding_box_for_control_glyph_at_index__for_text_container__proposed_line_fragment__glyph_position__character_index_ (a_glyph_index: NATURAL_64; a_text_container: detachable NS_TEXT_CONTAINER; a_proposed_rect: NS_RECT; a_glyph_position: NS_POINT; a_char_index: NATURAL_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_text_container__item: POINTER
		do
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			create Result.make
			objc_bounding_box_for_control_glyph_at_index__for_text_container__proposed_line_fragment__glyph_position__character_index_ (item, Result.item, a_glyph_index, a_text_container__item, a_proposed_rect.item, a_glyph_position.item, a_char_index)
		end

feature {NONE} -- NSLayoutPhaseInterface Externals

--	objc_will_set_line_fragment_rect__for_glyph_range__used_rect__baseline_offset_ (an_item: POINTER; a_line_rect: UNSUPPORTED_TYPE; a_glyph_range: POINTER; a_used_rect: UNSUPPORTED_TYPE; a_baseline_offset: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item willSetLineFragmentRect: forGlyphRange:*((NSRange *)$a_glyph_range) usedRect: baselineOffset:];
--			 ]"
--		end

	objc_should_break_line_by_word_before_character_at_index_ (an_item: POINTER; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item shouldBreakLineByWordBeforeCharacterAtIndex:$a_char_index];
			 ]"
		end

	objc_should_break_line_by_hyphenating_before_character_at_index_ (an_item: POINTER; a_char_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item shouldBreakLineByHyphenatingBeforeCharacterAtIndex:$a_char_index];
			 ]"
		end

	objc_hyphenation_factor_for_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item hyphenationFactorForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_hyphen_character_for_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTypesetter *)$an_item hyphenCharacterForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_bounding_box_for_control_glyph_at_index__for_text_container__proposed_line_fragment__glyph_position__character_index_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64; a_text_container: POINTER; a_proposed_rect: POINTER; a_glyph_position: POINTER; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSTypesetter *)$an_item boundingBoxForControlGlyphAtIndex:$a_glyph_index forTextContainer:$a_text_container proposedLineFragment:*((NSRect *)$a_proposed_rect) glyphPosition:*((NSPoint *)$a_glyph_position) characterIndex:$a_char_index];
			 ]"
		end

feature -- NSGlyphStorageInterface

--	character_range_for_glyph_range__actual_glyph_range_ (a_glyph_range: NS_RANGE; a_actual_glyph_range: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_glyph_range__item: POINTER
--		do
--			if attached a_actual_glyph_range as a_actual_glyph_range_attached then
--				a_actual_glyph_range__item := a_actual_glyph_range_attached.item
--			end
--			create Result.make
--			objc_character_range_for_glyph_range__actual_glyph_range_ (item, Result.item, a_glyph_range.item, a_actual_glyph_range__item)
--		end

--	glyph_range_for_character_range__actual_character_range_ (a_char_range: NS_RANGE; a_actual_char_range: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_char_range__item: POINTER
--		do
--			if attached a_actual_char_range as a_actual_char_range_attached then
--				a_actual_char_range__item := a_actual_char_range_attached.item
--			end
--			create Result.make
--			objc_glyph_range_for_character_range__actual_character_range_ (item, Result.item, a_char_range.item, a_actual_char_range__item)
--		end

--	get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits__bidi_levels_ (a_glyphs_range: NS_RANGE; a_glyph_buffer: UNSUPPORTED_TYPE; a_char_index_buffer: UNSUPPORTED_TYPE; a_inscribe_buffer: UNSUPPORTED_TYPE; a_elastic_buffer: UNSUPPORTED_TYPE; a_bidi_level_buffer: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyph_buffer__item: POINTER
--			a_char_index_buffer__item: POINTER
--			a_inscribe_buffer__item: POINTER
--			a_elastic_buffer__item: POINTER
--		do
--			if attached a_glyph_buffer as a_glyph_buffer_attached then
--				a_glyph_buffer__item := a_glyph_buffer_attached.item
--			end
--			if attached a_char_index_buffer as a_char_index_buffer_attached then
--				a_char_index_buffer__item := a_char_index_buffer_attached.item
--			end
--			if attached a_inscribe_buffer as a_inscribe_buffer_attached then
--				a_inscribe_buffer__item := a_inscribe_buffer_attached.item
--			end
--			if attached a_elastic_buffer as a_elastic_buffer_attached then
--				a_elastic_buffer__item := a_elastic_buffer_attached.item
--			end
--			Result := objc_get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits__bidi_levels_ (item, a_glyphs_range.item, a_glyph_buffer__item, a_char_index_buffer__item, a_inscribe_buffer__item, a_elastic_buffer__item, )
--		end

--	get_line_fragment_rect__used_rect__remaining_rect__for_starting_glyph_at_index__proposed_rect__line_spacing__paragraph_spacing_before__paragraph_spacing_after_ (a_line_fragment_rect: UNSUPPORTED_TYPE; a_line_fragment_used_rect: UNSUPPORTED_TYPE; a_remaining_rect: UNSUPPORTED_TYPE; a_starting_glyph_index: NATURAL_64; a_proposed_rect: NS_RECT; a_line_spacing: REAL_64; a_paragraph_spacing_before: REAL_64; a_paragraph_spacing_after: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_line_fragment_rect__item: POINTER
--			a_line_fragment_used_rect__item: POINTER
--			a_remaining_rect__item: POINTER
--		do
--			if attached a_line_fragment_rect as a_line_fragment_rect_attached then
--				a_line_fragment_rect__item := a_line_fragment_rect_attached.item
--			end
--			if attached a_line_fragment_used_rect as a_line_fragment_used_rect_attached then
--				a_line_fragment_used_rect__item := a_line_fragment_used_rect_attached.item
--			end
--			if attached a_remaining_rect as a_remaining_rect_attached then
--				a_remaining_rect__item := a_remaining_rect_attached.item
--			end
--			objc_get_line_fragment_rect__used_rect__remaining_rect__for_starting_glyph_at_index__proposed_rect__line_spacing__paragraph_spacing_before__paragraph_spacing_after_ (item, a_line_fragment_rect__item, a_line_fragment_used_rect__item, a_remaining_rect__item, a_starting_glyph_index, a_proposed_rect.item, a_line_spacing, a_paragraph_spacing_before, a_paragraph_spacing_after)
--		end

	set_line_fragment_rect__for_glyph_range__used_rect__baseline_offset_ (a_fragment_rect: NS_RECT; a_glyph_range: NS_RANGE; a_used_rect: NS_RECT; a_baseline_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_fragment_rect__for_glyph_range__used_rect__baseline_offset_ (item, a_fragment_rect.item, a_glyph_range.item, a_used_rect.item, a_baseline_offset)
		end

--	substitute_glyphs_in_range__with_glyphs_ (a_glyph_range: NS_RANGE; a_glyphs: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyphs__item: POINTER
--		do
--			if attached a_glyphs as a_glyphs_attached then
--				a_glyphs__item := a_glyphs_attached.item
--			end
--			objc_substitute_glyphs_in_range__with_glyphs_ (item, a_glyph_range.item, a_glyphs__item)
--		end

	insert_glyph__at_glyph_index__character_index_ (a_glyph: NATURAL_32; a_glyph_index: NATURAL_64; a_character_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_insert_glyph__at_glyph_index__character_index_ (item, a_glyph, a_glyph_index, a_character_index)
		end

	delete_glyphs_in_range_ (a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_delete_glyphs_in_range_ (item, a_glyph_range.item)
		end

	set_not_shown_attribute__for_glyph_range_ (a_flag: BOOLEAN; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_not_shown_attribute__for_glyph_range_ (item, a_flag, a_glyph_range.item)
		end

	set_draws_outside_line_fragment__for_glyph_range_ (a_flag: BOOLEAN; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_outside_line_fragment__for_glyph_range_ (item, a_flag, a_glyph_range.item)
		end

--	set_location__with_advancements__for_start_of_glyph_range_ (a_location: NS_POINT; a_advancements: UNSUPPORTED_TYPE; a_glyph_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_advancements__item: POINTER
--		do
--			if attached a_advancements as a_advancements_attached then
--				a_advancements__item := a_advancements_attached.item
--			end
--			objc_set_location__with_advancements__for_start_of_glyph_range_ (item, a_location.item, a_advancements__item, a_glyph_range.item)
--		end

	set_attachment_size__for_glyph_range_ (a_attachment_size: NS_SIZE; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_attachment_size__for_glyph_range_ (item, a_attachment_size.item, a_glyph_range.item)
		end

--	set_bidi_levels__for_glyph_range_ (a_levels: UNSUPPORTED_TYPE; a_glyph_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_set_bidi_levels__for_glyph_range_ (item, , a_glyph_range.item)
--		end

feature {NONE} -- NSGlyphStorageInterface Externals

--	objc_character_range_for_glyph_range__actual_glyph_range_ (an_item: POINTER; result_pointer: POINTER; a_glyph_range: POINTER; a_actual_glyph_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item characterRangeForGlyphRange:*((NSRange *)$a_glyph_range) actualGlyphRange:];
--			 ]"
--		end

--	objc_glyph_range_for_character_range__actual_character_range_ (an_item: POINTER; result_pointer: POINTER; a_char_range: POINTER; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(NSTypesetter *)$an_item glyphRangeForCharacterRange:*((NSRange *)$a_char_range) actualCharacterRange:];
--			 ]"
--		end

--	objc_get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits__bidi_levels_ (an_item: POINTER; a_glyphs_range: POINTER; a_glyph_buffer: UNSUPPORTED_TYPE; a_char_index_buffer: UNSUPPORTED_TYPE; a_inscribe_buffer: UNSUPPORTED_TYPE; a_elastic_buffer: UNSUPPORTED_TYPE; a_bidi_level_buffer: POINTER): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSTypesetter *)$an_item getGlyphsInRange:*((NSRange *)$a_glyphs_range) glyphs: characterIndexes: glyphInscriptions: elasticBits: bidiLevels:$a_bidi_level_buffer];
--			 ]"
--		end

--	objc_get_line_fragment_rect__used_rect__remaining_rect__for_starting_glyph_at_index__proposed_rect__line_spacing__paragraph_spacing_before__paragraph_spacing_after_ (an_item: POINTER; a_line_fragment_rect: UNSUPPORTED_TYPE; a_line_fragment_used_rect: UNSUPPORTED_TYPE; a_remaining_rect: UNSUPPORTED_TYPE; a_starting_glyph_index: NATURAL_64; a_proposed_rect: POINTER; a_line_spacing: REAL_64; a_paragraph_spacing_before: REAL_64; a_paragraph_spacing_after: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item getLineFragmentRect: usedRect: remainingRect: forStartingGlyphAtIndex:$a_starting_glyph_index proposedRect:*((NSRect *)$a_proposed_rect) lineSpacing:$a_line_spacing paragraphSpacingBefore:$a_paragraph_spacing_before paragraphSpacingAfter:$a_paragraph_spacing_after];
--			 ]"
--		end

	objc_set_line_fragment_rect__for_glyph_range__used_rect__baseline_offset_ (an_item: POINTER; a_fragment_rect: POINTER; a_glyph_range: POINTER; a_used_rect: POINTER; a_baseline_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setLineFragmentRect:*((NSRect *)$a_fragment_rect) forGlyphRange:*((NSRange *)$a_glyph_range) usedRect:*((NSRect *)$a_used_rect) baselineOffset:$a_baseline_offset];
			 ]"
		end

--	objc_substitute_glyphs_in_range__with_glyphs_ (an_item: POINTER; a_glyph_range: POINTER; a_glyphs: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item substituteGlyphsInRange:*((NSRange *)$a_glyph_range) withGlyphs:];
--			 ]"
--		end

	objc_insert_glyph__at_glyph_index__character_index_ (an_item: POINTER; a_glyph: NATURAL_32; a_glyph_index: NATURAL_64; a_character_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item insertGlyph:$a_glyph atGlyphIndex:$a_glyph_index characterIndex:$a_character_index];
			 ]"
		end

	objc_delete_glyphs_in_range_ (an_item: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item deleteGlyphsInRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_set_not_shown_attribute__for_glyph_range_ (an_item: POINTER; a_flag: BOOLEAN; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setNotShownAttribute:$a_flag forGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_set_draws_outside_line_fragment__for_glyph_range_ (an_item: POINTER; a_flag: BOOLEAN; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setDrawsOutsideLineFragment:$a_flag forGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

--	objc_set_location__with_advancements__for_start_of_glyph_range_ (an_item: POINTER; a_location: POINTER; a_advancements: UNSUPPORTED_TYPE; a_glyph_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item setLocation:*((NSPoint *)$a_location) withAdvancements: forStartOfGlyphRange:*((NSRange *)$a_glyph_range)];
--			 ]"
--		end

	objc_set_attachment_size__for_glyph_range_ (an_item: POINTER; a_attachment_size: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTypesetter *)$an_item setAttachmentSize:*((NSSize *)$a_attachment_size) forGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

--	objc_set_bidi_levels__for_glyph_range_ (an_item: POINTER; a_levels: POINTER; a_glyph_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSTypesetter *)$an_item setBidiLevels:$a_levels forGlyphRange:*((NSRange *)$a_glyph_range)];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTypesetter"
		end

end
