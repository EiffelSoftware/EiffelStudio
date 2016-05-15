note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY_CONTROLLER

inherit
	NS_ARRAY_CONTROLLER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	makeial_key,
	makeial_value,
	make_with_content_,
	make

feature -- NSDictionaryController

	set_initial_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_initial_key_ (item, a_key__item)
		end

	set_initial_value_ (a_value: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_initial_value_ (item, a_value__item)
		end

	set_included_keys_ (a_keys: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_keys__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			objc_set_included_keys_ (item, a_keys__item)
		end

	included_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_included_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like included_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like included_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_excluded_keys_ (a_keys: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_keys__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			objc_set_excluded_keys_ (item, a_keys__item)
		end

	excluded_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_excluded_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like excluded_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like excluded_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_localized_key_dictionary_ (a_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_dictionary__item: POINTER
		do
			if attached a_dictionary as a_dictionary_attached then
				a_dictionary__item := a_dictionary_attached.item
			end
			objc_set_localized_key_dictionary_ (item, a_dictionary__item)
		end

	localized_key_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_key_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_key_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_key_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_localized_key_table_ (a_strings_file_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_strings_file_name__item: POINTER
		do
			if attached a_strings_file_name as a_strings_file_name_attached then
				a_strings_file_name__item := a_strings_file_name_attached.item
			end
			objc_set_localized_key_table_ (item, a_strings_file_name__item)
		end

	localized_key_table: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_key_table (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_key_table} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_key_table} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDictionaryController Externals

	objc_set_initial_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDictionaryController *)$an_item setInitialKey:$a_key];
			 ]"
		end

	objc_initial_key (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionaryController *)$an_item initialKey];
			 ]"
		end

	objc_set_initial_value_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDictionaryController *)$an_item setInitialValue:$a_value];
			 ]"
		end

	objc_initial_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionaryController *)$an_item initialValue];
			 ]"
		end

	objc_set_included_keys_ (an_item: POINTER; a_keys: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDictionaryController *)$an_item setIncludedKeys:$a_keys];
			 ]"
		end

	objc_included_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionaryController *)$an_item includedKeys];
			 ]"
		end

	objc_set_excluded_keys_ (an_item: POINTER; a_keys: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDictionaryController *)$an_item setExcludedKeys:$a_keys];
			 ]"
		end

	objc_excluded_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionaryController *)$an_item excludedKeys];
			 ]"
		end

	objc_set_localized_key_dictionary_ (an_item: POINTER; a_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDictionaryController *)$an_item setLocalizedKeyDictionary:$a_dictionary];
			 ]"
		end

	objc_localized_key_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionaryController *)$an_item localizedKeyDictionary];
			 ]"
		end

	objc_set_localized_key_table_ (an_item: POINTER; a_strings_file_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDictionaryController *)$an_item setLocalizedKeyTable:$a_strings_file_name];
			 ]"
		end

	objc_localized_key_table (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionaryController *)$an_item localizedKeyTable];
			 ]"
		end

feature {NONE} -- Initialization

	makeial_key
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_initial_key(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	makeial_value
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_initial_value(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDictionaryController"
		end

end
