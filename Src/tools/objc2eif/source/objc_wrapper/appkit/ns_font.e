note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSFont

	font_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	point_size: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_point_size (item)
		end

--	matrix: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_matrix (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like matrix} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like matrix} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	family_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_family_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like family_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like family_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	display_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_display_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor: detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_descriptor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_transform: detachable NS_AFFINE_TRANSFORM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_transform (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_transform} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_transform} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_of_glyphs: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_glyphs (item)
		end

	most_compatible_string_encoding: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_most_compatible_string_encoding (item)
		end

	glyph_with_name_ (a_name: detachable NS_STRING): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			Result := objc_glyph_with_name_ (item, a_name__item)
		end

	covered_character_set: detachable NS_CHARACTER_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_covered_character_set (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like covered_character_set} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like covered_character_set} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bounding_rect_for_font: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_bounding_rect_for_font (item, Result.item)
		end

	maximum_advancement: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_maximum_advancement (item, Result.item)
		end

	ascender: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_ascender (item)
		end

	descender: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_descender (item)
		end

	leading: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_leading (item)
		end

	underline_position: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_underline_position (item)
		end

	underline_thickness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_underline_thickness (item)
		end

	italic_angle: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_italic_angle (item)
		end

	cap_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_cap_height (item)
		end

	x_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_x_height (item)
		end

	is_fixed_pitch: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_fixed_pitch (item)
		end

	bounding_rect_for_glyph_ (a_glyph: NATURAL_32): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_bounding_rect_for_glyph_ (item, Result.item, a_glyph)
		end

	advancement_for_glyph_ (a_ag: NATURAL_32): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_advancement_for_glyph_ (item, Result.item, a_ag)
		end

--	get_bounding_rects__for_glyphs__count_ (a_bounds: UNSUPPORTED_TYPE; a_glyphs: UNSUPPORTED_TYPE; a_glyph_count: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_bounds__item: POINTER
--			a_glyphs__item: POINTER
--		do
--			if attached a_bounds as a_bounds_attached then
--				a_bounds__item := a_bounds_attached.item
--			end
--			if attached a_glyphs as a_glyphs_attached then
--				a_glyphs__item := a_glyphs_attached.item
--			end
--			objc_get_bounding_rects__for_glyphs__count_ (item, a_bounds__item, a_glyphs__item, a_glyph_count)
--		end

--	get_advancements__for_glyphs__count_ (a_advancements: UNSUPPORTED_TYPE; a_glyphs: UNSUPPORTED_TYPE; a_glyph_count: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_advancements__item: POINTER
--			a_glyphs__item: POINTER
--		do
--			if attached a_advancements as a_advancements_attached then
--				a_advancements__item := a_advancements_attached.item
--			end
--			if attached a_glyphs as a_glyphs_attached then
--				a_glyphs__item := a_glyphs_attached.item
--			end
--			objc_get_advancements__for_glyphs__count_ (item, a_advancements__item, a_glyphs__item, a_glyph_count)
--		end

--	get_advancements__for_packed_glyphs__length_ (a_advancements: UNSUPPORTED_TYPE; a_packed_glyphs: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_advancements__item: POINTER
--			a_packed_glyphs__item: POINTER
--		do
--			if attached a_advancements as a_advancements_attached then
--				a_advancements__item := a_advancements_attached.item
--			end
--			if attached a_packed_glyphs as a_packed_glyphs_attached then
--				a_packed_glyphs__item := a_packed_glyphs_attached.item
--			end
--			objc_get_advancements__for_packed_glyphs__length_ (item, a_advancements__item, a_packed_glyphs__item, a_length)
--		end

	set
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set (item)
		end

	set_in_context_ (a_graphics_context: detachable NS_GRAPHICS_CONTEXT)
			-- Auto generated Objective-C wrapper.
		local
			a_graphics_context__item: POINTER
		do
			if attached a_graphics_context as a_graphics_context_attached then
				a_graphics_context__item := a_graphics_context_attached.item
			end
			objc_set_in_context_ (item, a_graphics_context__item)
		end

	printer_font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_printer_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like printer_font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like printer_font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	screen_font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_screen_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like screen_font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like screen_font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	screen_font_with_rendering_mode_ (a_rendering_mode: NATURAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_screen_font_with_rendering_mode_ (item, a_rendering_mode)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like screen_font_with_rendering_mode_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like screen_font_with_rendering_mode_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rendering_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_rendering_mode (item)
		end

feature {NONE} -- NSFont Externals

	objc_font_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item fontName];
			 ]"
		end

	objc_point_size (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item pointSize];
			 ]"
		end

--	objc_matrix (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSFont *)$an_item matrix];
--			 ]"
--		end

	objc_family_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item familyName];
			 ]"
		end

	objc_display_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item displayName];
			 ]"
		end

	objc_font_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item fontDescriptor];
			 ]"
		end

	objc_text_transform (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item textTransform];
			 ]"
		end

	objc_number_of_glyphs (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item numberOfGlyphs];
			 ]"
		end

	objc_most_compatible_string_encoding (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item mostCompatibleStringEncoding];
			 ]"
		end

	objc_glyph_with_name_ (an_item: POINTER; a_name: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item glyphWithName:$a_name];
			 ]"
		end

	objc_covered_character_set (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item coveredCharacterSet];
			 ]"
		end

	objc_bounding_rect_for_font (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSFont *)$an_item boundingRectForFont];
			 ]"
		end

	objc_maximum_advancement (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSFont *)$an_item maximumAdvancement];
			 ]"
		end

	objc_ascender (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item ascender];
			 ]"
		end

	objc_descender (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item descender];
			 ]"
		end

	objc_leading (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item leading];
			 ]"
		end

	objc_underline_position (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item underlinePosition];
			 ]"
		end

	objc_underline_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item underlineThickness];
			 ]"
		end

	objc_italic_angle (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item italicAngle];
			 ]"
		end

	objc_cap_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item capHeight];
			 ]"
		end

	objc_x_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item xHeight];
			 ]"
		end

	objc_is_fixed_pitch (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item isFixedPitch];
			 ]"
		end

	objc_bounding_rect_for_glyph_ (an_item: POINTER; result_pointer: POINTER; a_glyph: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSFont *)$an_item boundingRectForGlyph:$a_glyph];
			 ]"
		end

	objc_advancement_for_glyph_ (an_item: POINTER; result_pointer: POINTER; a_ag: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSFont *)$an_item advancementForGlyph:$a_ag];
			 ]"
		end

--	objc_get_bounding_rects__for_glyphs__count_ (an_item: POINTER; a_bounds: UNSUPPORTED_TYPE; a_glyphs: UNSUPPORTED_TYPE; a_glyph_count: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSFont *)$an_item getBoundingRects: forGlyphs: count:$a_glyph_count];
--			 ]"
--		end

--	objc_get_advancements__for_glyphs__count_ (an_item: POINTER; a_advancements: UNSUPPORTED_TYPE; a_glyphs: UNSUPPORTED_TYPE; a_glyph_count: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSFont *)$an_item getAdvancements: forGlyphs: count:$a_glyph_count];
--			 ]"
--		end

--	objc_get_advancements__for_packed_glyphs__length_ (an_item: POINTER; a_advancements: UNSUPPORTED_TYPE; a_packed_glyphs: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSFont *)$an_item getAdvancements: forPackedGlyphs: length:$a_length];
--			 ]"
--		end

	objc_set (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFont *)$an_item set];
			 ]"
		end

	objc_set_in_context_ (an_item: POINTER; a_graphics_context: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFont *)$an_item setInContext:$a_graphics_context];
			 ]"
		end

	objc_printer_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item printerFont];
			 ]"
		end

	objc_screen_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item screenFont];
			 ]"
		end

	objc_screen_font_with_rendering_mode_ (an_item: POINTER; a_rendering_mode: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFont *)$an_item screenFontWithRenderingMode:$a_rendering_mode];
			 ]"
		end

	objc_rendering_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFont *)$an_item renderingMode];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFont"
		end

end
