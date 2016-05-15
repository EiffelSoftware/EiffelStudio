note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_STRING

inherit
	NS_STRING
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make,
	make_with_string_,
	make_with_data__encoding_

feature -- NSMutableString

	replace_characters_in_range__with_string_ (a_range: NS_RANGE; a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_replace_characters_in_range__with_string_ (item, a_range.item, a_string__item)
		end

feature {NONE} -- NSMutableString Externals

	objc_replace_characters_in_range__with_string_ (an_item: POINTER; a_range: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableString *)$an_item replaceCharactersInRange:*((NSRange *)$a_range) withString:$a_string];
			 ]"
		end

feature -- NSMutableStringExtensionMethods

	insert_string__at_index_ (a_string: detachable NS_STRING; a_loc: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_insert_string__at_index_ (item, a_string__item, a_loc)
		end

	delete_characters_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_delete_characters_in_range_ (item, a_range.item)
		end

	append_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_append_string_ (item, a_string__item)
		end

	set_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_string_ (item, a_string__item)
		end

	replace_occurrences_of_string__with_string__options__range_ (a_target: detachable NS_STRING; a_replacement: detachable NS_STRING; a_options: NATURAL_64; a_search_range: NS_RANGE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
			a_replacement__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_replacement as a_replacement_attached then
				a_replacement__item := a_replacement_attached.item
			end
			Result := objc_replace_occurrences_of_string__with_string__options__range_ (item, a_target__item, a_replacement__item, a_options, a_search_range.item)
		end

feature {NONE} -- NSMutableStringExtensionMethods Externals

	objc_insert_string__at_index_ (an_item: POINTER; a_string: POINTER; a_loc: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableString *)$an_item insertString:$a_string atIndex:$a_loc];
			 ]"
		end

	objc_delete_characters_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableString *)$an_item deleteCharactersInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_append_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableString *)$an_item appendString:$a_string];
			 ]"
		end

	objc_set_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableString *)$an_item setString:$a_string];
			 ]"
		end

	objc_init_with_capacity_ (an_item: POINTER; a_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableString *)$an_item initWithCapacity:$a_capacity];
			 ]"
		end

	objc_replace_occurrences_of_string__with_string__options__range_ (an_item: POINTER; a_target: POINTER; a_replacement: POINTER; a_options: NATURAL_64; a_search_range: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMutableString *)$an_item replaceOccurrencesOfString:$a_target withString:$a_replacement options:$a_options range:*((NSRange *)$a_search_range)];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_capacity_ (a_capacity: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_capacity_(allocate_object, a_capacity))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableString"
		end

end
