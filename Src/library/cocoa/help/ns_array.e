note
	description: "Summary description for {NS_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

-- FIXME NSUInteger has been replaced by INTEGER. may cause problems

class
	NS_ARRAY [T -> NS_OBJECT create make_shared end]

inherit
	NS_OBJECT

create
	make_shared

feature

	count: INTEGER
		do
			Result := array_count (cocoa_object)
		end

	object_at_index (a_index: INTEGER): T
		require
			a_index >= 0
		do
			create Result.make_shared (array_object_at_index (cocoa_object, a_index))
		end

--	array_by_adding_object (a_an_object: T): NS_ARRAY [T]
--		do
--			Result := array_array_by_adding_object(cocoa_object, a_an_object.cocoa_object)
--		end

--	array_by_adding_objects_from_array (a_other_array: NS_ARRAY [T]): NS_ARRAY [T]
--		do
--			Result := array_array_by_adding_objects_from_array(cocoa_object, a_other_array.cocoa_object)
--		end

--	components_joined_by_string (a_separator: NS_STRING): NS_STRING
--		do
--			Result := array_components_joined_by_string(cocoa_object, a_separator.cocoa_object)
--		end

--	contains_object (a_an_object: NS_OBJECT): BOOLEAN
--		do
--			Result := array_contains_object(cocoa_object, a_an_object.cocoa_object)
--		end

--	description : NS_STRING
--		do
--			Result := array_description(cocoa_object)
--		end

--	description_with_locale (a_locale: NS_OBJECT): NS_STRING
--		do
--			Result := array_description_with_locale(cocoa_object, a_locale.cocoa_object)
--		end

--	description_with_locale_indent (a_locale: NS_OBJECT; a_level: INTEGER): NS_STRING
--		do
--			Result := array_description_with_locale_indent(cocoa_object, a_locale.cocoa_object, a_level.cocoa_object)
--		end

--	first_object_common_with_array (a_other_array: like current): T
--		do
--			Result := array_first_object_common_with_array(cocoa_object, a_other_array.cocoa_object)
--		end

----	get_objects (a_objects: POINTER[NS_OBJECT])
----		do
----			array_get_objects(cocoa_object, a_objects)
----		end

----	get_objects_range (a_objects: POINTER[NS_OBJECT]; a_range: NS_RANGE)
----		do
----			array_get_objects_range(cocoa_object, a_objects, a_range.cocoa_object)
----		end

--	index_of_object (a_an_object: NS_OBJECT): INTEGER
--		do
--			Result := array_index_of_object(cocoa_object, a_an_object.cocoa_object)
--		end

----	index_of_object_in_range (a_an_object: NS_OBJECT; a_range: NS_RANGE): INTEGER
----		do
----			Result := array_index_of_object_in_range(cocoa_object, a_an_object.cocoa_object, a_range.cocoa_object)
----		end

--	index_of_object_identical_to (a_an_object: NS_OBJECT): INTEGER
--		do
--			Result := array_index_of_object_identical_to(cocoa_object, a_an_object.cocoa_object)
--		end

----	index_of_object_identical_to_in_range (a_an_object: NS_OBJECT; a_range: NS_RANGE): INTEGER
----		do
----			Result := array_index_of_object_identical_to_in_range(cocoa_object, a_an_object.cocoa_object, a_range.cocoa_object)
----		end

--	is_equal_to_array (a_other_array: NS_ARRAY): BOOLEAN
--		do
--			Result := array_is_equal_to_array(cocoa_object, a_other_array.cocoa_object)
--		end

--	last_object: T
--		do
----			Result := array_last_object(cocoa_object)
--		end

----	object_enumerator : NS_ENUMERATOR
----		do
----			Result := array_object_enumerator(cocoa_object)
----		end

----	reverse_object_enumerator : NS_ENUMERATOR
----		do
----			Result := array_reverse_object_enumerator(cocoa_object)
----		end

----	sorted_array_hint : NS_DATA
----		do
----			Result := array_sorted_array_hint(cocoa_object)
----		end

----	sorted_array_using_selector (a_comparator: SELECTOR): NS_ARRAY
----		do
----			Result := array_sorted_array_using_selector(cocoa_object, a_comparator)
----		end

----	subarray_with_range (a_range: NS_RANGE): NS_ARRAY
----		do
----			Result := array_subarray_with_range(cocoa_object, a_range.cocoa_object)
----		end

--	write_to_file_atomically (a_path: NS_STRING; a_use_auxiliary_file: BOOLEAN): BOOLEAN
--		do
--			Result := array_write_to_file_atomically(cocoa_object, a_path.cocoa_object, a_use_auxiliary_file)
--		end

----	write_to_url_atomically (a_url: NS_URL; a_atomically: BOOLEAN): BOOLEAN
----		do
----			Result := array_write_to_u_r_l_atomically(cocoa_object, a_url.cocoa_object, a_atomically)
----		end

----	make_objects_perform_selector (a_a_selector: SELECTOR)
----		do
----			array_make_objects_perform_selector(cocoa_object, a_a_selector)
----		end

----	make_objects_perform_selector_with_object (a_a_selector: SELECTOR; a_argument: NS_OBJECT)
----		do
----			array_make_objects_perform_selector_with_object(cocoa_object, a_a_selector, a_argument.cocoa_object)
----		end

----	objects_at_indexes (a_indexes: NS_INDEX_SET): NS_ARRAY
----		do
----			Result := array_objects_at_indexes(cocoa_object, a_indexes.cocoa_object)
----		end

--	init_with_objects_count (a_objects: POINTER[NS_OBJECT]; a_cnt: INTEGER): NS_OBJECT
--		do
--			Result := array_init_with_objects_count(cocoa_object, a_objects, a_cnt.cocoa_object)
--		end

--	init_with_array (a_array: NS_ARRAY): NS_OBJECT
--		do
--			Result := array_init_with_array(cocoa_object, a_array.cocoa_object)
--		end

--	init_with_array_copy_items (a_array: NS_ARRAY; a_flag: BOOLEAN): NS_OBJECT
--		do
--			Result := array_init_with_array_copy_items (cocoa_object, a_array.cocoa_object, a_flag)
--		end

--	init_with_contents_of_file (a_path: NS_STRING): NS_OBJECT
--		do
--			Result := array_init_with_contents_of_file(cocoa_object, a_path.cocoa_object)
--		end

----	init_with_contents_of_u_r_l (a_url: NS_URL): NS_OBJECT
----		do
----			Result := array_init_with_contents_of_u_r_l(cocoa_object, a_url.cocoa_object)
----		end

feature -- Objective-C implementation

	frozen array_count (a_array: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSArray*)$a_array count];"
		end

	frozen array_object_at_index (a_array: POINTER; a_index: INTEGER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSArray*)$a_array objectAtIndex: $a_index];"
		end

--	frozen array_array_by_adding_object (a_array: POINTER; a_an_object: NS_OBJECT): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array arrayByAddingObject: $a_an_object];"
--		end

--	frozen array_array_by_adding_objects_from_array (a_array: POINTER; a_other_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array arrayByAddingObjectsFromArray: $a_other_array];"
--		end

--	frozen array_components_joined_by_string (a_array: POINTER; a_separator: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array componentsJoinedByString: $a_separator];"
--		end

--	frozen array_contains_object (a_array: POINTER; a_an_object: POINTER): BOOLEAN
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array containsObject: $a_an_object];"
--		end

--	frozen array_description (a_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array description];"
--		end

--	frozen array_description_with_locale (a_array: POINTER; a_locale: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array descriptionWithLocale: $a_locale];"
--		end

--	frozen array_description_with_locale_indent (a_array: POINTER; a_locale: POINTER; a_level: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array descriptionWithLocale: $a_locale];"
--		end

--	frozen array_first_object_common_with_array (a_array: POINTER; a_other_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array firstObjectCommonWithArray: $a_other_array];"
--		end

--	frozen array_get_objects (a_array: POINTER; a_objects: POINTER[NS_OBJECT])
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSArray*)$a_array getObjects: $a_objects];"
--		end

--	frozen array_get_objects_range (a_array: POINTER; a_objects: POINTER[NS_OBJECT]; a_range: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSArray*)$a_array getObjects: $a_objects];"
--		end

--	frozen array_index_of_object (a_array: POINTER; a_an_object: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObject: $a_an_object];"
--		end

--	frozen array_index_of_object_in_range (a_array: POINTER; a_an_object: POINTER; a_range: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObject: $a_an_object];"
--		end

--	frozen array_index_of_object_identical_to (a_array: POINTER; a_an_object: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObjectIdenticalTo: $a_an_object];"
--		end

--	frozen array_index_of_object_identical_to_in_range (a_array: POINTER; a_an_object: POINTER; a_range: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObjectIdenticalTo: $a_an_object];"
--		end

--	frozen array_is_equal_to_array (a_array: POINTER; a_other_array: POINTER): BOOLEAN
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array isEqualToArray: $a_other_array];"
--		end

--	frozen array_last_object (a_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array lastObject];"
--		end

--	frozen array_object_enumerator (a_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array objectEnumerator];"
--		end

--	frozen array_reverse_object_enumerator (a_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array reverseObjectEnumerator];"
--		end

--	frozen array_sorted_array_hint (a_array: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array sortedArrayHint];"
--		end

----	frozen array_sorted_array_using_selector (a_array: POINTER; a_comparator: SELECTOR): POINTER
----		external
----			"C inline use <Cocoa/Cocoa.h>"
----		alias
----			"return [(NSArray*)$a_array sortedArrayUsingSelector: $a_comparator];"
----		end

--	frozen array_subarray_with_range (a_array: POINTER; a_range: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array subarrayWithRange: $a_range];"
--		end

--	frozen array_write_to_file_atomically (a_array: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN): BOOLEAN
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array writeToFile: $a_path];"
--		end

--	frozen array_write_to_u_r_l_atomically (a_array: POINTER; a_url: POINTER; a_atomically: BOOLEAN): BOOLEAN
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array writeToURL: $a_url];"
--		end

----	frozen array_make_objects_perform_selector (a_array: POINTER; a_a_selector: SELECTOR)
----		external
----			"C inline use <Cocoa/Cocoa.h>"
----		alias
----			"[(NSArray*)$a_array makeObjectsPerformSelector: $a_a_selector];"
----		end

----	frozen array_make_objects_perform_selector_with_object (a_array: POINTER; a_a_selector: SELECTOR; a_argument: NS_OBJECT)
----		external
----			"C inline use <Cocoa/Cocoa.h>"
----		alias
----			"[(NSArray*)$a_array makeObjectsPerformSelector: $a_a_selector];"
----		end

--	frozen array_objects_at_indexes (a_array: POINTER; a_indexes: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array objectsAtIndexes: $a_indexes];"
--		end

----	frozen array_init_with_objects_count (a_array: POINTER; a_objects: POINTER[NS_OBJECT]; a_cnt: POINTER): NS_OBJECT
----		external
----			"C inline use <Cocoa/Cocoa.h>"
----		alias
----			"return [(NSArray*)$a_array initWithObjects: $a_objects];"
----		end

----	frozen array_init_with_array (a_array: POINTER; a_array: POINTER): NS_OBJECT
----		external
----			"C inline use <Cocoa/Cocoa.h>"
----		alias
----			"return [(NSArray*)$a_array initWithArray: $a_array];"
----		end

----	frozen array_init_with_array_copy_items (a_array: POINTER; a_array: POINTER; a_flag: BOOLEAN): NS_OBJECT
----		external
----			"C inline use <Cocoa/Cocoa.h>"
----		alias
----			"return [(NSArray*)$a_array initWithArray: $a_array];"
----		end

--	frozen array_init_with_contents_of_file (a_array: POINTER; a_path: POINTER): NS_OBJECT
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array initWithContentsOfFile: $a_path];"
--		end

--	frozen array_init_with_contents_of_url (a_array: POINTER; a_url: POINTER): NS_OBJECT
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSArray*)$a_array initWithContentsOfURL: $a_url];"
--		end
end
