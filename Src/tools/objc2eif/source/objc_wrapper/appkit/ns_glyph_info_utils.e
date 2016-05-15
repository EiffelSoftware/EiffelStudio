note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GLYPH_INFO_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSGlyphInfo

	glyph_info_with_glyph_name__for_font__base_string_ (a_glyph_name: detachable NS_STRING; a_font: detachable NS_FONT; a_the_string: detachable NS_STRING): detachable NS_GLYPH_INFO
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_glyph_name__item: POINTER
			a_font__item: POINTER
			a_the_string__item: POINTER
		do
			if attached a_glyph_name as a_glyph_name_attached then
				a_glyph_name__item := a_glyph_name_attached.item
			end
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			if attached a_the_string as a_the_string_attached then
				a_the_string__item := a_the_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_glyph_info_with_glyph_name__for_font__base_string_ (l_objc_class.item, a_glyph_name__item, a_font__item, a_the_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like glyph_info_with_glyph_name__for_font__base_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like glyph_info_with_glyph_name__for_font__base_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	glyph_info_with_glyph__for_font__base_string_ (a_glyph: NATURAL_32; a_font: detachable NS_FONT; a_the_string: detachable NS_STRING): detachable NS_GLYPH_INFO
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_font__item: POINTER
			a_the_string__item: POINTER
		do
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			if attached a_the_string as a_the_string_attached then
				a_the_string__item := a_the_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_glyph_info_with_glyph__for_font__base_string_ (l_objc_class.item, a_glyph, a_font__item, a_the_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like glyph_info_with_glyph__for_font__base_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like glyph_info_with_glyph__for_font__base_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	glyph_info_with_character_identifier__collection__base_string_ (a_cid: NATURAL_64; a_character_collection: NATURAL_64; a_the_string: detachable NS_STRING): detachable NS_GLYPH_INFO
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_the_string__item: POINTER
		do
			if attached a_the_string as a_the_string_attached then
				a_the_string__item := a_the_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_glyph_info_with_character_identifier__collection__base_string_ (l_objc_class.item, a_cid, a_character_collection, a_the_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like glyph_info_with_character_identifier__collection__base_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like glyph_info_with_character_identifier__collection__base_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSGlyphInfo Externals

	objc_glyph_info_with_glyph_name__for_font__base_string_ (a_class_object: POINTER; a_glyph_name: POINTER; a_font: POINTER; a_the_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object glyphInfoWithGlyphName:$a_glyph_name forFont:$a_font baseString:$a_the_string];
			 ]"
		end

	objc_glyph_info_with_glyph__for_font__base_string_ (a_class_object: POINTER; a_glyph: NATURAL_32; a_font: POINTER; a_the_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object glyphInfoWithGlyph:$a_glyph forFont:$a_font baseString:$a_the_string];
			 ]"
		end

	objc_glyph_info_with_character_identifier__collection__base_string_ (a_class_object: POINTER; a_cid: NATURAL_64; a_character_collection: NATURAL_64; a_the_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object glyphInfoWithCharacterIdentifier:$a_cid collection:$a_character_collection baseString:$a_the_string];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGlyphInfo"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
