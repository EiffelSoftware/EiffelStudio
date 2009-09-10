note
	description: "Wrapper for NSArray. Typed with Eiffel Generics."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ARRAY [T -> detachable NS_OBJECT create share_from_pointer end]

inherit
	NS_OBJECT
		rename
			item as object_item
		undefine
			copy
		end

	LINEAR [T]
		rename
			item as item_for_iteration
		undefine
			copy
		redefine
			item_for_iteration
		end

	NS_COPYING
		rename
			item as object_item
		end

-- TODO: Would probably be nice if an NS_ARRAY could inherit from CHAIN [T] or even ARRAY [T]

create
	make_with_objects,
	make_from_array

create {NS_OBJECT, NS_ENVIRONEMENT}
	share_from_pointer

convert
	make_with_objects ({LIST[T]}),
	make_from_array ({ARRAY[T]})

feature {NONE} -- Creation

	make_with_objects (a_objects: LIST [T])
		local
			l_objects: MANAGED_POINTER
			i: INTEGER
		do
			create l_objects.make (a_objects.count * {PLATFORM}.pointer_bytes)
			from
				a_objects.start
				i := 0
			until
				a_objects.after
			loop
				if attached a_objects.item as l_object  then
					l_objects.put_pointer (l_object.item, i * {PLATFORM}.pointer_bytes )
				end
				i := i + 1
				a_objects.forth
			end
			make_from_pointer ({NS_ARRAY_API}.create_with_objects_count (l_objects.item, to_ns_uinteger (a_objects.count)))
		end

	make_from_array (a_array: ARRAY [T])
			-- Creates an NS_ARRAY with given elements
		local
			l_objects: MANAGED_POINTER
			i, j: INTEGER
		do
			create l_objects.make (a_array.count)
			from
				i := 0
				j := a_array.lower
			until
				j > a_array.upper
			loop
				if attached a_array.item (j) as l_object then
					l_objects.put_pointer (l_object.item, i * {PLATFORM}.pointer_bytes )
				end
				i := i + 1
				j := j + 1
			end
			make_from_pointer ({NS_ARRAY_API}.create_with_objects_count (l_objects.item, to_ns_uinteger (a_array.count)))
		end

feature -- Access

	is_empty: BOOLEAN
			-- Is there no element?
		do
			Result := count = 0
		end

	count: like ns_uinteger
			-- Number of available indices
		do
			Result := {NS_ARRAY_API}.count (object_item)
		ensure
			count_positive: Result >= 0
		end

	item alias "[]" (a_index: like ns_uinteger): detachable T
			-- Entry at index `i', if in index interval
		require
			index_in_range: 0 <= a_index and a_index < count
		local
			l_object: POINTER
		do
			l_object := {NS_ARRAY_API}.object_at_index (object_item, a_index)
			if l_object /= default_pointer then
				create Result.share_from_pointer (l_object)
			end
		end

	item_for_iteration: T
			-- Item at current position
		local
			res: like item
		do
			res := item (to_ns_uinteger(index))
			check res /= Void end
			Result := res
		end

	index: INTEGER
			-- Index of current position

feature -- Cursor movement

	start
			-- Move to first position if any.
		do
			index := 0
		end

	finish
			-- Move to last position.
		do
			index := count.to_integer_32 - 1
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			index := index + 1
		end

feature -- Status report

	after: BOOLEAN
			-- Is there no valid position to the right of current one?
		do
			Result := (index >= count.to_integer_32)
		end

--	array_by_adding_object (a_an_object: T): NS_ARRAY [T]
--		do
--			Result :=  {NS_ARRAY_API}array_by_adding_object(cocoa_object, a_an_object.cocoa_object)
--		end

--	array_by_adding_objects_from_array (a_other_array: NS_ARRAY [T]): NS_ARRAY [T]
--		do
--			Result :=  {NS_ARRAY_API}array_by_adding_objects_from_array(cocoa_object, a_other_array.cocoa_object)
--		end

--	components_joined_by_string (a_separator: NS_STRING): NS_STRING
--		do
--			Result :=  {NS_ARRAY_API}components_joined_by_string(cocoa_object, a_separator.cocoa_object)
--		end

--	contains_object (a_an_object: NS_OBJECT): BOOLEAN
--		do
--			Result :=  {NS_ARRAY_API}contains_object(cocoa_object, a_an_object.cocoa_object)
--		end

--	description : NS_STRING
--		do
--			Result :=  {NS_ARRAY_API}description(cocoa_object)
--		end

--	description_with_locale (a_locale: NS_OBJECT): NS_STRING
--		do
--			Result :=  {NS_ARRAY_API}description_with_locale(cocoa_object, a_locale.cocoa_object)
--		end

--	description_with_locale_indent (a_locale: NS_OBJECT; a_level: INTEGER): NS_STRING
--		do
--			Result :=  {NS_ARRAY_API}description_with_locale_indent(cocoa_object, a_locale.cocoa_object, a_level.cocoa_object)
--		end

--	first_object_common_with_array (a_other_array: like current): T
--		do
--			Result :=  {NS_ARRAY_API}first_object_common_with_array(cocoa_object, a_other_array.cocoa_object)
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
--			Result :=  {NS_ARRAY_API}index_of_object(cocoa_object, a_an_object.cocoa_object)
--		end

----	index_of_object_in_range (a_an_object: NS_OBJECT; a_range: NS_RANGE): INTEGER
----		do
----			Result :=  {NS_ARRAY_API}index_of_object_in_range(cocoa_object, a_an_object.cocoa_object, a_range.cocoa_object)
----		end

--	index_of_object_identical_to (a_an_object: NS_OBJECT): INTEGER
--		do
--			Result :=  {NS_ARRAY_API}index_of_object_identical_to(cocoa_object, a_an_object.cocoa_object)
--		end

----	index_of_object_identical_to_in_range (a_an_object: NS_OBJECT; a_range: NS_RANGE): INTEGER
----		do
----			Result :=  {NS_ARRAY_API}index_of_object_identical_to_in_range(cocoa_object, a_an_object.cocoa_object, a_range.cocoa_object)
----		end

--	is_equal_to_array (a_other_array: NS_ARRAY): BOOLEAN
--		do
--			Result :=  {NS_ARRAY_API}is_equal_to_array(cocoa_object, a_other_array.cocoa_object)
--		end

--	last_object: T
--		do
----			Result := {NS_ARRAY_API}last_object(cocoa_object)
--		end

----	object_enumerator : NS_ENUMERATOR
----		do
----			Result := {NS_ARRAY_API}object_enumerator(cocoa_object)
----		end

----	reverse_object_enumerator : NS_ENUMERATOR
----		do
----			Result := {NS_ARRAY_API}reverse_object_enumerator(cocoa_object)
----		end

----	sorted_array_hint : NS_DATA
----		do
----			Result := {NS_ARRAY_API}sorted_array_hint(cocoa_object)
----		end

----	sorted_array_using_selector (a_comparator: SELECTOR): NS_ARRAY
----		do
----			Result := {NS_ARRAY_API}sorted_array_using_selector(cocoa_object, a_comparator)
----		end

----	subarray_with_range (a_range: NS_RANGE): NS_ARRAY
----		do
----			Result := {NS_ARRAY_API}subarray_with_range(cocoa_object, a_range.cocoa_object)
----		end

--	write_to_file_atomically (a_path: NS_STRING; a_use_auxiliary_file: BOOLEAN): BOOLEAN
--		do
--			Result := {NS_ARRAY_API}write_to_file_atomically(cocoa_object, a_path.cocoa_object, a_use_auxiliary_file)
--		end

----	write_to_url_atomically (a_url: NS_URL; a_atomically: BOOLEAN): BOOLEAN
----		do
----			Result := {NS_ARRAY_API}write_to_u_r_l_atomically(cocoa_object, a_url.cocoa_object, a_atomically)
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
----			Result := {NS_ARRAY_API}objects_at_indexes(cocoa_object, a_indexes.cocoa_object)
----		end

--	init_with_objects_count (a_objects: POINTER[NS_OBJECT]; a_cnt: INTEGER): NS_OBJECT
--		do
--			Result := {NS_ARRAY_API}init_with_objects_count(cocoa_object, a_objects, a_cnt.cocoa_object)
--		end

--	init_with_array (a_array: NS_ARRAY): NS_OBJECT
--		do
--			Result := {NS_ARRAY_API}init_with_array(cocoa_object, a_array.cocoa_object)
--		end

--	init_with_array_copy_items (a_array: NS_ARRAY; a_flag: BOOLEAN): NS_OBJECT
--		do
--			Result := {NS_ARRAY_API}init_with_array_copy_items (cocoa_object, a_array.cocoa_object, a_flag)
--		end

--	init_with_contents_of_file (a_path: NS_STRING): NS_OBJECT
--		do
--			Result := {NS_ARRAY_API}init_with_contents_of_file(cocoa_object, a_path.cocoa_object)
--		end

----	init_with_contents_of_u_r_l (a_url: NS_URL): NS_OBJECT
----		do
----			Result := {NS_ARRAY_API}init_with_contents_of_u_r_l(cocoa_object, a_url.cocoa_object)
----		end
end
