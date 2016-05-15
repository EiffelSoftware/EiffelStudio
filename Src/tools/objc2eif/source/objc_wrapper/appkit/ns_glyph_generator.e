note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GLYPH_GENERATOR

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

feature -- NSGlyphGenerator

--	generate_glyphs_for_glyph_storage__desired_number_of_characters__glyph_index__character_index_ (a_glyph_storage: detachable NS_GLYPH_STORAGE_PROTOCOL; a_n_chars: NATURAL_64; a_glyph_index: UNSUPPORTED_TYPE; a_char_index: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyph_storage__item: POINTER
--			a_glyph_index__item: POINTER
--			a_char_index__item: POINTER
--		do
--			if attached a_glyph_storage as a_glyph_storage_attached then
--				a_glyph_storage__item := a_glyph_storage_attached.item
--			end
--			if attached a_glyph_index as a_glyph_index_attached then
--				a_glyph_index__item := a_glyph_index_attached.item
--			end
--			if attached a_char_index as a_char_index_attached then
--				a_char_index__item := a_char_index_attached.item
--			end
--			objc_generate_glyphs_for_glyph_storage__desired_number_of_characters__glyph_index__character_index_ (item, a_glyph_storage__item, a_n_chars, a_glyph_index__item, a_char_index__item)
--		end

feature {NONE} -- NSGlyphGenerator Externals

--	objc_generate_glyphs_for_glyph_storage__desired_number_of_characters__glyph_index__character_index_ (an_item: POINTER; a_glyph_storage: POINTER; a_n_chars: NATURAL_64; a_glyph_index: UNSUPPORTED_TYPE; a_char_index: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSGlyphGenerator *)$an_item generateGlyphsForGlyphStorage:$a_glyph_storage desiredNumberOfCharacters:$a_n_chars glyphIndex: characterIndex:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGlyphGenerator"
		end

end
