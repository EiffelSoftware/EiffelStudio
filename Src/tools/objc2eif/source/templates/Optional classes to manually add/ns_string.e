note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING

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
	make_with_string_,
	make_with_data__encoding_,
	make_with_eiffel_string

convert
	to_eiffel_string: {STRING_8},
	make_with_eiffel_string ({STRING_8})

feature -- Conversion

	to_eiffel_string: STRING_8
			-- Convert `Current' to a `STRING_8'.
		do
			create Result.make_from_c (objc_c_string_using_encoding_ (item, 1))
		end

feature -- NSString

	length: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_length (item)
		end

	character_at_index_ (a_index: NATURAL_64): NATURAL_16
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_at_index_ (item, a_index)
		end

feature {NONE} -- NSString Externals

	objc_length (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item length];
			 ]"
		end

	objc_character_at_index_ (an_item: POINTER; a_index: NATURAL_64): NATURAL_16
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item characterAtIndex:$a_index];
			 ]"
		end

feature -- NSStringExtensionMethods

--	get_characters__range_ (a_buffer: UNSUPPORTED_TYPE; a_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			objc_get_characters__range_ (item, a_buffer__item, a_range.item)
--		end

	substring_from_index_ (a_from: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_substring_from_index_ (item, a_from)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substring_from_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substring_from_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	substring_to_index_ (a_to: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_substring_to_index_ (item, a_to)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substring_to_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substring_to_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	substring_with_range_ (a_range: NS_RANGE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_substring_with_range_ (item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substring_with_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substring_with_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	compare_ (a_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_compare_ (item, a_string__item)
		end

	compare__options_ (a_string: detachable NS_STRING; a_mask: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_compare__options_ (item, a_string__item, a_mask)
		end

	compare__options__range_ (a_string: detachable NS_STRING; a_mask: NATURAL_64; a_compare_range: NS_RANGE): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_compare__options__range_ (item, a_string__item, a_mask, a_compare_range.item)
		end

	compare__options__range__locale_ (a_string: detachable NS_STRING; a_mask: NATURAL_64; a_compare_range: NS_RANGE; a_locale: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			Result := objc_compare__options__range__locale_ (item, a_string__item, a_mask, a_compare_range.item, a_locale__item)
		end

	case_insensitive_compare_ (a_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_case_insensitive_compare_ (item, a_string__item)
		end

	localized_compare_ (a_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_localized_compare_ (item, a_string__item)
		end

	localized_case_insensitive_compare_ (a_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_localized_case_insensitive_compare_ (item, a_string__item)
		end

	localized_standard_compare_ (a_string: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_localized_standard_compare_ (item, a_string__item)
		end

	is_equal_to_string_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_is_equal_to_string_ (item, a_string__item)
		end

	has_prefix_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_has_prefix_ (item, a_string__item)
		end

	has_suffix_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_has_suffix_ (item, a_string__item)
		end

	range_of_string_ (a_string: detachable NS_STRING): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create Result.make
			objc_range_of_string_ (item, Result.item, a_string__item)
		end

	range_of_string__options_ (a_string: detachable NS_STRING; a_mask: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create Result.make
			objc_range_of_string__options_ (item, Result.item, a_string__item, a_mask)
		end

	range_of_string__options__range_ (a_string: detachable NS_STRING; a_mask: NATURAL_64; a_search_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create Result.make
			objc_range_of_string__options__range_ (item, Result.item, a_string__item, a_mask, a_search_range.item)
		end

	range_of_string__options__range__locale_ (a_string: detachable NS_STRING; a_mask: NATURAL_64; a_search_range: NS_RANGE; a_locale: detachable NS_LOCALE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			create Result.make
			objc_range_of_string__options__range__locale_ (item, Result.item, a_string__item, a_mask, a_search_range.item, a_locale__item)
		end

	range_of_character_from_set_ (a_set: detachable NS_CHARACTER_SET): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			create Result.make
			objc_range_of_character_from_set_ (item, Result.item, a_set__item)
		end

	range_of_character_from_set__options_ (a_set: detachable NS_CHARACTER_SET; a_mask: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			create Result.make
			objc_range_of_character_from_set__options_ (item, Result.item, a_set__item, a_mask)
		end

	range_of_character_from_set__options__range_ (a_set: detachable NS_CHARACTER_SET; a_mask: NATURAL_64; a_search_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			create Result.make
			objc_range_of_character_from_set__options__range_ (item, Result.item, a_set__item, a_mask, a_search_range.item)
		end

	range_of_composed_character_sequence_at_index_ (a_index: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_of_composed_character_sequence_at_index_ (item, Result.item, a_index)
		end

	range_of_composed_character_sequences_for_range_ (a_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_of_composed_character_sequences_for_range_ (item, Result.item, a_range.item)
		end

	string_by_appending_string_ (a_string: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			result_pointer := objc_string_by_appending_string_ (item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_appending_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_appending_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	double_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_double_value (item)
		end

	float_value: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_float_value (item)
		end

	int_value: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_int_value (item)
		end

	integer_value: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_integer_value (item)
		end

	long_long_value: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_long_long_value (item)
		end

	bool_value: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bool_value (item)
		end

	components_separated_by_string_ (a_separator: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_separator__item: POINTER
		do
			if attached a_separator as a_separator_attached then
				a_separator__item := a_separator_attached.item
			end
			result_pointer := objc_components_separated_by_string_ (item, a_separator__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components_separated_by_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components_separated_by_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	components_separated_by_characters_in_set_ (a_separator: detachable NS_CHARACTER_SET): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_separator__item: POINTER
		do
			if attached a_separator as a_separator_attached then
				a_separator__item := a_separator_attached.item
			end
			result_pointer := objc_components_separated_by_characters_in_set_ (item, a_separator__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components_separated_by_characters_in_set_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components_separated_by_characters_in_set_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	common_prefix_with_string__options_ (a_string: detachable NS_STRING; a_mask: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			result_pointer := objc_common_prefix_with_string__options_ (item, a_string__item, a_mask)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like common_prefix_with_string__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like common_prefix_with_string__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	uppercase_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_uppercase_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like uppercase_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like uppercase_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	lowercase_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_lowercase_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like lowercase_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like lowercase_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	capitalized_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_capitalized_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like capitalized_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like capitalized_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_trimming_characters_in_set_ (a_set: detachable NS_CHARACTER_SET): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			result_pointer := objc_string_by_trimming_characters_in_set_ (item, a_set__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_trimming_characters_in_set_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_trimming_characters_in_set_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_padding_to_length__with_string__starting_at_index_ (a_new_length: NATURAL_64; a_pad_string: detachable NS_STRING; a_pad_index: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_pad_string__item: POINTER
		do
			if attached a_pad_string as a_pad_string_attached then
				a_pad_string__item := a_pad_string_attached.item
			end
			result_pointer := objc_string_by_padding_to_length__with_string__starting_at_index_ (item, a_new_length, a_pad_string__item, a_pad_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_padding_to_length__with_string__starting_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_padding_to_length__with_string__starting_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_line_start__end__contents_end__for_range_ (a_start_ptr: UNSUPPORTED_TYPE; a_line_end_ptr: UNSUPPORTED_TYPE; a_contents_end_ptr: UNSUPPORTED_TYPE; a_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_start_ptr__item: POINTER
--			a_line_end_ptr__item: POINTER
--			a_contents_end_ptr__item: POINTER
--		do
--			if attached a_start_ptr as a_start_ptr_attached then
--				a_start_ptr__item := a_start_ptr_attached.item
--			end
--			if attached a_line_end_ptr as a_line_end_ptr_attached then
--				a_line_end_ptr__item := a_line_end_ptr_attached.item
--			end
--			if attached a_contents_end_ptr as a_contents_end_ptr_attached then
--				a_contents_end_ptr__item := a_contents_end_ptr_attached.item
--			end
--			objc_get_line_start__end__contents_end__for_range_ (item, a_start_ptr__item, a_line_end_ptr__item, a_contents_end_ptr__item, a_range.item)
--		end

	line_range_for_range_ (a_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_line_range_for_range_ (item, Result.item, a_range.item)
		end

--	get_paragraph_start__end__contents_end__for_range_ (a_start_ptr: UNSUPPORTED_TYPE; a_par_end_ptr: UNSUPPORTED_TYPE; a_contents_end_ptr: UNSUPPORTED_TYPE; a_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_start_ptr__item: POINTER
--			a_par_end_ptr__item: POINTER
--			a_contents_end_ptr__item: POINTER
--		do
--			if attached a_start_ptr as a_start_ptr_attached then
--				a_start_ptr__item := a_start_ptr_attached.item
--			end
--			if attached a_par_end_ptr as a_par_end_ptr_attached then
--				a_par_end_ptr__item := a_par_end_ptr_attached.item
--			end
--			if attached a_contents_end_ptr as a_contents_end_ptr_attached then
--				a_contents_end_ptr__item := a_contents_end_ptr_attached.item
--			end
--			objc_get_paragraph_start__end__contents_end__for_range_ (item, a_start_ptr__item, a_par_end_ptr__item, a_contents_end_ptr__item, a_range.item)
--		end

	paragraph_range_for_range_ (a_range: NS_RANGE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_paragraph_range_for_range_ (item, Result.item, a_range.item)
		end

--	enumerate_substrings_in_range__options__using_block_ (a_range: NS_RANGE; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_substrings_in_range__options__using_block_ (item, a_range.item, a_opts, )
--		end

--	enumerate_lines_using_block_ (a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_enumerate_lines_using_block_ (item, )
--		end

	fastest_encoding: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_fastest_encoding (item)
		end

	smallest_encoding: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_smallest_encoding (item)
		end

	data_using_encoding__allow_lossy_conversion_ (a_encoding: NATURAL_64; a_lossy: BOOLEAN): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_using_encoding__allow_lossy_conversion_ (item, a_encoding, a_lossy)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_using_encoding__allow_lossy_conversion_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_using_encoding__allow_lossy_conversion_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data_using_encoding_ (a_encoding: NATURAL_64): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_using_encoding_ (item, a_encoding)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_using_encoding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_using_encoding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	can_be_converted_to_encoding_ (a_encoding: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_be_converted_to_encoding_ (item, a_encoding)
		end

--	c_string_using_encoding_ (a_encoding: NATURAL_64): detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_c_string_using_encoding_ (item, a_encoding)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like c_string_using_encoding_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like c_string_using_encoding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	get_c_string__max_length__encoding_ (a_buffer: UNSUPPORTED_TYPE; a_max_buffer_count: NATURAL_64; a_encoding: NATURAL_64): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_get_c_string__max_length__encoding_ (item, , a_max_buffer_count, a_encoding)
--		end

--	get_bytes__max_length__used_length__encoding__options__range__remaining_range_ (a_buffer: UNSUPPORTED_TYPE; a_max_buffer_count: NATURAL_64; a_used_buffer_count: UNSUPPORTED_TYPE; a_encoding: NATURAL_64; a_options: NATURAL_64; a_range: NS_RANGE; a_leftover: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--			a_used_buffer_count__item: POINTER
--			a_leftover__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			if attached a_used_buffer_count as a_used_buffer_count_attached then
--				a_used_buffer_count__item := a_used_buffer_count_attached.item
--			end
--			if attached a_leftover as a_leftover_attached then
--				a_leftover__item := a_leftover_attached.item
--			end
--			Result := objc_get_bytes__max_length__used_length__encoding__options__range__remaining_range_ (item, a_buffer__item, a_max_buffer_count, a_used_buffer_count__item, a_encoding, a_options, a_range.item, a_leftover__item)
--		end

	maximum_length_of_bytes_using_encoding_ (a_enc: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_length_of_bytes_using_encoding_ (item, a_enc)
		end

	length_of_bytes_using_encoding_ (a_enc: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_length_of_bytes_using_encoding_ (item, a_enc)
		end

	decomposed_string_with_canonical_mapping: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decomposed_string_with_canonical_mapping (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decomposed_string_with_canonical_mapping} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decomposed_string_with_canonical_mapping} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	precomposed_string_with_canonical_mapping: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_precomposed_string_with_canonical_mapping (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like precomposed_string_with_canonical_mapping} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like precomposed_string_with_canonical_mapping} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	decomposed_string_with_compatibility_mapping: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decomposed_string_with_compatibility_mapping (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decomposed_string_with_compatibility_mapping} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decomposed_string_with_compatibility_mapping} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	precomposed_string_with_compatibility_mapping: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_precomposed_string_with_compatibility_mapping (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like precomposed_string_with_compatibility_mapping} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like precomposed_string_with_compatibility_mapping} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_folding_with_options__locale_ (a_options: NATURAL_64; a_locale: detachable NS_LOCALE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_string_by_folding_with_options__locale_ (item, a_options, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_folding_with_options__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_folding_with_options__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_replacing_occurrences_of_string__with_string__options__range_ (a_target: detachable NS_STRING; a_replacement: detachable NS_STRING; a_options: NATURAL_64; a_search_range: NS_RANGE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_target__item: POINTER
			a_replacement__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_replacement as a_replacement_attached then
				a_replacement__item := a_replacement_attached.item
			end
			result_pointer := objc_string_by_replacing_occurrences_of_string__with_string__options__range_ (item, a_target__item, a_replacement__item, a_options, a_search_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_replacing_occurrences_of_string__with_string__options__range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_replacing_occurrences_of_string__with_string__options__range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_replacing_occurrences_of_string__with_string_ (a_target: detachable NS_STRING; a_replacement: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_target__item: POINTER
			a_replacement__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_replacement as a_replacement_attached then
				a_replacement__item := a_replacement_attached.item
			end
			result_pointer := objc_string_by_replacing_occurrences_of_string__with_string_ (item, a_target__item, a_replacement__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_replacing_occurrences_of_string__with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_replacing_occurrences_of_string__with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_replacing_characters_in_range__with_string_ (a_range: NS_RANGE; a_replacement: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_replacement__item: POINTER
		do
			if attached a_replacement as a_replacement_attached then
				a_replacement__item := a_replacement_attached.item
			end
			result_pointer := objc_string_by_replacing_characters_in_range__with_string_ (item, a_range.item, a_replacement__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_replacing_characters_in_range__with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_replacing_characters_in_range__with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	ut_f8_string: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_ut_f8_string (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like ut_f8_string} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like ut_f8_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	write_to_ur_l__atomically__encoding__error_ (a_url: detachable NS_URL; a_use_auxiliary_file: BOOLEAN; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_write_to_ur_l__atomically__encoding__error_ (item, a_url__item, a_use_auxiliary_file, a_enc, a_error__item)
--		end

--	write_to_file__atomically__encoding__error_ (a_path: detachable NS_STRING; a_use_auxiliary_file: BOOLEAN; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_write_to_file__atomically__encoding__error_ (item, a_path__item, a_use_auxiliary_file, a_enc, a_error__item)
--		end

feature {NONE} -- NSStringExtensionMethods Externals

--	objc_get_characters__range_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE; a_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSString *)$an_item getCharacters: range:*((NSRange *)$a_range)];
--			 ]"
--		end

	objc_substring_from_index_ (an_item: POINTER; a_from: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item substringFromIndex:$a_from];
			 ]"
		end

	objc_substring_to_index_ (an_item: POINTER; a_to: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item substringToIndex:$a_to];
			 ]"
		end

	objc_substring_with_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item substringWithRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_compare_ (an_item: POINTER; a_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item compare:$a_string];
			 ]"
		end

	objc_compare__options_ (an_item: POINTER; a_string: POINTER; a_mask: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item compare:$a_string options:$a_mask];
			 ]"
		end

	objc_compare__options__range_ (an_item: POINTER; a_string: POINTER; a_mask: NATURAL_64; a_compare_range: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item compare:$a_string options:$a_mask range:*((NSRange *)$a_compare_range)];
			 ]"
		end

	objc_compare__options__range__locale_ (an_item: POINTER; a_string: POINTER; a_mask: NATURAL_64; a_compare_range: POINTER; a_locale: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item compare:$a_string options:$a_mask range:*((NSRange *)$a_compare_range) locale:$a_locale];
			 ]"
		end

	objc_case_insensitive_compare_ (an_item: POINTER; a_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item caseInsensitiveCompare:$a_string];
			 ]"
		end

	objc_localized_compare_ (an_item: POINTER; a_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item localizedCompare:$a_string];
			 ]"
		end

	objc_localized_case_insensitive_compare_ (an_item: POINTER; a_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item localizedCaseInsensitiveCompare:$a_string];
			 ]"
		end

	objc_localized_standard_compare_ (an_item: POINTER; a_string: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item localizedStandardCompare:$a_string];
			 ]"
		end

	objc_is_equal_to_string_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item isEqualToString:$a_string];
			 ]"
		end

	objc_has_prefix_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item hasPrefix:$a_string];
			 ]"
		end

	objc_has_suffix_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item hasSuffix:$a_string];
			 ]"
		end

	objc_range_of_string_ (an_item: POINTER; result_pointer: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfString:$a_string];
			 ]"
		end

	objc_range_of_string__options_ (an_item: POINTER; result_pointer: POINTER; a_string: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfString:$a_string options:$a_mask];
			 ]"
		end

	objc_range_of_string__options__range_ (an_item: POINTER; result_pointer: POINTER; a_string: POINTER; a_mask: NATURAL_64; a_search_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfString:$a_string options:$a_mask range:*((NSRange *)$a_search_range)];
			 ]"
		end

	objc_range_of_string__options__range__locale_ (an_item: POINTER; result_pointer: POINTER; a_string: POINTER; a_mask: NATURAL_64; a_search_range: POINTER; a_locale: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfString:$a_string options:$a_mask range:*((NSRange *)$a_search_range) locale:$a_locale];
			 ]"
		end

	objc_range_of_character_from_set_ (an_item: POINTER; result_pointer: POINTER; a_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfCharacterFromSet:$a_set];
			 ]"
		end

	objc_range_of_character_from_set__options_ (an_item: POINTER; result_pointer: POINTER; a_set: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfCharacterFromSet:$a_set options:$a_mask];
			 ]"
		end

	objc_range_of_character_from_set__options__range_ (an_item: POINTER; result_pointer: POINTER; a_set: POINTER; a_mask: NATURAL_64; a_search_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfCharacterFromSet:$a_set options:$a_mask range:*((NSRange *)$a_search_range)];
			 ]"
		end

	objc_range_of_composed_character_sequence_at_index_ (an_item: POINTER; result_pointer: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfComposedCharacterSequenceAtIndex:$a_index];
			 ]"
		end

	objc_range_of_composed_character_sequences_for_range_ (an_item: POINTER; result_pointer: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item rangeOfComposedCharacterSequencesForRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_string_by_appending_string_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByAppendingString:$a_string];
			 ]"
		end

	objc_double_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item doubleValue];
			 ]"
		end

	objc_float_value (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item floatValue];
			 ]"
		end

	objc_int_value (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item intValue];
			 ]"
		end

	objc_integer_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item integerValue];
			 ]"
		end

	objc_long_long_value (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item longLongValue];
			 ]"
		end

	objc_bool_value (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item boolValue];
			 ]"
		end

	objc_components_separated_by_string_ (an_item: POINTER; a_separator: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item componentsSeparatedByString:$a_separator];
			 ]"
		end

	objc_components_separated_by_characters_in_set_ (an_item: POINTER; a_separator: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item componentsSeparatedByCharactersInSet:$a_separator];
			 ]"
		end

	objc_common_prefix_with_string__options_ (an_item: POINTER; a_string: POINTER; a_mask: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item commonPrefixWithString:$a_string options:$a_mask];
			 ]"
		end

	objc_uppercase_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item uppercaseString];
			 ]"
		end

	objc_lowercase_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item lowercaseString];
			 ]"
		end

	objc_capitalized_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item capitalizedString];
			 ]"
		end

	objc_string_by_trimming_characters_in_set_ (an_item: POINTER; a_set: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByTrimmingCharactersInSet:$a_set];
			 ]"
		end

	objc_string_by_padding_to_length__with_string__starting_at_index_ (an_item: POINTER; a_new_length: NATURAL_64; a_pad_string: POINTER; a_pad_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByPaddingToLength:$a_new_length withString:$a_pad_string startingAtIndex:$a_pad_index];
			 ]"
		end

--	objc_get_line_start__end__contents_end__for_range_ (an_item: POINTER; a_start_ptr: UNSUPPORTED_TYPE; a_line_end_ptr: UNSUPPORTED_TYPE; a_contents_end_ptr: UNSUPPORTED_TYPE; a_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSString *)$an_item getLineStart: end: contentsEnd: forRange:*((NSRange *)$a_range)];
--			 ]"
--		end

	objc_line_range_for_range_ (an_item: POINTER; result_pointer: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item lineRangeForRange:*((NSRange *)$a_range)];
			 ]"
		end

--	objc_get_paragraph_start__end__contents_end__for_range_ (an_item: POINTER; a_start_ptr: UNSUPPORTED_TYPE; a_par_end_ptr: UNSUPPORTED_TYPE; a_contents_end_ptr: UNSUPPORTED_TYPE; a_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSString *)$an_item getParagraphStart: end: contentsEnd: forRange:*((NSRange *)$a_range)];
--			 ]"
--		end

	objc_paragraph_range_for_range_ (an_item: POINTER; result_pointer: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSString *)$an_item paragraphRangeForRange:*((NSRange *)$a_range)];
			 ]"
		end

--	objc_enumerate_substrings_in_range__options__using_block_ (an_item: POINTER; a_range: POINTER; a_opts: NATURAL_64; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSString *)$an_item enumerateSubstringsInRange:*((NSRange *)$a_range) options:$a_opts usingBlock:];
--			 ]"
--		end

--	objc_enumerate_lines_using_block_ (an_item: POINTER; a_block: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSString *)$an_item enumerateLinesUsingBlock:];
--			 ]"
--		end

	objc_fastest_encoding (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item fastestEncoding];
			 ]"
		end

	objc_smallest_encoding (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item smallestEncoding];
			 ]"
		end

	objc_data_using_encoding__allow_lossy_conversion_ (an_item: POINTER; a_encoding: NATURAL_64; a_lossy: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item dataUsingEncoding:$a_encoding allowLossyConversion:$a_lossy];
			 ]"
		end

	objc_data_using_encoding_ (an_item: POINTER; a_encoding: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item dataUsingEncoding:$a_encoding];
			 ]"
		end

	objc_can_be_converted_to_encoding_ (an_item: POINTER; a_encoding: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item canBeConvertedToEncoding:$a_encoding];
			 ]"
		end

	objc_c_string_using_encoding_ (an_item: POINTER; a_encoding: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item cStringUsingEncoding:$a_encoding];
			 ]"
		end

--	objc_get_c_string__max_length__encoding_ (an_item: POINTER; a_buffer: POINTER; a_max_buffer_count: NATURAL_64; a_encoding: NATURAL_64): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSString *)$an_item getCString:$a_buffer maxLength:$a_max_buffer_count encoding:$a_encoding];
--			 ]"
--		end

--	objc_get_bytes__max_length__used_length__encoding__options__range__remaining_range_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE; a_max_buffer_count: NATURAL_64; a_used_buffer_count: UNSUPPORTED_TYPE; a_encoding: NATURAL_64; a_options: NATURAL_64; a_range: POINTER; a_leftover: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSString *)$an_item getBytes: maxLength:$a_max_buffer_count usedLength: encoding:$a_encoding options:$a_options range:*((NSRange *)$a_range) remainingRange:];
--			 ]"
--		end

	objc_maximum_length_of_bytes_using_encoding_ (an_item: POINTER; a_enc: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item maximumLengthOfBytesUsingEncoding:$a_enc];
			 ]"
		end

	objc_length_of_bytes_using_encoding_ (an_item: POINTER; a_enc: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item lengthOfBytesUsingEncoding:$a_enc];
			 ]"
		end

	objc_decomposed_string_with_canonical_mapping (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item decomposedStringWithCanonicalMapping];
			 ]"
		end

	objc_precomposed_string_with_canonical_mapping (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item precomposedStringWithCanonicalMapping];
			 ]"
		end

	objc_decomposed_string_with_compatibility_mapping (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item decomposedStringWithCompatibilityMapping];
			 ]"
		end

	objc_precomposed_string_with_compatibility_mapping (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item precomposedStringWithCompatibilityMapping];
			 ]"
		end

	objc_string_by_folding_with_options__locale_ (an_item: POINTER; a_options: NATURAL_64; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByFoldingWithOptions:$a_options locale:$a_locale];
			 ]"
		end

	objc_string_by_replacing_occurrences_of_string__with_string__options__range_ (an_item: POINTER; a_target: POINTER; a_replacement: POINTER; a_options: NATURAL_64; a_search_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByReplacingOccurrencesOfString:$a_target withString:$a_replacement options:$a_options range:*((NSRange *)$a_search_range)];
			 ]"
		end

	objc_string_by_replacing_occurrences_of_string__with_string_ (an_item: POINTER; a_target: POINTER; a_replacement: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByReplacingOccurrencesOfString:$a_target withString:$a_replacement];
			 ]"
		end

	objc_string_by_replacing_characters_in_range__with_string_ (an_item: POINTER; a_range: POINTER; a_replacement: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByReplacingCharactersInRange:*((NSRange *)$a_range) withString:$a_replacement];
			 ]"
		end

--	objc_ut_f8_string (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item UTF8String];
--			 ]"
--		end

--	objc_init_with_characters_no_copy__length__free_when_done_ (an_item: POINTER; a_characters: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_free_buffer: BOOLEAN): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithCharactersNoCopy: length:$a_length freeWhenDone:$a_free_buffer];
--			 ]"
--		end

--	objc_init_with_characters__length_ (an_item: POINTER; a_characters: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithCharacters: length:$a_length];
--			 ]"
--		end

--	objc_init_with_ut_f8_string_ (an_item: POINTER; a_null_terminated_c_string: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithUTF8String:$a_null_terminated_c_string];
--			 ]"
--		end

	objc_init_with_string_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item initWithString:$a_string];
			 ]"
		end

	objc_init_with_data__encoding_ (an_item: POINTER; a_data: POINTER; a_encoding: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item initWithData:$a_data encoding:$a_encoding];
			 ]"
		end

--	objc_init_with_bytes__length__encoding_ (an_item: POINTER; a_bytes: UNSUPPORTED_TYPE; a_len: NATURAL_64; a_encoding: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithBytes: length:$a_len encoding:$a_encoding];
--			 ]"
--		end

--	objc_init_with_bytes_no_copy__length__encoding__free_when_done_ (an_item: POINTER; a_bytes: UNSUPPORTED_TYPE; a_len: NATURAL_64; a_encoding: NATURAL_64; a_free_buffer: BOOLEAN): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithBytesNoCopy: length:$a_len encoding:$a_encoding freeWhenDone:$a_free_buffer];
--			 ]"
--		end

	objc_init_with_c_string__encoding_ (an_item: POINTER; a_null_terminated_c_string: POINTER; a_encoding: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item initWithCString:$a_null_terminated_c_string encoding:$a_encoding];
			 ]"
		end

--	objc_init_with_contents_of_ur_l__encoding__error_ (an_item: POINTER; a_url: POINTER; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithContentsOfURL:$a_url encoding:$a_enc error:];
--			 ]"
--		end

--	objc_init_with_contents_of_file__encoding__error_ (an_item: POINTER; a_path: POINTER; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithContentsOfFile:$a_path encoding:$a_enc error:];
--			 ]"
--		end

--	objc_init_with_contents_of_ur_l__used_encoding__error_ (an_item: POINTER; a_url: POINTER; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithContentsOfURL:$a_url usedEncoding: error:];
--			 ]"
--		end

--	objc_init_with_contents_of_file__used_encoding__error_ (an_item: POINTER; a_path: POINTER; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item initWithContentsOfFile:$a_path usedEncoding: error:];
--			 ]"
--		end

--	objc_write_to_ur_l__atomically__encoding__error_ (an_item: POINTER; a_url: POINTER; a_use_auxiliary_file: BOOLEAN; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSString *)$an_item writeToURL:$a_url atomically:$a_use_auxiliary_file encoding:$a_enc error:];
--			 ]"
--		end

--	objc_write_to_file__atomically__encoding__error_ (an_item: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSString *)$an_item writeToFile:$a_path atomically:$a_use_auxiliary_file encoding:$a_enc error:];
--			 ]"
--		end

feature {NONE} -- Initialization

	make_with_eiffel_string (an_eiffel_string: STRING_8)
			-- Initialize `Current' with `an_eiffel_string'
		local
			c_string: C_STRING
		do
			create c_string.make (an_eiffel_string)
			make_with_pointer (objc_init_with_c_string__encoding_ (allocate_object, c_string.item, 1))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_characters_no_copy__length__free_when_done_ (a_characters: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_free_buffer: BOOLEAN)
--			-- Initialize `Current'.
--		local
--			a_characters__item: POINTER
--		do
--			if attached a_characters as a_characters_attached then
--				a_characters__item := a_characters_attached.item
--			end
--			make_with_pointer (objc_init_with_characters_no_copy__length__free_when_done_(allocate_object, a_characters__item, a_length, a_free_buffer))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_characters__length_ (a_characters: UNSUPPORTED_TYPE; a_length: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_characters__item: POINTER
--		do
--			if attached a_characters as a_characters_attached then
--				a_characters__item := a_characters_attached.item
--			end
--			make_with_pointer (objc_init_with_characters__length_(allocate_object, a_characters__item, a_length))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_ut_f8_string_ (a_null_terminated_c_string: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--		do
--			make_with_pointer (objc_init_with_ut_f8_string_(allocate_object))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_string_ (a_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data__encoding_ (a_data: detachable NS_DATA; a_encoding: NATURAL_64)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data__encoding_(allocate_object, a_data__item, a_encoding))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_bytes__length__encoding_ (a_bytes: UNSUPPORTED_TYPE; a_len: NATURAL_64; a_encoding: NATURAL_64)
--			-- Initialize `Current'.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			make_with_pointer (objc_init_with_bytes__length__encoding_(allocate_object, a_bytes__item, a_len, a_encoding))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_bytes_no_copy__length__encoding__free_when_done_ (a_bytes: UNSUPPORTED_TYPE; a_len: NATURAL_64; a_encoding: NATURAL_64; a_free_buffer: BOOLEAN)
--			-- Initialize `Current'.
--		local
--			a_bytes__item: POINTER
--		do
--			if attached a_bytes as a_bytes_attached then
--				a_bytes__item := a_bytes_attached.item
--			end
--			make_with_pointer (objc_init_with_bytes_no_copy__length__encoding__free_when_done_(allocate_object, a_bytes__item, a_len, a_encoding, a_free_buffer))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_c_string__encoding_ (a_null_terminated_c_string: UNSUPPORTED_TYPE; a_encoding: NATURAL_64)
--			-- Initialize `Current'.
--		local
--		do
--			make_with_pointer (objc_init_with_c_string__encoding_(allocate_object, a_encoding))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_ur_l__encoding__error_ (a_url: detachable NS_URL; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_ur_l__encoding__error_(allocate_object, a_url__item, a_enc, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_file__encoding__error_ (a_path: detachable NS_STRING; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_file__encoding__error_(allocate_object, a_path__item, a_enc, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_ur_l__used_encoding__error_ (a_url: detachable NS_URL; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_enc__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_enc as a_enc_attached then
--				a_enc__item := a_enc_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_ur_l__used_encoding__error_(allocate_object, a_url__item, a_enc__item, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_file__used_encoding__error_ (a_path: detachable NS_STRING; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_path__item: POINTER
--			a_enc__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_enc as a_enc_attached then
--				a_enc__item := a_enc_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_file__used_encoding__error_(allocate_object, a_path__item, a_enc__item, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature -- NSExtendedStringPropertyListParsing

	property_list: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_property_list (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like property_list} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like property_list} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	property_list_from_strings_file_format: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_property_list_from_strings_file_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like property_list_from_strings_file_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like property_list_from_strings_file_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSExtendedStringPropertyListParsing Externals

	objc_property_list (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item propertyList];
			 ]"
		end

	objc_property_list_from_strings_file_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item propertyListFromStringsFileFormat];
			 ]"
		end

feature -- NSStringDeprecated

--	get_characters_ (a_buffer: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_buffer__item: POINTER
--		do
--			if attached a_buffer as a_buffer_attached then
--				a_buffer__item := a_buffer_attached.item
--			end
--			objc_get_characters_ (item, a_buffer__item)
--		end

feature {NONE} -- NSStringDeprecated Externals

--	objc_get_characters_ (an_item: POINTER; a_buffer: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSString *)$an_item getCharacters:];
--			 ]"
--		end

feature -- NSStringPathExtensions

	path_components: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_components (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_components} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_components} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_absolute_path: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_absolute_path (item)
		end

	last_path_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_last_path_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like last_path_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like last_path_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_deleting_last_path_component: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_deleting_last_path_component (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_deleting_last_path_component} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_deleting_last_path_component} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_appending_path_component_ (a_str: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_str__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			result_pointer := objc_string_by_appending_path_component_ (item, a_str__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_appending_path_component_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_appending_path_component_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_extension: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_extension (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_extension} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_extension} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_deleting_path_extension: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_deleting_path_extension (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_deleting_path_extension} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_deleting_path_extension} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_appending_path_extension_ (a_str: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_str__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			result_pointer := objc_string_by_appending_path_extension_ (item, a_str__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_appending_path_extension_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_appending_path_extension_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_abbreviating_with_tilde_in_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_abbreviating_with_tilde_in_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_abbreviating_with_tilde_in_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_abbreviating_with_tilde_in_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_expanding_tilde_in_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_expanding_tilde_in_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_expanding_tilde_in_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_expanding_tilde_in_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_standardizing_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_standardizing_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_standardizing_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_standardizing_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_resolving_symlinks_in_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_resolving_symlinks_in_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_resolving_symlinks_in_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_resolving_symlinks_in_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	strings_by_appending_paths_ (a_paths: detachable NS_ARRAY): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_paths__item: POINTER
		do
			if attached a_paths as a_paths_attached then
				a_paths__item := a_paths_attached.item
			end
			result_pointer := objc_strings_by_appending_paths_ (item, a_paths__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like strings_by_appending_paths_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like strings_by_appending_paths_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	complete_path_into_string__case_sensitive__matches_into_array__filter_types_ (a_output_name: UNSUPPORTED_TYPE; a_flag: BOOLEAN; a_output_array: UNSUPPORTED_TYPE; a_filter_types: detachable NS_ARRAY): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_output_name__item: POINTER
--			a_output_array__item: POINTER
--			a_filter_types__item: POINTER
--		do
--			if attached a_output_name as a_output_name_attached then
--				a_output_name__item := a_output_name_attached.item
--			end
--			if attached a_output_array as a_output_array_attached then
--				a_output_array__item := a_output_array_attached.item
--			end
--			if attached a_filter_types as a_filter_types_attached then
--				a_filter_types__item := a_filter_types_attached.item
--			end
--			Result := objc_complete_path_into_string__case_sensitive__matches_into_array__filter_types_ (item, a_output_name__item, a_flag, a_output_array__item, a_filter_types__item)
--		end

--	file_system_representation: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_file_system_representation (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like file_system_representation} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like file_system_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	get_file_system_representation__max_length_ (a_cname: UNSUPPORTED_TYPE; a_max: NATURAL_64): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_get_file_system_representation__max_length_ (item, , a_max)
--		end

feature {NONE} -- NSStringPathExtensions Externals

	objc_path_components (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item pathComponents];
			 ]"
		end

	objc_is_absolute_path (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSString *)$an_item isAbsolutePath];
			 ]"
		end

	objc_last_path_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item lastPathComponent];
			 ]"
		end

	objc_string_by_deleting_last_path_component (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByDeletingLastPathComponent];
			 ]"
		end

	objc_string_by_appending_path_component_ (an_item: POINTER; a_str: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByAppendingPathComponent:$a_str];
			 ]"
		end

	objc_path_extension (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item pathExtension];
			 ]"
		end

	objc_string_by_deleting_path_extension (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByDeletingPathExtension];
			 ]"
		end

	objc_string_by_appending_path_extension_ (an_item: POINTER; a_str: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByAppendingPathExtension:$a_str];
			 ]"
		end

	objc_string_by_abbreviating_with_tilde_in_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByAbbreviatingWithTildeInPath];
			 ]"
		end

	objc_string_by_expanding_tilde_in_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByExpandingTildeInPath];
			 ]"
		end

	objc_string_by_standardizing_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByStandardizingPath];
			 ]"
		end

	objc_string_by_resolving_symlinks_in_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByResolvingSymlinksInPath];
			 ]"
		end

	objc_strings_by_appending_paths_ (an_item: POINTER; a_paths: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringsByAppendingPaths:$a_paths];
			 ]"
		end

--	objc_complete_path_into_string__case_sensitive__matches_into_array__filter_types_ (an_item: POINTER; a_output_name: UNSUPPORTED_TYPE; a_flag: BOOLEAN; a_output_array: UNSUPPORTED_TYPE; a_filter_types: POINTER): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSString *)$an_item completePathIntoString: caseSensitive:$a_flag matchesIntoArray: filterTypes:$a_filter_types];
--			 ]"
--		end

--	objc_file_system_representation (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSString *)$an_item fileSystemRepresentation];
--			 ]"
--		end

--	objc_get_file_system_representation__max_length_ (an_item: POINTER; a_cname: POINTER; a_max: NATURAL_64): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSString *)$an_item getFileSystemRepresentation:$a_cname maxLength:$a_max];
--			 ]"
--		end

feature -- NSURLUtilities

	string_by_adding_percent_escapes_using_encoding_ (a_enc: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_adding_percent_escapes_using_encoding_ (item, a_enc)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_adding_percent_escapes_using_encoding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_adding_percent_escapes_using_encoding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_by_replacing_percent_escapes_using_encoding_ (a_enc: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_by_replacing_percent_escapes_using_encoding_ (item, a_enc)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_by_replacing_percent_escapes_using_encoding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_by_replacing_percent_escapes_using_encoding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSURLUtilities Externals

	objc_string_by_adding_percent_escapes_using_encoding_ (an_item: POINTER; a_enc: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByAddingPercentEscapesUsingEncoding:$a_enc];
			 ]"
		end

	objc_string_by_replacing_percent_escapes_using_encoding_ (an_item: POINTER; a_enc: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSString *)$an_item stringByReplacingPercentEscapesUsingEncoding:$a_enc];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSString"
		end

end
