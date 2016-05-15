note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_ATTRIBUTED_STRING

inherit
	NS_ATTRIBUTED_STRING
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_string_,
	make_with_string__attributes_,
	make_with_attributed_string_,
	make

feature -- NSMutableAttributedString

	replace_characters_in_range__with_string_ (a_range: NS_RANGE; a_str: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_str__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			objc_replace_characters_in_range__with_string_ (item, a_range.item, a_str__item)
		end

	set_attributes__range_ (a_attrs: detachable NS_DICTIONARY; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_set_attributes__range_ (item, a_attrs__item, a_range.item)
		end

feature {NONE} -- NSMutableAttributedString Externals

	objc_replace_characters_in_range__with_string_ (an_item: POINTER; a_range: POINTER; a_str: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item replaceCharactersInRange:*((NSRange *)$a_range) withString:$a_str];
			 ]"
		end

	objc_set_attributes__range_ (an_item: POINTER; a_attrs: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item setAttributes:$a_attrs range:*((NSRange *)$a_range)];
			 ]"
		end

feature -- NSExtendedMutableAttributedString

	mutable_string: detachable NS_MUTABLE_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mutable_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_attribute__value__range_ (a_name: detachable NS_STRING; a_value: detachable NS_OBJECT; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
			a_value__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_add_attribute__value__range_ (item, a_name__item, a_value__item, a_range.item)
		end

	add_attributes__range_ (a_attrs: detachable NS_DICTIONARY; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_add_attributes__range_ (item, a_attrs__item, a_range.item)
		end

	remove_attribute__range_ (a_name: detachable NS_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_remove_attribute__range_ (item, a_name__item, a_range.item)
		end

	replace_characters_in_range__with_attributed_string_ (a_range: NS_RANGE; a_attr_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_string__item: POINTER
		do
			if attached a_attr_string as a_attr_string_attached then
				a_attr_string__item := a_attr_string_attached.item
			end
			objc_replace_characters_in_range__with_attributed_string_ (item, a_range.item, a_attr_string__item)
		end

	insert_attributed_string__at_index_ (a_attr_string: detachable NS_ATTRIBUTED_STRING; a_loc: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_string__item: POINTER
		do
			if attached a_attr_string as a_attr_string_attached then
				a_attr_string__item := a_attr_string_attached.item
			end
			objc_insert_attributed_string__at_index_ (item, a_attr_string__item, a_loc)
		end

	append_attributed_string_ (a_attr_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_string__item: POINTER
		do
			if attached a_attr_string as a_attr_string_attached then
				a_attr_string__item := a_attr_string_attached.item
			end
			objc_append_attributed_string_ (item, a_attr_string__item)
		end

	delete_characters_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_delete_characters_in_range_ (item, a_range.item)
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

	begin_editing
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_begin_editing (item)
		end

	end_editing
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_editing (item)
		end

feature {NONE} -- NSExtendedMutableAttributedString Externals

	objc_mutable_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableAttributedString *)$an_item mutableString];
			 ]"
		end

	objc_add_attribute__value__range_ (an_item: POINTER; a_name: POINTER; a_value: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item addAttribute:$a_name value:$a_value range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_add_attributes__range_ (an_item: POINTER; a_attrs: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item addAttributes:$a_attrs range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_remove_attribute__range_ (an_item: POINTER; a_name: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item removeAttribute:$a_name range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_replace_characters_in_range__with_attributed_string_ (an_item: POINTER; a_range: POINTER; a_attr_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item replaceCharactersInRange:*((NSRange *)$a_range) withAttributedString:$a_attr_string];
			 ]"
		end

	objc_insert_attributed_string__at_index_ (an_item: POINTER; a_attr_string: POINTER; a_loc: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item insertAttributedString:$a_attr_string atIndex:$a_loc];
			 ]"
		end

	objc_append_attributed_string_ (an_item: POINTER; a_attr_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item appendAttributedString:$a_attr_string];
			 ]"
		end

	objc_delete_characters_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item deleteCharactersInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_attributed_string_ (an_item: POINTER; a_attr_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item setAttributedString:$a_attr_string];
			 ]"
		end

	objc_begin_editing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item beginEditing];
			 ]"
		end

	objc_end_editing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item endEditing];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableAttributedString"
		end

end
