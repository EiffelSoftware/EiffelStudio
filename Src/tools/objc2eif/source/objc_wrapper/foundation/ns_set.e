note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SET

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
	make_with_set_,
	make_with_set__copy_items_,
	make_with_array_,
	make

feature -- NSSet

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

feature {NONE} -- NSSet Externals

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSet *)$an_item count];
			 ]"
		end

	objc_member_ (an_item: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item member:$a_object];
			 ]"
		end

	objc_object_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item objectEnumerator];
			 ]"
		end

feature -- NSExtendedSet

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

	intersects_set_ (a_other_set: detachable NS_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			Result := objc_intersects_set_ (item, a_other_set__item)
		end

	is_equal_to_set_ (a_other_set: detachable NS_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			Result := objc_is_equal_to_set_ (item, a_other_set__item)
		end

	is_subset_of_set_ (a_other_set: detachable NS_SET): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other_set__item: POINTER
		do
			if attached a_other_set as a_other_set_attached then
				a_other_set__item := a_other_set_attached.item
			end
			Result := objc_is_subset_of_set_ (item, a_other_set__item)
		end

	make_objects_perform_selector_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_make_objects_perform_selector_ (item, a_selector__item)
		end

	make_objects_perform_selector__with_object_ (a_selector: detachable OBJC_SELECTOR; a_argument: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_argument__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_argument as a_argument_attached then
				a_argument__item := a_argument_attached.item
			end
			objc_make_objects_perform_selector__with_object_ (item, a_selector__item, a_argument__item)
		end

	set_by_adding_object_ (an_object: detachable NS_OBJECT): detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			result_pointer := objc_set_by_adding_object_ (item, an_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like set_by_adding_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like set_by_adding_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_by_adding_objects_from_set_ (a_other: detachable NS_SET): detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			result_pointer := objc_set_by_adding_objects_from_set_ (item, a_other__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like set_by_adding_objects_from_set_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like set_by_adding_objects_from_set_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_by_adding_objects_from_array_ (a_other: detachable NS_ARRAY): detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			result_pointer := objc_set_by_adding_objects_from_array_ (item, a_other__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like set_by_adding_objects_from_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like set_by_adding_objects_from_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	enumerate_objects_using_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_objects_using_block_ (item, )
--		end

--	enumerate_objects_with_options__using_block_ (a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_objects_with_options__using_block_ (item, a_opts, )
--		end

--	objects_passing_test_ (a_predicate: UNSUPPORTED_TYPE): detachable NS_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_objects_passing_test_ (item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like objects_passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like objects_passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	objects_with_options__passing_test_ (a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): detachable NS_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_objects_with_options__passing_test_ (item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like objects_with_options__passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like objects_with_options__passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSExtendedSet Externals

	objc_all_objects (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item allObjects];
			 ]"
		end

	objc_any_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item anyObject];
			 ]"
		end

	objc_contains_object_ (an_item: POINTER; an_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSet *)$an_item containsObject:$an_object];
			 ]"
		end

	objc_description_with_locale_ (an_item: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item descriptionWithLocale:$a_locale];
			 ]"
		end

	objc_intersects_set_ (an_item: POINTER; a_other_set: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSet *)$an_item intersectsSet:$a_other_set];
			 ]"
		end

	objc_is_equal_to_set_ (an_item: POINTER; a_other_set: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSet *)$an_item isEqualToSet:$a_other_set];
			 ]"
		end

	objc_is_subset_of_set_ (an_item: POINTER; a_other_set: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSSet *)$an_item isSubsetOfSet:$a_other_set];
			 ]"
		end

	objc_make_objects_perform_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSSet *)$an_item makeObjectsPerformSelector:$a_selector];
			 ]"
		end

	objc_make_objects_perform_selector__with_object_ (an_item: POINTER; a_selector: POINTER; a_argument: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSSet *)$an_item makeObjectsPerformSelector:$a_selector withObject:$a_argument];
			 ]"
		end

	objc_set_by_adding_object_ (an_item: POINTER; an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item setByAddingObject:$an_object];
			 ]"
		end

	objc_set_by_adding_objects_from_set_ (an_item: POINTER; a_other: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item setByAddingObjectsFromSet:$a_other];
			 ]"
		end

	objc_set_by_adding_objects_from_array_ (an_item: POINTER; a_other: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item setByAddingObjectsFromArray:$a_other];
			 ]"
		end

--	objc_enumerate_objects_using_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSSet *)$an_item enumerateObjectsUsingBlock:];
--			 ]"
--		end

--	objc_enumerate_objects_with_options__using_block_ (an_item: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSSet *)$an_item enumerateObjectsWithOptions:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_objects_passing_test_ (an_item: POINTER; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSet *)$an_item objectsPassingTest:];
--			 ]"
--		end

--	objc_objects_with_options__passing_test_ (an_item: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSet *)$an_item objectsWithOptions:$a_opts passingTest:];
--			 ]"
--		end

feature {NONE} -- Initialization

--	make_with_objects__count_ (a_objects: UNSUPPORTED_TYPE; a_cnt: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_objects__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			make_with_pointer (objc_init_with_objects__count_(allocate_object, a_objects__item, a_cnt))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_set_ (a_set: detachable NS_SET)
			-- Initialize `Current'.
		local
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			make_with_pointer (objc_init_with_set_(allocate_object, a_set__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_set__copy_items_ (a_set: detachable NS_SET; a_flag: BOOLEAN)
			-- Initialize `Current'.
		local
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			make_with_pointer (objc_init_with_set__copy_items_(allocate_object, a_set__item, a_flag))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_array_ (a_array: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			make_with_pointer (objc_init_with_array_(allocate_object, a_array__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSSetCreation Externals

--	objc_init_with_objects__count_ (an_item: POINTER; a_objects: UNSUPPORTED_TYPE; a_cnt: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSet *)$an_item initWithObjects: count:$a_cnt];
--			 ]"
--		end

	objc_init_with_set_ (an_item: POINTER; a_set: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item initWithSet:$a_set];
			 ]"
		end

	objc_init_with_set__copy_items_ (an_item: POINTER; a_set: POINTER; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item initWithSet:$a_set copyItems:$a_flag];
			 ]"
		end

	objc_init_with_array_ (an_item: POINTER; a_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item initWithArray:$a_array];
			 ]"
		end

feature -- NSSortDescriptorSorting

	sorted_array_using_descriptors_ (a_sort_descriptors: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_sort_descriptors__item: POINTER
		do
			if attached a_sort_descriptors as a_sort_descriptors_attached then
				a_sort_descriptors__item := a_sort_descriptors_attached.item
			end
			result_pointer := objc_sorted_array_using_descriptors_ (item, a_sort_descriptors__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sorted_array_using_descriptors_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sorted_array_using_descriptors_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSSortDescriptorSorting Externals

	objc_sorted_array_using_descriptors_ (an_item: POINTER; a_sort_descriptors: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item sortedArrayUsingDescriptors:$a_sort_descriptors];
			 ]"
		end

feature -- NSPredicateSupport

	filtered_set_using_predicate_ (a_predicate: detachable NS_PREDICATE): detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			result_pointer := objc_filtered_set_using_predicate_ (item, a_predicate__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filtered_set_using_predicate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filtered_set_using_predicate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPredicateSupport Externals

	objc_filtered_set_using_predicate_ (an_item: POINTER; a_predicate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSet *)$an_item filteredSetUsingPredicate:$a_predicate];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSet"
		end

end
