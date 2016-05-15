note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_INDEX_SET

inherit
	NS_INDEX_SET
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make,
	make_with_index_,
	make_with_indexes_in_range_,
	make_with_index_set_

feature -- NSMutableIndexSet

	add_indexes_ (a_index_set: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			objc_add_indexes_ (item, a_index_set__item)
		end

	remove_indexes_ (a_index_set: detachable NS_INDEX_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_index_set__item: POINTER
		do
			if attached a_index_set as a_index_set_attached then
				a_index_set__item := a_index_set_attached.item
			end
			objc_remove_indexes_ (item, a_index_set__item)
		end

	remove_all_indexes
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_indexes (item)
		end

	add_index_ (a_value: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_index_ (item, a_value)
		end

	remove_index_ (a_value: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_index_ (item, a_value)
		end

	add_indexes_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_indexes_in_range_ (item, a_range.item)
		end

	remove_indexes_in_range_ (a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_indexes_in_range_ (item, a_range.item)
		end

	shift_indexes_starting_at_index__by_ (a_index: NATURAL_64; a_delta: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_shift_indexes_starting_at_index__by_ (item, a_index, a_delta)
		end

feature {NONE} -- NSMutableIndexSet Externals

	objc_add_indexes_ (an_item: POINTER; a_index_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item addIndexes:$a_index_set];
			 ]"
		end

	objc_remove_indexes_ (an_item: POINTER; a_index_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item removeIndexes:$a_index_set];
			 ]"
		end

	objc_remove_all_indexes (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item removeAllIndexes];
			 ]"
		end

	objc_add_index_ (an_item: POINTER; a_value: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item addIndex:$a_value];
			 ]"
		end

	objc_remove_index_ (an_item: POINTER; a_value: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item removeIndex:$a_value];
			 ]"
		end

	objc_add_indexes_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item addIndexesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_remove_indexes_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item removeIndexesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_shift_indexes_starting_at_index__by_ (an_item: POINTER; a_index: NATURAL_64; a_delta: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableIndexSet *)$an_item shiftIndexesStartingAtIndex:$a_index by:$a_delta];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableIndexSet"
		end

end
