note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_GLYPH_STORAGE_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

--	insert_glyphs__length__for_starting_glyph_at_index__character_index_ (a_glyphs: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_glyph_index: NATURAL_64; a_char_index: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyphs__item: POINTER
--		do
--			if attached a_glyphs as a_glyphs_attached then
--				a_glyphs__item := a_glyphs_attached.item
--			end
--			objc_insert_glyphs__length__for_starting_glyph_at_index__character_index_ (item, a_glyphs__item, a_length, a_glyph_index, a_char_index)
--		end

	set_int_attribute__value__for_glyph_at_index_ (a_attribute_tag: INTEGER_64; a_val: INTEGER_64; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_int_attribute__value__for_glyph_at_index_ (item, a_attribute_tag, a_val, a_glyph_index)
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

	layout_options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_layout_options (item)
		end

feature {NONE} -- Required Methods Externals

--	objc_insert_glyphs__length__for_starting_glyph_at_index__character_index_ (an_item: POINTER; a_glyphs: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_glyph_index: NATURAL_64; a_char_index: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(id <NSGlyphStorage>)$an_item insertGlyphs: length:$a_length forStartingGlyphAtIndex:$a_glyph_index characterIndex:$a_char_index];
--			 ]"
--		end

	objc_set_int_attribute__value__for_glyph_at_index_ (an_item: POINTER; a_attribute_tag: INTEGER_64; a_val: INTEGER_64; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSGlyphStorage>)$an_item setIntAttribute:$a_attribute_tag value:$a_val forGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSGlyphStorage>)$an_item attributedString];
			 ]"
		end

	objc_layout_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSGlyphStorage>)$an_item layoutOptions];
			 ]"
		end

end
