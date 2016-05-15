note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_ARRAY

inherit
	NS_ARRAY
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make_with_array_,
	make_with_array__copy_items_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make

feature -- NSMutableArray

	add_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_add_object_ (item, an_object__item)
		end

	insert_object__at_index_ (an_object: detachable NS_OBJECT; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_insert_object__at_index_ (item, an_object__item, a_index)
		end

	remove_last_object
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_last_object (item)
		end

	remove_object_at_index_ (a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_object_at_index_ (item, a_index)
		end

	replace_object_at_index__with_object_ (a_index: NATURAL_64; an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_replace_object_at_index__with_object_ (item, a_index, an_object__item)
		end

feature {NONE} -- NSMutableArray Externals

	objc_add_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item addObject:$an_object];
			 ]"
		end

	objc_insert_object__at_index_ (an_item: POINTER; an_object: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item insertObject:$an_object atIndex:$a_index];
			 ]"
		end

	objc_remove_last_object (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeLastObject];
			 ]"
		end

	objc_remove_object_at_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObjectAtIndex:$a_index];
			 ]"
		end

	objc_replace_object_at_index__with_object_ (an_item: POINTER; a_index: NATURAL_64; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item replaceObjectAtIndex:$a_index withObject:$an_object];
			 ]"
		end

feature -- NSExtendedMutableArray

	add_objects_from_array_ (a_other_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			objc_add_objects_from_array_ (item, a_other_array__item)
		end

	exchange_object_at_index__with_object_at_index_ (a_idx1: NATURAL_64; a_idx2: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_exchange_object_at_index__with_object_at_index_ (item, a_idx1, a_idx2)
		end

	remove_all_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_objects (item)
		end

	remove_object__in_range_ (an_object: detachable NS_OBJECT; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_remove_object__in_range_ (item, an_object__item, a_range.item)
		end

	remove_object_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_remove_object_ (item, an_object__item)
		end

	remove_object_identical_to__in_range_ (an_object: detachable NS_OBJECT; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_remove_object_identical_to__in_range_ (item, an_object__item, a_range.item)
		end

	remove_object_identical_to_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_remove_object_identical_to_ (item, an_object__item)
		end

	remove_objects_in_array_ (a_other_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			objc_remove_objects_in_array_ (item, a_other_array__item)
		end

	remove_objects_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_objects_in_range_ (item, a_range.item)
		end

	replace_objects_in_range__with_objects_from_array__range_ (a_range: NS_RANGE; a_other_array: detachable NS_ARRAY; a_other_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			objc_replace_objects_in_range__with_objects_from_array__range_ (item, a_range.item, a_other_array__item, a_other_range.item)
		end

	replace_objects_in_range__with_objects_from_array_ (a_range: NS_RANGE; a_other_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			objc_replace_objects_in_range__with_objects_from_array_ (item, a_range.item, a_other_array__item)
		end

	set_array_ (a_other_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			objc_set_array_ (item, a_other_array__item)
		end

--	sort_using_function__context_ (a_compare: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_compare__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_compare as a_compare_attached then
--				a_compare__item := a_compare_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			objc_sort_using_function__context_ (item, a_compare__item, a_context__item)
--		end

	sort_using_selector_ (a_comparator: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_comparator__item: POINTER
		do
			if attached a_comparator as a_comparator_attached then
				a_comparator__item := a_comparator_attached.item
			end
			objc_sort_using_selector_ (item, a_comparator__item)
		end

	insert_objects__at_indexes_ (a_objects: detachable NS_ARRAY; a_indexes: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
			a_indexes__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_insert_objects__at_indexes_ (item, a_objects__item, a_indexes__item)
		end

	remove_objects_at_indexes_ (a_indexes: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_remove_objects_at_indexes_ (item, a_indexes__item)
		end

	replace_objects_at_indexes__with_objects_ (a_indexes: detachable NS_INDEX_SET; a_objects: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
			a_objects__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			objc_replace_objects_at_indexes__with_objects_ (item, a_indexes__item, a_objects__item)
		end

--	sort_using_comparator_ (a_cmptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_sort_using_comparator_ (item, )
--		end

--	sort_with_options__using_comparator_ (a_opts: NATURAL_64; a_cmptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_sort_with_options__using_comparator_ (item, a_opts, )
--		end

feature {NONE} -- NSExtendedMutableArray Externals

	objc_add_objects_from_array_ (an_item: POINTER; a_other_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item addObjectsFromArray:$a_other_array];
			 ]"
		end

	objc_exchange_object_at_index__with_object_at_index_ (an_item: POINTER; a_idx1: NATURAL_64; a_idx2: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item exchangeObjectAtIndex:$a_idx1 withObjectAtIndex:$a_idx2];
			 ]"
		end

	objc_remove_all_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeAllObjects];
			 ]"
		end

	objc_remove_object__in_range_ (an_item: POINTER; an_object: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObject:$an_object inRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_remove_object_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObject:$an_object];
			 ]"
		end

	objc_remove_object_identical_to__in_range_ (an_item: POINTER; an_object: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObjectIdenticalTo:$an_object inRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_remove_object_identical_to_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObjectIdenticalTo:$an_object];
			 ]"
		end

	objc_remove_objects_in_array_ (an_item: POINTER; a_other_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObjectsInArray:$a_other_array];
			 ]"
		end

	objc_remove_objects_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObjectsInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_replace_objects_in_range__with_objects_from_array__range_ (an_item: POINTER; a_range: POINTER; a_other_array: POINTER; a_other_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item replaceObjectsInRange:*((NSRange *)$a_range) withObjectsFromArray:$a_other_array range:*((NSRange *)$a_other_range)];
			 ]"
		end

	objc_replace_objects_in_range__with_objects_from_array_ (an_item: POINTER; a_range: POINTER; a_other_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item replaceObjectsInRange:*((NSRange *)$a_range) withObjectsFromArray:$a_other_array];
			 ]"
		end

	objc_set_array_ (an_item: POINTER; a_other_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item setArray:$a_other_array];
			 ]"
		end

--	objc_sort_using_function__context_ (an_item: POINTER; a_compare: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSMutableArray *)$an_item sortUsingFunction: context:];
--			 ]"
--		end

	objc_sort_using_selector_ (an_item: POINTER; a_comparator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item sortUsingSelector:$a_comparator];
			 ]"
		end

	objc_insert_objects__at_indexes_ (an_item: POINTER; a_objects: POINTER; a_indexes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item insertObjects:$a_objects atIndexes:$a_indexes];
			 ]"
		end

	objc_remove_objects_at_indexes_ (an_item: POINTER; a_indexes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item removeObjectsAtIndexes:$a_indexes];
			 ]"
		end

	objc_replace_objects_at_indexes__with_objects_ (an_item: POINTER; a_indexes: POINTER; a_objects: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item replaceObjectsAtIndexes:$a_indexes withObjects:$a_objects];
			 ]"
		end

--	objc_sort_using_comparator_ (an_item: POINTER; a_cmptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSMutableArray *)$an_item sortUsingComparator:];
--			 ]"
--		end

--	objc_sort_with_options__using_comparator_ (an_item: POINTER; a_opts: NATURAL_64; a_cmptr: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSMutableArray *)$an_item sortWithOptions:$a_opts usingComparator:];
--			 ]"
--		end

feature {NONE} -- Initialization

	make_with_capacity_ (a_num_items: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_capacity_(allocate_object, a_num_items))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSMutableArrayCreation Externals

	objc_init_with_capacity_ (an_item: POINTER; a_num_items: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableArray *)$an_item initWithCapacity:$a_num_items];
			 ]"
		end

feature -- NSSortDescriptorSorting

	sort_using_descriptors_ (a_sort_descriptors: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_sort_descriptors__item: POINTER
		do
			if attached a_sort_descriptors as a_sort_descriptors_attached then
				a_sort_descriptors__item := a_sort_descriptors_attached.item
			end
			objc_sort_using_descriptors_ (item, a_sort_descriptors__item)
		end

feature {NONE} -- NSSortDescriptorSorting Externals

	objc_sort_using_descriptors_ (an_item: POINTER; a_sort_descriptors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item sortUsingDescriptors:$a_sort_descriptors];
			 ]"
		end

feature -- NSPredicateSupport

	filter_using_predicate_ (a_predicate: detachable NS_PREDICATE)
			-- Auto generated Objective-C wrapper.
		local
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			objc_filter_using_predicate_ (item, a_predicate__item)
		end

feature {NONE} -- NSPredicateSupport Externals

	objc_filter_using_predicate_ (an_item: POINTER; a_predicate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableArray *)$an_item filterUsingPredicate:$a_predicate];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableArray"
		end

end
