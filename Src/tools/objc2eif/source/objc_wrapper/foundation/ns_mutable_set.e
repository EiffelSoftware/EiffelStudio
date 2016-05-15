note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_SET

inherit
	NS_SET
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_capacity_,
	make_with_set_,
	make_with_set__copy_items_,
	make_with_array_,
	make

feature -- NSMutableSet

	add_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_add_object_ (item, a_object__item)
		end

	remove_object_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_remove_object_ (item, a_object__item)
		end

feature {NONE} -- NSMutableSet Externals

	objc_add_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item addObject:$a_object];
			 ]"
		end

	objc_remove_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item removeObject:$a_object];
			 ]"
		end

feature -- NSExtendedMutableSet

	add_objects_from_array_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_add_objects_from_array_ (item, a_array__item)
		end

	intersect_set_ (a_other_set: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			objc_intersect_set_ (item, a_other_set__item)
		end

	minus_set_ (a_other_set: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			objc_minus_set_ (item, a_other_set__item)
		end

	remove_all_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_objects (item)
		end

	union_set_ (a_other_set: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			objc_union_set_ (item, a_other_set__item)
		end

	set_set_ (a_other_set: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			objc_set_set_ (item, a_other_set__item)
		end

feature {NONE} -- NSExtendedMutableSet Externals

	objc_add_objects_from_array_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item addObjectsFromArray:$a_array];
			 ]"
		end

	objc_intersect_set_ (an_item: POINTER; a_other_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item intersectSet:$a_other_set];
			 ]"
		end

	objc_minus_set_ (an_item: POINTER; a_other_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item minusSet:$a_other_set];
			 ]"
		end

	objc_remove_all_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item removeAllObjects];
			 ]"
		end

	objc_union_set_ (an_item: POINTER; a_other_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item unionSet:$a_other_set];
			 ]"
		end

	objc_set_set_ (an_item: POINTER; a_other_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMutableSet *)$an_item setSet:$a_other_set];
			 ]"
		end

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

feature {NONE} -- NSMutableSetCreation Externals

	objc_init_with_capacity_ (an_item: POINTER; a_num_items: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMutableSet *)$an_item initWithCapacity:$a_num_items];
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
				[(NSMutableSet *)$an_item filterUsingPredicate:$a_predicate];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMutableSet"
		end

end
