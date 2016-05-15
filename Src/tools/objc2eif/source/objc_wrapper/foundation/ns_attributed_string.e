note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ATTRIBUTED_STRING

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
	make_with_string_,
	make_with_string__attributes_,
	make_with_attributed_string_,
	make

feature -- NSAttributedString

	string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	attributes_at_index__effective_range_ (a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_attributes_at_index__effective_range_ (item, a_location, a_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attributes_at_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attributes_at_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSAttributedString Externals

	objc_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item string];
			 ]"
		end

--	objc_attributes_at_index__effective_range_ (an_item: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item attributesAtIndex:$a_location effectiveRange:];
--			 ]"
--		end

feature -- NSExtendedAttributedString

	length: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_length (item)
		end

--	attribute__at_index__effective_range_ (a_attr_name: detachable NS_STRING; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_attr_name__item: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_attr_name as a_attr_name_attached then
--				a_attr_name__item := a_attr_name_attached.item
--			end
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_attribute__at_index__effective_range_ (item, a_attr_name__item, a_location, a_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attribute__at_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attribute__at_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	attributed_substring_from_range_ (a_range: NS_RANGE): detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_substring_from_range_ (item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_substring_from_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_substring_from_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	attributes_at_index__longest_effective_range__in_range_ (a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: NS_RANGE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_attributes_at_index__longest_effective_range__in_range_ (item, a_location, a_range__item, a_range_limit.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attributes_at_index__longest_effective_range__in_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attributes_at_index__longest_effective_range__in_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	attribute__at_index__longest_effective_range__in_range_ (a_attr_name: detachable NS_STRING; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: NS_RANGE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_attr_name__item: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_attr_name as a_attr_name_attached then
--				a_attr_name__item := a_attr_name_attached.item
--			end
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_attribute__at_index__longest_effective_range__in_range_ (item, a_attr_name__item, a_location, a_range__item, a_range_limit.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like attribute__at_index__longest_effective_range__in_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like attribute__at_index__longest_effective_range__in_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	is_equal_to_attributed_string_ (a_other: detachable NS_ATTRIBUTED_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			Result := objc_is_equal_to_attributed_string_ (item, a_other__item)
		end

--	enumerate_attributes_in_range__options__using_block_ (a_enumeration_range: NS_RANGE; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_attributes_in_range__options__using_block_ (item, a_enumeration_range.item, a_opts, )
--		end

--	enumerate_attribute__in_range__options__using_block_ (a_attr_name: detachable NS_STRING; a_enumeration_range: NS_RANGE; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_attr_name__item: POINTER
--		do
--			if attached a_attr_name as a_attr_name_attached then
--				a_attr_name__item := a_attr_name_attached.item
--			end
--			objc_enumerate_attribute__in_range__options__using_block_ (item, a_attr_name__item, a_enumeration_range.item, a_opts, )
--		end

feature {NONE} -- NSExtendedAttributedString Externals

	objc_length (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item length];
			 ]"
		end

--	objc_attribute__at_index__effective_range_ (an_item: POINTER; a_attr_name: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item attribute:$a_attr_name atIndex:$a_location effectiveRange:];
--			 ]"
--		end

	objc_attributed_substring_from_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item attributedSubstringFromRange:*((NSRange *)$a_range)];
			 ]"
		end

--	objc_attributes_at_index__longest_effective_range__in_range_ (an_item: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item attributesAtIndex:$a_location longestEffectiveRange: inRange:*((NSRange *)$a_range_limit)];
--			 ]"
--		end

--	objc_attribute__at_index__longest_effective_range__in_range_ (an_item: POINTER; a_attr_name: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item attribute:$a_attr_name atIndex:$a_location longestEffectiveRange: inRange:*((NSRange *)$a_range_limit)];
--			 ]"
--		end

	objc_is_equal_to_attributed_string_ (an_item: POINTER; a_other: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item isEqualToAttributedString:$a_other];
			 ]"
		end

	objc_init_with_string_ (an_item: POINTER; a_str: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithString:$a_str];
			 ]"
		end

	objc_init_with_string__attributes_ (an_item: POINTER; a_str: POINTER; a_attrs: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithString:$a_str attributes:$a_attrs];
			 ]"
		end

	objc_init_with_attributed_string_ (an_item: POINTER; a_attr_str: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithAttributedString:$a_attr_str];
			 ]"
		end

--	objc_enumerate_attributes_in_range__options__using_block_ (an_item: POINTER; a_enumeration_range: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSAttributedString *)$an_item enumerateAttributesInRange:*((NSRange *)$a_enumeration_range) options:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_enumerate_attribute__in_range__options__using_block_ (an_item: POINTER; a_attr_name: POINTER; a_enumeration_range: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSAttributedString *)$an_item enumerateAttribute:$a_attr_name inRange:*((NSRange *)$a_enumeration_range) options:$a_opts usingBlock:];
--			 ]"
--		end

feature {NONE} -- Initialization

	make_with_string_ (a_str: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_str__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_str__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string__attributes_ (a_str: detachable NS_STRING; a_attrs: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_str__item: POINTER
			a_attrs__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			make_with_pointer (objc_init_with_string__attributes_(allocate_object, a_str__item, a_attrs__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_attributed_string_ (a_attr_str: detachable NS_ATTRIBUTED_STRING)
			-- Initialize `Current'.
		local
			a_attr_str__item: POINTER
		do
			if attached a_attr_str as a_attr_str_attached then
				a_attr_str__item := a_attr_str_attached.item
			end
			make_with_pointer (objc_init_with_attributed_string_(allocate_object, a_attr_str__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAttributedString"
		end

end
