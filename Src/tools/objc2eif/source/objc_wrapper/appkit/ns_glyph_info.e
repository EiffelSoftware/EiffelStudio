note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GLYPH_INFO

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

feature -- NSGlyphInfo

	glyph_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_glyph_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like glyph_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like glyph_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	character_identifier: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_identifier (item)
		end

	character_collection: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_collection (item)
		end

feature {NONE} -- NSGlyphInfo Externals

	objc_glyph_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSGlyphInfo *)$an_item glyphName];
			 ]"
		end

	objc_character_identifier (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGlyphInfo *)$an_item characterIdentifier];
			 ]"
		end

	objc_character_collection (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGlyphInfo *)$an_item characterCollection];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGlyphInfo"
		end

end
