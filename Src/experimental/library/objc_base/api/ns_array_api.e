note
	description: "Summary description for {NS_ARRAY_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ARRAY_API

feature -- Createing an Array & Initializing an Array

	frozen array_with_objects_count (a_objects: POINTER; a_count: INTEGER): POINTER
		external
			"C inline use <Foundation/NSArray.h>"
		alias
			"return [NSArray arrayWithObjects: $a_objects count: $a_count];"
		end

feature -- Querying an Array

	frozen count (a_array: POINTER): INTEGER
		external
			"C inline use <Foundation/NSArray.h>"
		alias
			"return [(NSArray*)$a_array count];"
		end

	frozen object_at_index (a_array: POINTER; a_index: INTEGER): POINTER
		external
			"C inline use <Foundation/NSArray.h>"
		alias
			"return [(NSArray*)$a_array objectAtIndex: $a_index];"
		end

--	frozen array_by_adding_object (a_array: POINTER; a_an_object: NS_OBJECT): POINTER
--		external
--			"C inline use <Foundation/NSObject.h>"
--		alias
--			"return [(NSArray*)$a_array arrayByAddingObject: $a_an_object];"
--		end

--	frozen array_by_adding_objects_from_array (a_array: POINTER; a_other_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array arrayByAddingObjectsFromArray: $a_other_array];"
--		end

--	frozen components_joined_by_string (a_array: POINTER; a_separator: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array componentsJoinedByString: $a_separator];"
--		end

--	frozen contains_object (a_array: POINTER; a_an_object: POINTER): BOOLEAN
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array containsObject: $a_an_object];"
--		end

--	frozen description (a_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array description];"
--		end

--	frozen description_with_locale (a_array: POINTER; a_locale: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array descriptionWithLocale: $a_locale];"
--		end

--	frozen description_with_locale_indent (a_array: POINTER; a_locale: POINTER; a_level: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array descriptionWithLocale: $a_locale];"
--		end

feature -- Comparing Arrays

--	frozen first_object_common_with_array (a_array: POINTER; a_other_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array firstObjectCommonWithArray: $a_other_array];"
--		end

feature -- Deriving New Arrays

--	frozen get_objects (a_array: POINTER; a_objects: POINTER[NS_OBJECT])
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"[(NSArray*)$a_array getObjects: $a_objects];"
--		end

--	frozen get_objects_range (a_array: POINTER; a_objects: POINTER[NS_OBJECT]; a_range: POINTER)
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"[(NSArray*)$a_array getObjects: $a_objects];"
--		end

--	frozen index_of_object (a_array: POINTER; a_an_object: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObject: $a_an_object];"
--		end

--	frozen index_of_object_in_range (a_array: POINTER; a_an_object: POINTER; a_range: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObject: $a_an_object];"
--		end

--	frozen index_of_object_identical_to (a_array: POINTER; a_an_object: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObjectIdenticalTo: $a_an_object];"
--		end

--	frozen index_of_object_identical_to_in_range (a_array: POINTER; a_an_object: POINTER; a_range: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array indexOfObjectIdenticalTo: $a_an_object];"
--		end

--	frozen is_equal_to_array (a_array: POINTER; a_other_array: POINTER): BOOLEAN
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array isEqualToArray: $a_other_array];"
--		end

--	frozen last_object (a_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array lastObject];"
--		end

--	frozen object_enumerator (a_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array objectEnumerator];"
--		end

--	frozen reverse_object_enumerator (a_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array reverseObjectEnumerator];"
--		end

feature -- Sorting

--	frozen sorted_array_hint (a_array: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array sortedArrayHint];"
--		end

----	frozen sorted_array_using_selector (a_array: POINTER; a_comparator: SELECTOR): POINTER
----		external
----			"C inline use <Foundation/NSArray.h>"
----		alias
----			"return [(NSArray*)$a_array sortedArrayUsingSelector: $a_comparator];"
----		end

--	frozen subarray_with_range (a_array: POINTER; a_range: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array subarrayWithRange: $a_range];"
--		end

--	frozen write_to_file_atomically (a_array: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN): BOOLEAN
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array writeToFile: $a_path];"
--		end

--	frozen write_to_u_r_l_atomically (a_array: POINTER; a_url: POINTER; a_atomically: BOOLEAN): BOOLEAN
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array writeToURL: $a_url];"
--		end

----	frozen make_objects_perform_selector (a_array: POINTER; a_a_selector: SELECTOR)
----		external
----			"C inline use <Foundation/NSArray.h>"
----		alias
----			"[(NSArray*)$a_array makeObjectsPerformSelector: $a_a_selector];"
----		end

----	frozen make_objects_perform_selector_with_object (a_array: POINTER; a_a_selector: SELECTOR; a_argument: NS_OBJECT)
----		external
----			"C inline use <Foundation/NSArray.h>"
----		alias
----			"[(NSArray*)$a_array makeObjectsPerformSelector: $a_a_selector];"
----		end

--	frozen objects_at_indexes (a_array: POINTER; a_indexes: POINTER): POINTER
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array objectsAtIndexes: $a_indexes];"
--		end

----	frozen init_with_objects_count (a_array: POINTER; a_objects: POINTER[NS_OBJECT]; a_cnt: POINTER): NS_OBJECT
----		external
----			"C inline use <Foundation/NSArray.h>"
----		alias
----			"return [(NSArray*)$a_array initWithObjects: $a_objects];"
----		end

----	frozen init_with_array (a_array: POINTER; a_array: POINTER): NS_OBJECT
----		external
----			"C inline use <Foundation/NSArray.h>"
----		alias
----			"return [(NSArray*)$a_array initWithArray: $a_array];"
----		end

----	frozen init_with_array_copy_items (a_array: POINTER; a_array: POINTER; a_flag: BOOLEAN): NS_OBJECT
----		external
----			"C inline use <Foundation/NSArray.h>"
----		alias
----			"return [(NSArray*)$a_array initWithArray: $a_array];"
----		end

--	frozen init_with_contents_of_file (a_array: POINTER; a_path: POINTER): NS_OBJECT
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array initWithContentsOfFile: $a_path];"
--		end

--	frozen init_with_contents_of_url (a_array: POINTER; a_url: POINTER): NS_OBJECT
--		external
--			"C inline use <Foundation/NSArray.h>"
--		alias
--			"return [(NSArray*)$a_array initWithContentsOfURL: $a_url];"
--		end

end
