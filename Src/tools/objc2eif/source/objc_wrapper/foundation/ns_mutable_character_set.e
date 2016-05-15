note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_CHARACTER_SET

inherit
	NS_CHARACTER_SET
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_MUTABLE_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSMutableCharacterSet

	add_characters_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_characters_in_range_ (item, a_range.item)
		end

	remove_characters_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_characters_in_range_ (item, a_range.item)
		end

	add_characters_in_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_add_characters_in_string_ (item, a_string__item)
		end

	remove_characters_in_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_remove_characters_in_string_ (item, a_string__item)
		end

	form_union_with_character_set_ (a_other_set: detachable NS_CHARACTER_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			objc_form_union_with_character_set_ (item, a_other_set__item)
		end

	form_intersection_with_character_set_ (a_other_set: detachable NS_CHARACTER_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			objc_form_intersection_with_character_set_ (item, a_other_set__item)
		end

	invert
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invert (item)
		end

feature {NONE} -- NSMutableCharacterSet Externals

	objc_add_characters_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item addCharactersInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_remove_characters_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item removeCharactersInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_add_characters_in_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item addCharactersInString:$a_string];
			 ]"
		end

	objc_remove_characters_in_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item removeCharactersInString:$a_string];
			 ]"
		end

	objc_form_union_with_character_set_ (an_item: POINTER; a_other_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item formUnionWithCharacterSet:$a_other_set];
			 ]"
		end

	objc_form_intersection_with_character_set_ (an_item: POINTER; a_other_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item formIntersectionWithCharacterSet:$a_other_set];
			 ]"
		end

	objc_invert (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableCharacterSet *)$an_item invert];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableCharacterSet"
		end

end
