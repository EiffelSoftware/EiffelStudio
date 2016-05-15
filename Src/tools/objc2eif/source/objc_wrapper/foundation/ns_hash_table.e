note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HASH_TABLE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL
	NS_FAST_ENUMERATION_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_options__capacity_,
	make_with_pointer_functions__capacity_,
	make

feature {NONE} -- Initialization

	make_with_options__capacity_ (a_options: NATURAL_64; a_initial_capacity: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_options__capacity_(allocate_object, a_options, a_initial_capacity))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_pointer_functions__capacity_ (a_functions: detachable NS_POINTER_FUNCTIONS; a_initial_capacity: NATURAL_64)
			-- Initialize `Current'.
		local
			a_functions__item: POINTER
		do
			if attached a_functions as a_functions_attached then
				a_functions__item := a_functions_attached.item
			end
			make_with_pointer (objc_init_with_pointer_functions__capacity_(allocate_object, a_functions__item, a_initial_capacity))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSHashTable Externals

	objc_init_with_options__capacity_ (an_item: POINTER; a_options: NATURAL_64; a_initial_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item initWithOptions:$a_options capacity:$a_initial_capacity];
			 ]"
		end

	objc_init_with_pointer_functions__capacity_ (an_item: POINTER; a_functions: POINTER; a_initial_capacity: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item initWithPointerFunctions:$a_functions capacity:$a_initial_capacity];
			 ]"
		end

	objc_pointer_functions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item pointerFunctions];
			 ]"
		end

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHashTable *)$an_item count];
			 ]"
		end

	objc_member_ (an_item: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item member:$a_object];
			 ]"
		end

	objc_object_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item objectEnumerator];
			 ]"
		end

	objc_add_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHashTable *)$an_item addObject:$a_object];
			 ]"
		end

	objc_remove_object_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHashTable *)$an_item removeObject:$a_object];
			 ]"
		end

	objc_remove_all_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHashTable *)$an_item removeAllObjects];
			 ]"
		end

	objc_all_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item allObjects];
			 ]"
		end

	objc_any_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item anyObject];
			 ]"
		end

	objc_contains_object_ (an_item: POINTER; an_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHashTable *)$an_item containsObject:$an_object];
			 ]"
		end

	objc_intersects_hash_table_ (an_item: POINTER; a_other: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHashTable *)$an_item intersectsHashTable:$a_other];
			 ]"
		end

	objc_is_equal_to_hash_table_ (an_item: POINTER; a_other: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHashTable *)$an_item isEqualToHashTable:$a_other];
			 ]"
		end

	objc_is_subset_of_hash_table_ (an_item: POINTER; a_other: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSHashTable *)$an_item isSubsetOfHashTable:$a_other];
			 ]"
		end

	objc_intersect_hash_table_ (an_item: POINTER; a_other: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHashTable *)$an_item intersectHashTable:$a_other];
			 ]"
		end

	objc_union_hash_table_ (an_item: POINTER; a_other: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHashTable *)$an_item unionHashTable:$a_other];
			 ]"
		end

	objc_minus_hash_table_ (an_item: POINTER; a_other: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSHashTable *)$an_item minusHashTable:$a_other];
			 ]"
		end

	objc_set_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSHashTable *)$an_item setRepresentation];
			 ]"
		end

feature -- NSHashTable

	pointer_functions: detachable NS_POINTER_FUNCTIONS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pointer_functions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pointer_functions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pointer_functions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	member_ (a_object: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_member_ (item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like member_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like member_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	remove_all_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_objects (item)
		end

	all_objects: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_objects (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_objects} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_objects} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	any_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_any_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like any_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like any_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	contains_object_ (an_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			Result := objc_contains_object_ (item, an_object__item)
		end

	intersects_hash_table_ (a_other: detachable NS_HASH_TABLE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			Result := objc_intersects_hash_table_ (item, a_other__item)
		end

	is_equal_to_hash_table_ (a_other: detachable NS_HASH_TABLE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			Result := objc_is_equal_to_hash_table_ (item, a_other__item)
		end

	is_subset_of_hash_table_ (a_other: detachable NS_HASH_TABLE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			Result := objc_is_subset_of_hash_table_ (item, a_other__item)
		end

	intersect_hash_table_ (a_other: detachable NS_HASH_TABLE)
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			objc_intersect_hash_table_ (item, a_other__item)
		end

	union_hash_table_ (a_other: detachable NS_HASH_TABLE)
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			objc_union_hash_table_ (item, a_other__item)
		end

	minus_hash_table_ (a_other: detachable NS_HASH_TABLE)
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			objc_minus_hash_table_ (item, a_other__item)
		end

	set_representation: detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_set_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like set_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like set_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHashTable"
		end

end
