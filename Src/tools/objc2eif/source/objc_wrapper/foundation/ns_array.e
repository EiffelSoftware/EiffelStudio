note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ARRAY

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
	make_with_array_,
	make_with_array__copy_items_,
	make_with_contents_of_file_,
	make_with_contents_of_ur_l_,
	make

feature -- NSArray

	count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count (item)
		end

	object_at_index_ (a_index: NATURAL_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSArray Externals

	objc_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item count];
			 ]"
		end

	objc_object_at_index_ (an_item: POINTER; a_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item objectAtIndex:$a_index];
			 ]"
		end

feature -- NSExtendedArray

	array_by_adding_object_ (an_object: detachable NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			result_pointer := objc_array_by_adding_object_ (item, an_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like array_by_adding_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like array_by_adding_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	array_by_adding_objects_from_array_ (a_other_array: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			result_pointer := objc_array_by_adding_objects_from_array_ (item, a_other_array__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like array_by_adding_objects_from_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like array_by_adding_objects_from_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	components_joined_by_string_ (a_separator: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_separator__item: POINTER
		do
			if attached a_separator as a_separator_attached then
				a_separator__item := a_separator_attached.item
			end
			result_pointer := objc_components_joined_by_string_ (item, a_separator__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components_joined_by_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components_joined_by_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	first_object_common_with_array_ (a_other_array: detachable NS_ARRAY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			result_pointer := objc_first_object_common_with_array_ (item, a_other_array__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like first_object_common_with_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like first_object_common_with_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_objects__range_ (a_objects: UNSUPPORTED_TYPE; a_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_objects__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			objc_get_objects__range_ (item, a_objects__item, a_range.item)
--		end

	index_of_object_ (an_object: detachable NS_OBJECT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			Result := objc_index_of_object_ (item, an_object__item)
		end

	index_of_object__in_range_ (an_object: detachable NS_OBJECT; a_range: NS_RANGE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			Result := objc_index_of_object__in_range_ (item, an_object__item, a_range.item)
		end

	index_of_object_identical_to_ (an_object: detachable NS_OBJECT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			Result := objc_index_of_object_identical_to_ (item, an_object__item)
		end

	index_of_object_identical_to__in_range_ (an_object: detachable NS_OBJECT; a_range: NS_RANGE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			Result := objc_index_of_object_identical_to__in_range_ (item, an_object__item, a_range.item)
		end

	is_equal_to_array_ (a_other_array: detachable NS_ARRAY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other_array__item: POINTER
		do
			if attached a_other_array as a_other_array_attached then
				a_other_array__item := a_other_array_attached.item
			end
			Result := objc_is_equal_to_array_ (item, a_other_array__item)
		end

	last_object: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_last_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like last_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like last_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	reverse_object_enumerator: detachable NS_ENUMERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_reverse_object_enumerator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like reverse_object_enumerator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like reverse_object_enumerator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	sorted_array_hint: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sorted_array_hint (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sorted_array_hint} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sorted_array_hint} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	sorted_array_using_function__context_ (a_comparator: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_comparator__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_comparator as a_comparator_attached then
--				a_comparator__item := a_comparator_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			result_pointer := objc_sorted_array_using_function__context_ (item, a_comparator__item, a_context__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like sorted_array_using_function__context_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like sorted_array_using_function__context_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	sorted_array_using_function__context__hint_ (a_comparator: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE; a_hint: detachable NS_DATA): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_comparator__item: POINTER
--			a_context__item: POINTER
--			a_hint__item: POINTER
--		do
--			if attached a_comparator as a_comparator_attached then
--				a_comparator__item := a_comparator_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			if attached a_hint as a_hint_attached then
--				a_hint__item := a_hint_attached.item
--			end
--			result_pointer := objc_sorted_array_using_function__context__hint_ (item, a_comparator__item, a_context__item, a_hint__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like sorted_array_using_function__context__hint_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like sorted_array_using_function__context__hint_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	sorted_array_using_selector_ (a_comparator: detachable OBJC_SELECTOR): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_comparator__item: POINTER
		do
			if attached a_comparator as a_comparator_attached then
				a_comparator__item := a_comparator_attached.item
			end
			result_pointer := objc_sorted_array_using_selector_ (item, a_comparator__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sorted_array_using_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sorted_array_using_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	subarray_with_range_ (a_range: NS_RANGE): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subarray_with_range_ (item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subarray_with_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subarray_with_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	objects_at_indexes_ (a_indexes: detachable NS_INDEX_SET): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			result_pointer := objc_objects_at_indexes_ (item, a_indexes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like objects_at_indexes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like objects_at_indexes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

--	enumerate_objects_at_indexes__options__using_block_ (a_s: detachable NS_INDEX_SET; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_s__item: POINTER
--		do
--			if attached a_s as a_s_attached then
--				a_s__item := a_s_attached.item
--			end
--			objc_enumerate_objects_at_indexes__options__using_block_ (item, a_s__item, a_opts, )
--		end

--	index_of_object_passing_test_ (a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_index_of_object_passing_test_ (item, )
--		end

--	index_of_object_with_options__passing_test_ (a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_index_of_object_with_options__passing_test_ (item, a_opts, )
--		end

--	index_of_object_at_indexes__options__passing_test_ (a_s: detachable NS_INDEX_SET; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_s__item: POINTER
--		do
--			if attached a_s as a_s_attached then
--				a_s__item := a_s_attached.item
--			end
--			Result := objc_index_of_object_at_indexes__options__passing_test_ (item, a_s__item, a_opts, )
--		end

--	indexes_of_objects_passing_test_ (a_predicate: UNSUPPORTED_TYPE): detachable NS_INDEX_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_indexes_of_objects_passing_test_ (item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indexes_of_objects_passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indexes_of_objects_passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	indexes_of_objects_with_options__passing_test_ (a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): detachable NS_INDEX_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_indexes_of_objects_with_options__passing_test_ (item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indexes_of_objects_with_options__passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indexes_of_objects_with_options__passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	indexes_of_objects_at_indexes__options__passing_test_ (a_s: detachable NS_INDEX_SET; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): detachable NS_INDEX_SET
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_s__item: POINTER
--		do
--			if attached a_s as a_s_attached then
--				a_s__item := a_s_attached.item
--			end
--			result_pointer := objc_indexes_of_objects_at_indexes__options__passing_test_ (item, a_s__item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like indexes_of_objects_at_indexes__options__passing_test_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like indexes_of_objects_at_indexes__options__passing_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	sorted_array_using_comparator_ (a_cmptr: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_sorted_array_using_comparator_ (item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like sorted_array_using_comparator_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like sorted_array_using_comparator_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	sorted_array_with_options__using_comparator_ (a_opts: NATURAL_64; a_cmptr: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_sorted_array_with_options__using_comparator_ (item, a_opts, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like sorted_array_with_options__using_comparator_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like sorted_array_with_options__using_comparator_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	index_of_object__in_sorted_range__options__using_comparator_ (a_obj: detachable NS_OBJECT; a_r: NS_RANGE; a_opts: NATURAL_64; a_cmp: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_obj__item: POINTER
--		do
--			if attached a_obj as a_obj_attached then
--				a_obj__item := a_obj_attached.item
--			end
--			Result := objc_index_of_object__in_sorted_range__options__using_comparator_ (item, a_obj__item, a_r.item, a_opts, )
--		end

feature {NONE} -- NSExtendedArray Externals

	objc_array_by_adding_object_ (an_item: POINTER; an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item arrayByAddingObject:$an_object];
			 ]"
		end

	objc_array_by_adding_objects_from_array_ (an_item: POINTER; a_other_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item arrayByAddingObjectsFromArray:$a_other_array];
			 ]"
		end

	objc_components_joined_by_string_ (an_item: POINTER; a_separator: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item componentsJoinedByString:$a_separator];
			 ]"
		end

	objc_contains_object_ (an_item: POINTER; an_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item containsObject:$an_object];
			 ]"
		end

	objc_description_with_locale_ (an_item: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item descriptionWithLocale:$a_locale];
			 ]"
		end

	objc_description_with_locale__indent_ (an_item: POINTER; a_locale: POINTER; a_level: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item descriptionWithLocale:$a_locale indent:$a_level];
			 ]"
		end

	objc_first_object_common_with_array_ (an_item: POINTER; a_other_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item firstObjectCommonWithArray:$a_other_array];
			 ]"
		end

--	objc_get_objects__range_ (an_item: POINTER; a_objects: UNSUPPORTED_TYPE; a_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSArray *)$an_item getObjects: range:*((NSRange *)$a_range)];
--			 ]"
--		end

	objc_index_of_object_ (an_item: POINTER; an_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item indexOfObject:$an_object];
			 ]"
		end

	objc_index_of_object__in_range_ (an_item: POINTER; an_object: POINTER; a_range: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item indexOfObject:$an_object inRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_index_of_object_identical_to_ (an_item: POINTER; an_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item indexOfObjectIdenticalTo:$an_object];
			 ]"
		end

	objc_index_of_object_identical_to__in_range_ (an_item: POINTER; an_object: POINTER; a_range: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item indexOfObjectIdenticalTo:$an_object inRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_is_equal_to_array_ (an_item: POINTER; a_other_array: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item isEqualToArray:$a_other_array];
			 ]"
		end

	objc_last_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item lastObject];
			 ]"
		end

	objc_object_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item objectEnumerator];
			 ]"
		end

	objc_reverse_object_enumerator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item reverseObjectEnumerator];
			 ]"
		end

	objc_sorted_array_hint (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayHint];
			 ]"
		end

--	objc_sorted_array_using_function__context_ (an_item: POINTER; a_comparator: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayUsingFunction: context:];
--			 ]"
--		end

--	objc_sorted_array_using_function__context__hint_ (an_item: POINTER; a_comparator: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE; a_hint: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayUsingFunction: context: hint:$a_hint];
--			 ]"
--		end

	objc_sorted_array_using_selector_ (an_item: POINTER; a_comparator: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayUsingSelector:$a_comparator];
			 ]"
		end

	objc_subarray_with_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item subarrayWithRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_write_to_file__atomically_ (an_item: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item writeToFile:$a_path atomically:$a_use_auxiliary_file];
			 ]"
		end

	objc_write_to_ur_l__atomically_ (an_item: POINTER; a_url: POINTER; a_atomically: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSArray *)$an_item writeToURL:$a_url atomically:$a_atomically];
			 ]"
		end

	objc_make_objects_perform_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSArray *)$an_item makeObjectsPerformSelector:$a_selector];
			 ]"
		end

	objc_make_objects_perform_selector__with_object_ (an_item: POINTER; a_selector: POINTER; a_argument: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSArray *)$an_item makeObjectsPerformSelector:$a_selector withObject:$a_argument];
			 ]"
		end

	objc_objects_at_indexes_ (an_item: POINTER; a_indexes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item objectsAtIndexes:$a_indexes];
			 ]"
		end

--	objc_enumerate_objects_using_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSArray *)$an_item enumerateObjectsUsingBlock:];
--			 ]"
--		end

--	objc_enumerate_objects_with_options__using_block_ (an_item: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSArray *)$an_item enumerateObjectsWithOptions:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_enumerate_objects_at_indexes__options__using_block_ (an_item: POINTER; a_s: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSArray *)$an_item enumerateObjectsAtIndexes:$a_s options:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_index_of_object_passing_test_ (an_item: POINTER; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSArray *)$an_item indexOfObjectPassingTest:];
--			 ]"
--		end

--	objc_index_of_object_with_options__passing_test_ (an_item: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSArray *)$an_item indexOfObjectWithOptions:$a_opts passingTest:];
--			 ]"
--		end

--	objc_index_of_object_at_indexes__options__passing_test_ (an_item: POINTER; a_s: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSArray *)$an_item indexOfObjectAtIndexes:$a_s options:$a_opts passingTest:];
--			 ]"
--		end

--	objc_indexes_of_objects_passing_test_ (an_item: POINTER; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item indexesOfObjectsPassingTest:];
--			 ]"
--		end

--	objc_indexes_of_objects_with_options__passing_test_ (an_item: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item indexesOfObjectsWithOptions:$a_opts passingTest:];
--			 ]"
--		end

--	objc_indexes_of_objects_at_indexes__options__passing_test_ (an_item: POINTER; a_s: POINTER; a_opts: NATURAL_64; a_predicate: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item indexesOfObjectsAtIndexes:$a_s options:$a_opts passingTest:];
--			 ]"
--		end

--	objc_sorted_array_using_comparator_ (an_item: POINTER; a_cmptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayUsingComparator:];
--			 ]"
--		end

--	objc_sorted_array_with_options__using_comparator_ (an_item: POINTER; a_opts: NATURAL_64; a_cmptr: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayWithOptions:$a_opts usingComparator:];
--			 ]"
--		end

--	objc_index_of_object__in_sorted_range__options__using_comparator_ (an_item: POINTER; a_obj: POINTER; a_r: POINTER; a_opts: NATURAL_64; a_cmp: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSArray *)$an_item indexOfObject:$a_obj inSortedRange:*((NSRange *)$a_r) options:$a_opts usingComparator:];
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

	make_with_array__copy_items_ (a_array: detachable NS_ARRAY; a_flag: BOOLEAN)
			-- Initialize `Current'.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			make_with_pointer (objc_init_with_array__copy_items_(allocate_object, a_array__item, a_flag))
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

feature {NONE} -- NSArrayCreation Externals

--	objc_init_with_objects__count_ (an_item: POINTER; a_objects: UNSUPPORTED_TYPE; a_cnt: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSArray *)$an_item initWithObjects: count:$a_cnt];
--			 ]"
--		end

	objc_init_with_array_ (an_item: POINTER; a_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item initWithArray:$a_array];
			 ]"
		end

	objc_init_with_array__copy_items_ (an_item: POINTER; a_array: POINTER; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item initWithArray:$a_array copyItems:$a_flag];
			 ]"
		end

	objc_init_with_contents_of_file_ (an_item: POINTER; a_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item initWithContentsOfFile:$a_path];
			 ]"
		end

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

feature -- NSDeprecated

--	get_objects_ (a_objects: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_objects__item: POINTER
--		do
--			if attached a_objects as a_objects_attached then
--				a_objects__item := a_objects_attached.item
--			end
--			objc_get_objects_ (item, a_objects__item)
--		end

feature {NONE} -- NSDeprecated Externals

--	objc_get_objects_ (an_item: POINTER; a_objects: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSArray *)$an_item getObjects:];
--			 ]"
--		end

feature -- NSArrayPathExtensions

	paths_matching_extensions_ (a_filter_types: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_filter_types__item: POINTER
		do
			if attached a_filter_types as a_filter_types_attached then
				a_filter_types__item := a_filter_types_attached.item
			end
			result_pointer := objc_paths_matching_extensions_ (item, a_filter_types__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like paths_matching_extensions_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like paths_matching_extensions_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSArrayPathExtensions Externals

	objc_paths_matching_extensions_ (an_item: POINTER; a_filter_types: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item pathsMatchingExtensions:$a_filter_types];
			 ]"
		end

feature -- NSKeyValueObserverRegistration

--	add_observer__to_objects_at_indexes__for_key_path__options__context_ (a_observer: detachable NS_OBJECT; a_indexes: detachable NS_INDEX_SET; a_key_path: detachable NS_STRING; a_options: NATURAL_64; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_observer__item: POINTER
--			a_indexes__item: POINTER
--			a_key_path__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_observer as a_observer_attached then
--				a_observer__item := a_observer_attached.item
--			end
--			if attached a_indexes as a_indexes_attached then
--				a_indexes__item := a_indexes_attached.item
--			end
--			if attached a_key_path as a_key_path_attached then
--				a_key_path__item := a_key_path_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			objc_add_observer__to_objects_at_indexes__for_key_path__options__context_ (item, a_observer__item, a_indexes__item, a_key_path__item, a_options, a_context__item)
--		end

	remove_observer__from_objects_at_indexes__for_key_path_ (a_observer: detachable NS_OBJECT; a_indexes: detachable NS_INDEX_SET; a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_observer__item: POINTER
			a_indexes__item: POINTER
			a_key_path__item: POINTER
		do
			if attached a_observer as a_observer_attached then
				a_observer__item := a_observer_attached.item
			end
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_remove_observer__from_objects_at_indexes__for_key_path_ (item, a_observer__item, a_indexes__item, a_key_path__item)
		end

feature {NONE} -- NSKeyValueObserverRegistration Externals

--	objc_add_observer__to_objects_at_indexes__for_key_path__options__context_ (an_item: POINTER; a_observer: POINTER; a_indexes: POINTER; a_key_path: POINTER; a_options: NATURAL_64; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSArray *)$an_item addObserver:$a_observer toObjectsAtIndexes:$a_indexes forKeyPath:$a_key_path options:$a_options context:];
--			 ]"
--		end

	objc_remove_observer__from_objects_at_indexes__for_key_path_ (an_item: POINTER; a_observer: POINTER; a_indexes: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSArray *)$an_item removeObserver:$a_observer fromObjectsAtIndexes:$a_indexes forKeyPath:$a_key_path];
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
				return (EIF_POINTER)[(NSArray *)$an_item sortedArrayUsingDescriptors:$a_sort_descriptors];
			 ]"
		end

feature -- NSPredicateSupport

	filtered_array_using_predicate_ (a_predicate: detachable NS_PREDICATE): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			result_pointer := objc_filtered_array_using_predicate_ (item, a_predicate__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like filtered_array_using_predicate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like filtered_array_using_predicate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPredicateSupport Externals

	objc_filtered_array_using_predicate_ (an_item: POINTER; a_predicate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSArray *)$an_item filteredArrayUsingPredicate:$a_predicate];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSArray"
		end

end
