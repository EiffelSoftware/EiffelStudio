note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INDEX_SET

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
	make,
	make_with_index_,
	make_with_indexes_in_range_,
	make_with_index_set_

feature {NONE} -- Initialization

	make_with_index_ (a_value: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_index_(allocate_object, a_value))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_indexes_in_range_ (a_range: NS_RANGE)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_indexes_in_range_(allocate_object, a_range.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_index_set_ (a_index_set: detachable NS_INDEX_SET)
			-- Initialize `Current'.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			make_with_pointer (objc_init_with_index_set_(allocate_object, a_index_set__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSIndexSet Externals

	objc_init_with_index_ (an_item: POINTER; a_value: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexSet *)$an_item initWithIndex:$a_value];
			 ]"
		end

	objc_init_with_indexes_in_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexSet *)$an_item initWithIndexesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_init_with_index_set_ (an_item: POINTER; a_index_set: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSIndexSet *)$an_item initWithIndexSet:$a_index_set];
			 ]"
		end

	objc_is_equal_to_index_set_ (an_item: POINTER; a_index_set: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item isEqualToIndexSet:$a_index_set];
			 ]"
		end

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item count];
			 ]"
		end

	objc_first_index (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item firstIndex];
			 ]"
		end

	objc_last_index (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item lastIndex];
			 ]"
		end

	objc_index_greater_than_index_ (an_item: POINTER; a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item indexGreaterThanIndex:$a_value];
			 ]"
		end

	objc_index_less_than_index_ (an_item: POINTER; a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item indexLessThanIndex:$a_value];
			 ]"
		end

	objc_index_greater_than_or_equal_to_index_ (an_item: POINTER; a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item indexGreaterThanOrEqualToIndex:$a_value];
			 ]"
		end

	objc_index_less_than_or_equal_to_index_ (an_item: POINTER; a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item indexLessThanOrEqualToIndex:$a_value];
			 ]"
		end

--	objc_get_indexes__max_count__in_index_range_ (an_item: POINTER; a_index_buffer: UNSUPPORTED_TYPE; a_buffer_size: NATURAL_64; a_range: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSIndexSet *)$an_item getIndexes: maxCount:$a_buffer_size inIndexRange:];
--			 ]"
--		end

	objc_count_of_indexes_in_range_ (an_item: POINTER; a_range: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item countOfIndexesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_contains_index_ (an_item: POINTER; a_value: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item containsIndex:$a_value];
			 ]"
		end

	objc_contains_indexes_in_range_ (an_item: POINTER; a_range: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item containsIndexesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_contains_indexes_ (an_item: POINTER; a_index_set: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item containsIndexes:$a_index_set];
			 ]"
		end

	objc_intersects_indexes_in_range_ (an_item: POINTER; a_range: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSIndexSet *)$an_item intersectsIndexesInRange:*((NSRange *)$a_range)];
			 ]"
		end

--	objc_enumerate_indexes_using_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSIndexSet *)$an_item enumerateIndexesUsingBlock:];
--			 ]"
--		end

--	objc_enumerate_indexes_with_options__using_block_ (an_item: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSIndexSet *)$an_item enumerateIndexesWithOptions:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_enumerate_indexes_in_range__options__using_block_ (an_item: POINTER; a_range: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSIndexSet *)$an_item enumerateIndexesInRange:*((NSRange *)$a_range) options:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_index_passing_test_ (an_item: POINTER; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSIndexSet *)$an_item indexPassingTest:];
--			 ]"
--		end

--	objc_index_with_options__passing_test_ (an_item: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSIndexSet *)$an_item indexWithOptions:$a_opts passingTest:];
--			 ]"
--		end

--	objc_index_in_range__options__passing_test_ (an_item: POINTER; a_range: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSIndexSet *)$an_item indexInRange:*((NSRange *)$a_range) options:$a_opts passingTest:];
--			 ]"
--		end

--	objc_indexes_passing_test_ (an_item: POINTER; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSIndexSet *)$an_item indexesPassingTest:];
--			 ]"
--		end

--	objc_indexes_with_options__passing_test_ (an_item: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSIndexSet *)$an_item indexesWithOptions:$a_opts passingTest:];
--			 ]"
--		end

--	objc_indexes_in_range__options__passing_test_ (an_item: POINTER; a_range: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSIndexSet *)$an_item indexesInRange:*((NSRange *)$a_range) options:$a_opts passingTest:];
--			 ]"
--		end

feature -- NSIndexSet

	is_equal_to_index_set_ (a_index_set: detachable NS_INDEX_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			Result := objc_is_equal_to_index_set_ (item, a_index_set__item)
		end

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	first_index: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_first_index (item)
		end

	last_index: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_last_index (item)
		end

	index_greater_than_index_ (a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_greater_than_index_ (item, a_value)
		end

	index_less_than_index_ (a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_less_than_index_ (item, a_value)
		end

	index_greater_than_or_equal_to_index_ (a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_greater_than_or_equal_to_index_ (item, a_value)
		end

	index_less_than_or_equal_to_index_ (a_value: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_less_than_or_equal_to_index_ (item, a_value)
		end

--	get_indexes__max_count__in_index_range_ (a_index_buffer: UNSUPPORTED_TYPE; a_buffer_size: NATURAL_64; a_range: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_index_buffer__item: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_index_buffer as a_index_buffer_attached then
--				a_index_buffer__item := a_index_buffer_attached.item
--			end
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			Result := objc_get_indexes__max_count__in_index_range_ (item, a_index_buffer__item, a_buffer_size, a_range__item)
--		end

	count_of_indexes_in_range_ (a_range: NS_RANGE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count_of_indexes_in_range_ (item, a_range.item)
		end

	contains_index_ (a_value: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contains_index_ (item, a_value)
		end

	contains_indexes_in_range_ (a_range: NS_RANGE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contains_indexes_in_range_ (item, a_range.item)
		end

	contains_indexes_ (a_index_set: detachable NS_INDEX_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			Result := objc_contains_indexes_ (item, a_index_set__item)
		end

	intersects_indexes_in_range_ (a_range: NS_RANGE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_intersects_indexes_in_range_ (item, a_range.item)
		end

--	enumerate_indexes_using_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_indexes_using_block_ (item, )
--		end

--	enumerate_indexes_with_options__using_block_ (a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_indexes_with_options__using_block_ (item, a_opts, )
--		end

--	enumerate_indexes_in_range__options__using_block_ (a_range: NS_RANGE; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_indexes_in_range__options__using_block_ (item, a_range.item, a_opts, )
--		end

--	index_passing_test_ (a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_index_passing_test_ (item, )
--		end

--	index_with_options__passing_test_ (a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_index_with_options__passing_test_ (item, a_opts, )
--		end

--	index_in_range__options__passing_test_ (a_range: NS_RANGE; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_index_in_range__options__passing_test_ (item, a_range.item, a_opts, )
--		end

--	indexes_passing_test_ (a_predicate: UNSUPPORTED_TYPE): detachable NS_INDEX_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_indexes_passing_test_ (item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indexes_passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indexes_passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	indexes_with_options__passing_test_ (a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): detachable NS_INDEX_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_indexes_with_options__passing_test_ (item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indexes_with_options__passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indexes_with_options__passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	indexes_in_range__options__passing_test_ (a_range: NS_RANGE; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): detachable NS_INDEX_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_indexes_in_range__options__passing_test_ (item, a_range.item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indexes_in_range__options__passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indexes_in_range__options__passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSIndexSet"
		end

end
