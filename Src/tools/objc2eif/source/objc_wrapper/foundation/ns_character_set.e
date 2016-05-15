note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CHARACTER_SET

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_MUTABLE_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSCharacterSet

	character_is_member_ (a_character: NATURAL_16): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_is_member_ (item, a_character)
		end

	bitmap_representation: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bitmap_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bitmap_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bitmap_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	inverted_set: detachable NS_CHARACTER_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_inverted_set (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like inverted_set} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like inverted_set} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	long_character_is_member_ (a_the_long_char: NATURAL_32): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_long_character_is_member_ (item, a_the_long_char)
		end

	is_superset_of_set_ (a_the_other_set: detachable NS_CHARACTER_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_other_set__item: POINTER
		do
			if attached a_the_other_set as a_the_other_set_attached then
				a_the_other_set__item := a_the_other_set_attached.item
			end
			Result := objc_is_superset_of_set_ (item, a_the_other_set__item)
		end

	has_member_in_plane_ (a_the_plane: CHARACTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_member_in_plane_ (item, a_the_plane)
		end

feature {NONE} -- NSCharacterSet Externals

	objc_character_is_member_ (an_item: POINTER; a_character: NATURAL_16): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCharacterSet *)$an_item characterIsMember:$a_character];
			 ]"
		end

	objc_bitmap_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCharacterSet *)$an_item bitmapRepresentation];
			 ]"
		end

	objc_inverted_set (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCharacterSet *)$an_item invertedSet];
			 ]"
		end

	objc_long_character_is_member_ (an_item: POINTER; a_the_long_char: NATURAL_32): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCharacterSet *)$an_item longCharacterIsMember:$a_the_long_char];
			 ]"
		end

	objc_is_superset_of_set_ (an_item: POINTER; a_the_other_set: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCharacterSet *)$an_item isSupersetOfSet:$a_the_other_set];
			 ]"
		end

	objc_has_member_in_plane_ (an_item: POINTER; a_the_plane: CHARACTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCharacterSet *)$an_item hasMemberInPlane:$a_the_plane];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCharacterSet"
		end

end
