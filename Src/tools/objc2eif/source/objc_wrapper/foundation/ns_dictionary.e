note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_MUTABLE_COPYING_PROTOCOL
	NS_CODING_PROTOCOL
	NS_FAST_ENUMERATION_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_dictionary_,
	make_with_dictionary__copy_items_,
	make_with_objects__for_keys_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make

feature -- NSDictionary

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	object_for_key_ (a_key: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_object_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	key_enumerator: detachable NS_ENUMERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_enumerator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_enumerator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_enumerator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDictionary Externals

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item count];
			 ]"
		end

	objc_object_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item objectForKey:$a_key];
			 ]"
		end

	objc_key_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item keyEnumerator];
			 ]"
		end

feature -- NSExtendedDictionary

	all_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_keys_for_object_ (an_object: detachable NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			result_pointer := objc_all_keys_for_object_ (item, an_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_keys_for_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_keys_for_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_values: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_values (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_values} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_values} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description_in_strings_file_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_description_in_strings_file_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_in_strings_file_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_in_strings_file_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description_with_locale_ (a_locale: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_description_with_locale_ (item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description_with_locale__indent_ (a_locale: detachable NS_OBJECT; a_level: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_description_with_locale__indent_ (item, a_locale__item, a_level)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_locale__indent_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_locale__indent_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_equal_to_dictionary_ (a_other_dictionary: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other_dictionary__item: POINTER
		do
			if attached a_other_dictionary as a_other_dictionary_attached then
				a_other_dictionary__item := a_other_dictionary_attached.item
			end
			Result := objc_is_equal_to_dictionary_ (item, a_other_dictionary__item)
		end

	object_enumerator: detachable NS_ENUMERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_enumerator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_enumerator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_enumerator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	objects_for_keys__not_found_marker_ (a_keys: detachable NS_ARRAY; a_marker: detachable NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_keys__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			result_pointer := objc_objects_for_keys__not_found_marker_ (item, a_keys__item, a_marker__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like objects_for_keys__not_found_marker_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like objects_for_keys__not_found_marker_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_to_file__atomically_ (a_path: detachable NS_STRING; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_write_to_file__atomically_ (item, a_path__item, a_use_auxiliary_file)
		end

	write_to_ur_l__atomically_ (a_url: detachable NS_URL; a_atomically: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_write_to_ur_l__atomically_ (item, a_url__item, a_atomically)
		end

	keys_sorted_by_value_using_selector_ (a_comparator: detachable OBJC_SELECTOR): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_comparator__item: POINTER
		do
			if attached a_comparator as a_comparator_attached then
				a_comparator__item := a_comparator_attached.item
			end
			result_pointer := objc_keys_sorted_by_value_using_selector_ (item, a_comparator__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like keys_sorted_by_value_using_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like keys_sorted_by_value_using_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_objects__and_keys_ (a_objects: UNSUPPORTED_TYPE; a_keys: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_objects__item: POINTER
--			a_keys__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			objc_get_objects__and_keys_ (item, a_objects__item, a_keys__item)
--		end

--	enumerate_keys_and_objects_using_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_keys_and_objects_using_block_ (item, )
--		end

--	enumerate_keys_and_objects_with_options__using_block_ (a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_keys_and_objects_with_options__using_block_ (item, a_opts, )
--		end

--	keys_sorted_by_value_using_comparator_ (a_cmptr: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_keys_sorted_by_value_using_comparator_ (item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like keys_sorted_by_value_using_comparator_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like keys_sorted_by_value_using_comparator_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	keys_sorted_by_value_with_options__using_comparator_ (a_opts: NATURAL_64; a_cmptr: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_keys_sorted_by_value_with_options__using_comparator_ (item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like keys_sorted_by_value_with_options__using_comparator_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like keys_sorted_by_value_with_options__using_comparator_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	keys_of_entries_passing_test_ (a_predicate: UNSUPPORTED_TYPE): detachable NS_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_keys_of_entries_passing_test_ (item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like keys_of_entries_passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like keys_of_entries_passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	keys_of_entries_with_options__passing_test_ (a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): detachable NS_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_keys_of_entries_with_options__passing_test_ (item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like keys_of_entries_with_options__passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like keys_of_entries_with_options__passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSExtendedDictionary Externals

	objc_all_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item allKeys];
			 ]"
		end

	objc_all_keys_for_object_ (an_item: POINTER; an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item allKeysForObject:$an_object];
			 ]"
		end

	objc_all_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item allValues];
			 ]"
		end

	objc_description_in_strings_file_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item descriptionInStringsFileFormat];
			 ]"
		end

	objc_description_with_locale_ (an_item: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item descriptionWithLocale:$a_locale];
			 ]"
		end

	objc_description_with_locale__indent_ (an_item: POINTER; a_locale: POINTER; a_level: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item descriptionWithLocale:$a_locale indent:$a_level];
			 ]"
		end

	objc_is_equal_to_dictionary_ (an_item: POINTER; a_other_dictionary: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item isEqualToDictionary:$a_other_dictionary];
			 ]"
		end

	objc_object_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item objectEnumerator];
			 ]"
		end

	objc_objects_for_keys__not_found_marker_ (an_item: POINTER; a_keys: POINTER; a_marker: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item objectsForKeys:$a_keys notFoundMarker:$a_marker];
			 ]"
		end

	objc_write_to_file__atomically_ (an_item: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item writeToFile:$a_path atomically:$a_use_auxiliary_file];
			 ]"
		end

	objc_write_to_ur_l__atomically_ (an_item: POINTER; a_url: POINTER; a_atomically: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item writeToURL:$a_url atomically:$a_atomically];
			 ]"
		end

	objc_keys_sorted_by_value_using_selector_ (an_item: POINTER; a_comparator: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item keysSortedByValueUsingSelector:$a_comparator];
			 ]"
		end

--	objc_get_objects__and_keys_ (an_item: POINTER; a_objects: UNSUPPORTED_TYPE; a_keys: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSDictionary *)$an_item getObjects: andKeys:];
--			 ]"
--		end

--	objc_enumerate_keys_and_objects_using_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSDictionary *)$an_item enumerateKeysAndObjectsUsingBlock:];
--			 ]"
--		end

--	objc_enumerate_keys_and_objects_with_options__using_block_ (an_item: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSDictionary *)$an_item enumerateKeysAndObjectsWithOptions:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_keys_sorted_by_value_using_comparator_ (an_item: POINTER; a_cmptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDictionary *)$an_item keysSortedByValueUsingComparator:];
--			 ]"
--		end

--	objc_keys_sorted_by_value_with_options__using_comparator_ (an_item: POINTER; a_opts: NATURAL_64; a_cmptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDictionary *)$an_item keysSortedByValueWithOptions:$a_opts usingComparator:];
--			 ]"
--		end

--	objc_keys_of_entries_passing_test_ (an_item: POINTER; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDictionary *)$an_item keysOfEntriesPassingTest:];
--			 ]"
--		end

--	objc_keys_of_entries_with_options__passing_test_ (an_item: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDictionary *)$an_item keysOfEntriesWithOptions:$a_opts passingTest:];
--			 ]"
--		end

feature {NONE} -- Initialization

--	make_with_objects__for_keys__count_ (a_objects: UNSUPPORTED_TYPE; a_keys: UNSUPPORTED_TYPE; a_cnt: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_objects__item: POINTER
--			a_keys__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			if attached a_keys as a_keys_attached then
--				a_keys__item := a_keys_attached.item
--			end
--			make_with_pointer (objc_init_with_objects__for_keys__count_(allocate_object, a_objects__item, a_keys__item, a_cnt))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_dictionary_ (a_other_dictionary: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_other_dictionary__item: POINTER
		do
			if attached a_other_dictionary as a_other_dictionary_attached then
				a_other_dictionary__item := a_other_dictionary_attached.item
			end
			make_with_pointer (objc_init_with_dictionary_(allocate_object, a_other_dictionary__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_dictionary__copy_items_ (a_other_dictionary: detachable NS_DICTIONARY; a_flag: BOOLEAN)
			-- Initialize `Current'.
		local
			a_other_dictionary__item: POINTER
		do
			if attached a_other_dictionary as a_other_dictionary_attached then
				a_other_dictionary__item := a_other_dictionary_attached.item
			end
			make_with_pointer (objc_init_with_dictionary__copy_items_(allocate_object, a_other_dictionary__item, a_flag))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_objects__for_keys_ (a_objects: detachable NS_ARRAY; a_keys: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_objects__item: POINTER
			a_keys__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			make_with_pointer (objc_init_with_objects__for_keys_(allocate_object, a_objects__item, a_keys__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_file_ (a_path: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_file_(allocate_object, a_path__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDictionaryCreation Externals

--	objc_init_with_objects__for_keys__count_ (an_item: POINTER; a_objects: UNSUPPORTED_TYPE; a_keys: UNSUPPORTED_TYPE; a_cnt: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSDictionary *)$an_item initWithObjects: forKeys: count:$a_cnt];
--			 ]"
--		end

	objc_init_with_dictionary_ (an_item: POINTER; a_other_dictionary: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item initWithDictionary:$a_other_dictionary];
			 ]"
		end

	objc_init_with_dictionary__copy_items_ (an_item: POINTER; a_other_dictionary: POINTER; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item initWithDictionary:$a_other_dictionary copyItems:$a_flag];
			 ]"
		end

	objc_init_with_objects__for_keys_ (an_item: POINTER; a_objects: POINTER; a_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item initWithObjects:$a_objects forKeys:$a_keys];
			 ]"
		end

	objc_init_with_contents_of_file_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item initWithContentsOfFile:$a_path];
			 ]"
		end

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

feature -- NSFileAttributes

	file_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_size (item)
		end

	file_modification_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_modification_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_modification_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_modification_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_posix_permissions: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_posix_permissions (item)
		end

	file_owner_account_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_owner_account_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_owner_account_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_owner_account_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_group_owner_account_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_group_owner_account_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_group_owner_account_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_group_owner_account_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_system_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_system_number (item)
		end

	file_system_file_number: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_system_file_number (item)
		end

	file_extension_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_extension_hidden (item)
		end

	file_hfs_creator_code: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_hfs_creator_code (item)
		end

	file_hfs_type_code: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_hfs_type_code (item)
		end

	file_is_immutable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_is_immutable (item)
		end

	file_is_append_only: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_file_is_append_only (item)
		end

	file_creation_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_creation_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_creation_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_creation_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_owner_account_id: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_owner_account_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_owner_account_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_owner_account_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	file_group_owner_account_id: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_group_owner_account_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_group_owner_account_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_group_owner_account_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSFileAttributes Externals

	objc_file_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileSize];
			 ]"
		end

	objc_file_modification_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileModificationDate];
			 ]"
		end

	objc_file_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileType];
			 ]"
		end

	objc_file_posix_permissions (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item filePosixPermissions];
			 ]"
		end

	objc_file_owner_account_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileOwnerAccountName];
			 ]"
		end

	objc_file_group_owner_account_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileGroupOwnerAccountName];
			 ]"
		end

	objc_file_system_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileSystemNumber];
			 ]"
		end

	objc_file_system_file_number (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileSystemFileNumber];
			 ]"
		end

	objc_file_extension_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileExtensionHidden];
			 ]"
		end

	objc_file_hfs_creator_code (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileHFSCreatorCode];
			 ]"
		end

	objc_file_hfs_type_code (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileHFSTypeCode];
			 ]"
		end

	objc_file_is_immutable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileIsImmutable];
			 ]"
		end

	objc_file_is_append_only (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDictionary *)$an_item fileIsAppendOnly];
			 ]"
		end

	objc_file_creation_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileCreationDate];
			 ]"
		end

	objc_file_owner_account_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileOwnerAccountID];
			 ]"
		end

	objc_file_group_owner_account_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDictionary *)$an_item fileGroupOwnerAccountID];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDictionary"
		end

end
