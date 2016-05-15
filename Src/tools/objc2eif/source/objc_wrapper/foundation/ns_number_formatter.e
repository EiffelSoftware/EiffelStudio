note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NUMBER_FORMATTER

inherit
	NS_FORMATTER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSNumberFormatter

--	get_object_value__for_string__range__error_ (a_obj: UNSUPPORTED_TYPE; a_string: detachable NS_STRING; a_rangep: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_obj__item: POINTER
--			a_string__item: POINTER
--			a_rangep__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_obj as a_obj_attached then
--				a_obj__item := a_obj_attached.item
--			end
--			if attached a_string as a_string_attached then
--				a_string__item := a_string_attached.item
--			end
--			if attached a_rangep as a_rangep_attached then
--				a_rangep__item := a_rangep_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_get_object_value__for_string__range__error_ (item, a_obj__item, a_string__item, a_rangep__item, a_error__item)
--		end

	string_from_number_ (a_number: detachable NS_NUMBER): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_number__item: POINTER
		do
			if attached a_number as a_number_attached then
				a_number__item := a_number_attached.item
			end
			result_pointer := objc_string_from_number_ (item, a_number__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_from_number_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_from_number_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_from_string_ (a_string: detachable NS_STRING): detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			result_pointer := objc_number_from_string_ (item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like number_from_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like number_from_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_style (item)
		end

	set_number_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_number_style_ (item, a_style)
		end

	locale: detachable NS_LOCALE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_locale (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like locale} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like locale} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_locale_ (a_locale: detachable NS_LOCALE)
			-- Auto generated Objective-C wrapper.
		local
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			objc_set_locale_ (item, a_locale__item)
		end

	generates_decimal_numbers: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_generates_decimal_numbers (item)
		end

	set_generates_decimal_numbers_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_generates_decimal_numbers_ (item, a_b)
		end

	formatter_behavior: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_formatter_behavior (item)
		end

	set_formatter_behavior_ (a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_formatter_behavior_ (item, a_behavior)
		end

	negative_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_negative_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like negative_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like negative_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_negative_format_ (a_format: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			objc_set_negative_format_ (item, a_format__item)
		end

	text_attributes_for_negative_values: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_negative_values (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_negative_values} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_negative_values} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_negative_values_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_negative_values_ (item, a_new_attributes__item)
		end

	positive_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_positive_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like positive_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like positive_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_positive_format_ (a_format: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			objc_set_positive_format_ (item, a_format__item)
		end

	text_attributes_for_positive_values: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_positive_values (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_positive_values} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_positive_values} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_positive_values_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_positive_values_ (item, a_new_attributes__item)
		end

	allows_floats: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_floats (item)
		end

	set_allows_floats_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_floats_ (item, a_flag)
		end

	decimal_separator: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_decimal_separator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like decimal_separator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like decimal_separator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_decimal_separator_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_decimal_separator_ (item, a_string__item)
		end

	always_shows_decimal_separator: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_always_shows_decimal_separator (item)
		end

	set_always_shows_decimal_separator_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_always_shows_decimal_separator_ (item, a_b)
		end

	currency_decimal_separator: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_currency_decimal_separator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like currency_decimal_separator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like currency_decimal_separator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_currency_decimal_separator_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_currency_decimal_separator_ (item, a_string__item)
		end

	uses_grouping_separator: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_grouping_separator (item)
		end

	set_uses_grouping_separator_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_grouping_separator_ (item, a_b)
		end

	grouping_separator: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_grouping_separator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like grouping_separator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like grouping_separator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_grouping_separator_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_grouping_separator_ (item, a_string__item)
		end

	zero_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_zero_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like zero_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like zero_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_zero_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_zero_symbol_ (item, a_string__item)
		end

	text_attributes_for_zero: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_zero (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_zero} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_zero} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_zero_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_zero_ (item, a_new_attributes__item)
		end

	nil_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_nil_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like nil_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like nil_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_nil_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_nil_symbol_ (item, a_string__item)
		end

	text_attributes_for_nil: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_nil (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_nil} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_nil} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_nil_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_nil_ (item, a_new_attributes__item)
		end

	not_a_number_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_not_a_number_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like not_a_number_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like not_a_number_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_not_a_number_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_not_a_number_symbol_ (item, a_string__item)
		end

	text_attributes_for_not_a_number: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_not_a_number (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_not_a_number} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_not_a_number} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_not_a_number_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_not_a_number_ (item, a_new_attributes__item)
		end

	positive_infinity_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_positive_infinity_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like positive_infinity_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like positive_infinity_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_positive_infinity_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_positive_infinity_symbol_ (item, a_string__item)
		end

	text_attributes_for_positive_infinity: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_positive_infinity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_positive_infinity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_positive_infinity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_positive_infinity_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_positive_infinity_ (item, a_new_attributes__item)
		end

	negative_infinity_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_negative_infinity_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like negative_infinity_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like negative_infinity_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_negative_infinity_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_negative_infinity_symbol_ (item, a_string__item)
		end

	text_attributes_for_negative_infinity: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_attributes_for_negative_infinity (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_attributes_for_negative_infinity} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_attributes_for_negative_infinity} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_attributes_for_negative_infinity_ (a_new_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributes__item: POINTER
		do
			if attached a_new_attributes as a_new_attributes_attached then
				a_new_attributes__item := a_new_attributes_attached.item
			end
			objc_set_text_attributes_for_negative_infinity_ (item, a_new_attributes__item)
		end

	positive_prefix: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_positive_prefix (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like positive_prefix} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like positive_prefix} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_positive_prefix_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_positive_prefix_ (item, a_string__item)
		end

	positive_suffix: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_positive_suffix (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like positive_suffix} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like positive_suffix} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_positive_suffix_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_positive_suffix_ (item, a_string__item)
		end

	negative_prefix: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_negative_prefix (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like negative_prefix} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like negative_prefix} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_negative_prefix_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_negative_prefix_ (item, a_string__item)
		end

	negative_suffix: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_negative_suffix (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like negative_suffix} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like negative_suffix} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_negative_suffix_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_negative_suffix_ (item, a_string__item)
		end

	currency_code: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_currency_code (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like currency_code} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like currency_code} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_currency_code_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_currency_code_ (item, a_string__item)
		end

	currency_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_currency_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like currency_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like currency_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_currency_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_currency_symbol_ (item, a_string__item)
		end

	international_currency_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_international_currency_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like international_currency_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like international_currency_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_international_currency_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_international_currency_symbol_ (item, a_string__item)
		end

	percent_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_percent_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like percent_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like percent_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_percent_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_percent_symbol_ (item, a_string__item)
		end

	per_mill_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_per_mill_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like per_mill_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like per_mill_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_per_mill_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_per_mill_symbol_ (item, a_string__item)
		end

	minus_sign: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_minus_sign (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like minus_sign} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like minus_sign} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_minus_sign_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_minus_sign_ (item, a_string__item)
		end

	plus_sign: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_plus_sign (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like plus_sign} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like plus_sign} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_plus_sign_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_plus_sign_ (item, a_string__item)
		end

	exponent_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_exponent_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like exponent_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like exponent_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_exponent_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_exponent_symbol_ (item, a_string__item)
		end

	grouping_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_grouping_size (item)
		end

	set_grouping_size_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_grouping_size_ (item, a_number)
		end

	secondary_grouping_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_secondary_grouping_size (item)
		end

	set_secondary_grouping_size_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_secondary_grouping_size_ (item, a_number)
		end

	multiplier: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_multiplier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like multiplier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like multiplier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_multiplier_ (a_number: detachable NS_NUMBER)
			-- Auto generated Objective-C wrapper.
		local
			a_number__item: POINTER
		do
			if attached a_number as a_number_attached then
				a_number__item := a_number_attached.item
			end
			objc_set_multiplier_ (item, a_number__item)
		end

	format_width: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_format_width (item)
		end

	set_format_width_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_format_width_ (item, a_number)
		end

	padding_character: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_padding_character (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like padding_character} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like padding_character} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_padding_character_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_padding_character_ (item, a_string__item)
		end

	padding_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_padding_position (item)
		end

	set_padding_position_ (a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_padding_position_ (item, a_position)
		end

	rounding_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_rounding_mode (item)
		end

	set_rounding_mode_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_rounding_mode_ (item, a_mode)
		end

	rounding_increment: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_rounding_increment (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rounding_increment} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rounding_increment} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_rounding_increment_ (a_number: detachable NS_NUMBER)
			-- Auto generated Objective-C wrapper.
		local
			a_number__item: POINTER
		do
			if attached a_number as a_number_attached then
				a_number__item := a_number_attached.item
			end
			objc_set_rounding_increment_ (item, a_number__item)
		end

	minimum_integer_digits: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minimum_integer_digits (item)
		end

	set_minimum_integer_digits_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minimum_integer_digits_ (item, a_number)
		end

	maximum_integer_digits: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_integer_digits (item)
		end

	set_maximum_integer_digits_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_maximum_integer_digits_ (item, a_number)
		end

	minimum_fraction_digits: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minimum_fraction_digits (item)
		end

	set_minimum_fraction_digits_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minimum_fraction_digits_ (item, a_number)
		end

	maximum_fraction_digits: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_fraction_digits (item)
		end

	set_maximum_fraction_digits_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_maximum_fraction_digits_ (item, a_number)
		end

	minimum: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_minimum (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like minimum} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like minimum} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_minimum_ (a_number: detachable NS_NUMBER)
			-- Auto generated Objective-C wrapper.
		local
			a_number__item: POINTER
		do
			if attached a_number as a_number_attached then
				a_number__item := a_number_attached.item
			end
			objc_set_minimum_ (item, a_number__item)
		end

	maximum: detachable NS_NUMBER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_maximum (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like maximum} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like maximum} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_maximum_ (a_number: detachable NS_NUMBER)
			-- Auto generated Objective-C wrapper.
		local
			a_number__item: POINTER
		do
			if attached a_number as a_number_attached then
				a_number__item := a_number_attached.item
			end
			objc_set_maximum_ (item, a_number__item)
		end

	currency_grouping_separator: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_currency_grouping_separator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like currency_grouping_separator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like currency_grouping_separator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_currency_grouping_separator_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_currency_grouping_separator_ (item, a_string__item)
		end

	is_lenient: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_lenient (item)
		end

	set_lenient_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_lenient_ (item, a_b)
		end

	uses_significant_digits: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_significant_digits (item)
		end

	set_uses_significant_digits_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_significant_digits_ (item, a_b)
		end

	minimum_significant_digits: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minimum_significant_digits (item)
		end

	set_minimum_significant_digits_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minimum_significant_digits_ (item, a_number)
		end

	maximum_significant_digits: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_maximum_significant_digits (item)
		end

	set_maximum_significant_digits_ (a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_maximum_significant_digits_ (item, a_number)
		end

	is_partial_string_validation_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_partial_string_validation_enabled (item)
		end

	set_partial_string_validation_enabled_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_partial_string_validation_enabled_ (item, a_b)
		end

feature {NONE} -- NSNumberFormatter Externals

--	objc_get_object_value__for_string__range__error_ (an_item: POINTER; a_obj: UNSUPPORTED_TYPE; a_string: POINTER; a_rangep: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSNumberFormatter *)$an_item getObjectValue: forString:$a_string range: error:];
--			 ]"
--		end

	objc_string_from_number_ (an_item: POINTER; a_number: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item stringFromNumber:$a_number];
			 ]"
		end

	objc_number_from_string_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item numberFromString:$a_string];
			 ]"
		end

	objc_number_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item numberStyle];
			 ]"
		end

	objc_set_number_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNumberStyle:$a_style];
			 ]"
		end

	objc_locale (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item locale];
			 ]"
		end

	objc_set_locale_ (an_item: POINTER; a_locale: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setLocale:$a_locale];
			 ]"
		end

	objc_generates_decimal_numbers (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item generatesDecimalNumbers];
			 ]"
		end

	objc_set_generates_decimal_numbers_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setGeneratesDecimalNumbers:$a_b];
			 ]"
		end

	objc_formatter_behavior (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item formatterBehavior];
			 ]"
		end

	objc_set_formatter_behavior_ (an_item: POINTER; a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setFormatterBehavior:$a_behavior];
			 ]"
		end

	objc_negative_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item negativeFormat];
			 ]"
		end

	objc_set_negative_format_ (an_item: POINTER; a_format: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNegativeFormat:$a_format];
			 ]"
		end

	objc_text_attributes_for_negative_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForNegativeValues];
			 ]"
		end

	objc_set_text_attributes_for_negative_values_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForNegativeValues:$a_new_attributes];
			 ]"
		end

	objc_positive_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item positiveFormat];
			 ]"
		end

	objc_set_positive_format_ (an_item: POINTER; a_format: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPositiveFormat:$a_format];
			 ]"
		end

	objc_text_attributes_for_positive_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForPositiveValues];
			 ]"
		end

	objc_set_text_attributes_for_positive_values_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForPositiveValues:$a_new_attributes];
			 ]"
		end

	objc_allows_floats (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item allowsFloats];
			 ]"
		end

	objc_set_allows_floats_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setAllowsFloats:$a_flag];
			 ]"
		end

	objc_decimal_separator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item decimalSeparator];
			 ]"
		end

	objc_set_decimal_separator_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setDecimalSeparator:$a_string];
			 ]"
		end

	objc_always_shows_decimal_separator (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item alwaysShowsDecimalSeparator];
			 ]"
		end

	objc_set_always_shows_decimal_separator_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setAlwaysShowsDecimalSeparator:$a_b];
			 ]"
		end

	objc_currency_decimal_separator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item currencyDecimalSeparator];
			 ]"
		end

	objc_set_currency_decimal_separator_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setCurrencyDecimalSeparator:$a_string];
			 ]"
		end

	objc_uses_grouping_separator (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item usesGroupingSeparator];
			 ]"
		end

	objc_set_uses_grouping_separator_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setUsesGroupingSeparator:$a_b];
			 ]"
		end

	objc_grouping_separator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item groupingSeparator];
			 ]"
		end

	objc_set_grouping_separator_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setGroupingSeparator:$a_string];
			 ]"
		end

	objc_zero_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item zeroSymbol];
			 ]"
		end

	objc_set_zero_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setZeroSymbol:$a_string];
			 ]"
		end

	objc_text_attributes_for_zero (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForZero];
			 ]"
		end

	objc_set_text_attributes_for_zero_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForZero:$a_new_attributes];
			 ]"
		end

	objc_nil_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item nilSymbol];
			 ]"
		end

	objc_set_nil_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNilSymbol:$a_string];
			 ]"
		end

	objc_text_attributes_for_nil (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForNil];
			 ]"
		end

	objc_set_text_attributes_for_nil_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForNil:$a_new_attributes];
			 ]"
		end

	objc_not_a_number_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item notANumberSymbol];
			 ]"
		end

	objc_set_not_a_number_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNotANumberSymbol:$a_string];
			 ]"
		end

	objc_text_attributes_for_not_a_number (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForNotANumber];
			 ]"
		end

	objc_set_text_attributes_for_not_a_number_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForNotANumber:$a_new_attributes];
			 ]"
		end

	objc_positive_infinity_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item positiveInfinitySymbol];
			 ]"
		end

	objc_set_positive_infinity_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPositiveInfinitySymbol:$a_string];
			 ]"
		end

	objc_text_attributes_for_positive_infinity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForPositiveInfinity];
			 ]"
		end

	objc_set_text_attributes_for_positive_infinity_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForPositiveInfinity:$a_new_attributes];
			 ]"
		end

	objc_negative_infinity_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item negativeInfinitySymbol];
			 ]"
		end

	objc_set_negative_infinity_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNegativeInfinitySymbol:$a_string];
			 ]"
		end

	objc_text_attributes_for_negative_infinity (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item textAttributesForNegativeInfinity];
			 ]"
		end

	objc_set_text_attributes_for_negative_infinity_ (an_item: POINTER; a_new_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setTextAttributesForNegativeInfinity:$a_new_attributes];
			 ]"
		end

	objc_positive_prefix (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item positivePrefix];
			 ]"
		end

	objc_set_positive_prefix_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPositivePrefix:$a_string];
			 ]"
		end

	objc_positive_suffix (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item positiveSuffix];
			 ]"
		end

	objc_set_positive_suffix_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPositiveSuffix:$a_string];
			 ]"
		end

	objc_negative_prefix (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item negativePrefix];
			 ]"
		end

	objc_set_negative_prefix_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNegativePrefix:$a_string];
			 ]"
		end

	objc_negative_suffix (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item negativeSuffix];
			 ]"
		end

	objc_set_negative_suffix_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setNegativeSuffix:$a_string];
			 ]"
		end

	objc_currency_code (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item currencyCode];
			 ]"
		end

	objc_set_currency_code_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setCurrencyCode:$a_string];
			 ]"
		end

	objc_currency_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item currencySymbol];
			 ]"
		end

	objc_set_currency_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setCurrencySymbol:$a_string];
			 ]"
		end

	objc_international_currency_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item internationalCurrencySymbol];
			 ]"
		end

	objc_set_international_currency_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setInternationalCurrencySymbol:$a_string];
			 ]"
		end

	objc_percent_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item percentSymbol];
			 ]"
		end

	objc_set_percent_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPercentSymbol:$a_string];
			 ]"
		end

	objc_per_mill_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item perMillSymbol];
			 ]"
		end

	objc_set_per_mill_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPerMillSymbol:$a_string];
			 ]"
		end

	objc_minus_sign (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item minusSign];
			 ]"
		end

	objc_set_minus_sign_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMinusSign:$a_string];
			 ]"
		end

	objc_plus_sign (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item plusSign];
			 ]"
		end

	objc_set_plus_sign_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPlusSign:$a_string];
			 ]"
		end

	objc_exponent_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item exponentSymbol];
			 ]"
		end

	objc_set_exponent_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setExponentSymbol:$a_string];
			 ]"
		end

	objc_grouping_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item groupingSize];
			 ]"
		end

	objc_set_grouping_size_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setGroupingSize:$a_number];
			 ]"
		end

	objc_secondary_grouping_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item secondaryGroupingSize];
			 ]"
		end

	objc_set_secondary_grouping_size_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setSecondaryGroupingSize:$a_number];
			 ]"
		end

	objc_multiplier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item multiplier];
			 ]"
		end

	objc_set_multiplier_ (an_item: POINTER; a_number: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMultiplier:$a_number];
			 ]"
		end

	objc_format_width (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item formatWidth];
			 ]"
		end

	objc_set_format_width_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setFormatWidth:$a_number];
			 ]"
		end

	objc_padding_character (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item paddingCharacter];
			 ]"
		end

	objc_set_padding_character_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPaddingCharacter:$a_string];
			 ]"
		end

	objc_padding_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item paddingPosition];
			 ]"
		end

	objc_set_padding_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPaddingPosition:$a_position];
			 ]"
		end

	objc_rounding_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item roundingMode];
			 ]"
		end

	objc_set_rounding_mode_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setRoundingMode:$a_mode];
			 ]"
		end

	objc_rounding_increment (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item roundingIncrement];
			 ]"
		end

	objc_set_rounding_increment_ (an_item: POINTER; a_number: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setRoundingIncrement:$a_number];
			 ]"
		end

	objc_minimum_integer_digits (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item minimumIntegerDigits];
			 ]"
		end

	objc_set_minimum_integer_digits_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMinimumIntegerDigits:$a_number];
			 ]"
		end

	objc_maximum_integer_digits (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item maximumIntegerDigits];
			 ]"
		end

	objc_set_maximum_integer_digits_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMaximumIntegerDigits:$a_number];
			 ]"
		end

	objc_minimum_fraction_digits (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item minimumFractionDigits];
			 ]"
		end

	objc_set_minimum_fraction_digits_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMinimumFractionDigits:$a_number];
			 ]"
		end

	objc_maximum_fraction_digits (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item maximumFractionDigits];
			 ]"
		end

	objc_set_maximum_fraction_digits_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMaximumFractionDigits:$a_number];
			 ]"
		end

	objc_minimum (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item minimum];
			 ]"
		end

	objc_set_minimum_ (an_item: POINTER; a_number: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMinimum:$a_number];
			 ]"
		end

	objc_maximum (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item maximum];
			 ]"
		end

	objc_set_maximum_ (an_item: POINTER; a_number: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMaximum:$a_number];
			 ]"
		end

	objc_currency_grouping_separator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item currencyGroupingSeparator];
			 ]"
		end

	objc_set_currency_grouping_separator_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setCurrencyGroupingSeparator:$a_string];
			 ]"
		end

	objc_is_lenient (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item isLenient];
			 ]"
		end

	objc_set_lenient_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setLenient:$a_b];
			 ]"
		end

	objc_uses_significant_digits (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item usesSignificantDigits];
			 ]"
		end

	objc_set_uses_significant_digits_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setUsesSignificantDigits:$a_b];
			 ]"
		end

	objc_minimum_significant_digits (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item minimumSignificantDigits];
			 ]"
		end

	objc_set_minimum_significant_digits_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMinimumSignificantDigits:$a_number];
			 ]"
		end

	objc_maximum_significant_digits (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item maximumSignificantDigits];
			 ]"
		end

	objc_set_maximum_significant_digits_ (an_item: POINTER; a_number: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setMaximumSignificantDigits:$a_number];
			 ]"
		end

	objc_is_partial_string_validation_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item isPartialStringValidationEnabled];
			 ]"
		end

	objc_set_partial_string_validation_enabled_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setPartialStringValidationEnabled:$a_b];
			 ]"
		end

feature -- NSNumberFormatterCompatibility

	has_thousand_separators: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_thousand_separators (item)
		end

	set_has_thousand_separators_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_has_thousand_separators_ (item, a_flag)
		end

	thousand_separator: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_thousand_separator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like thousand_separator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like thousand_separator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_thousand_separator_ (a_new_separator: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_new_separator__item: POINTER
		do
			if attached a_new_separator as a_new_separator_attached then
				a_new_separator__item := a_new_separator_attached.item
			end
			objc_set_thousand_separator_ (item, a_new_separator__item)
		end

	localizes_format: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_localizes_format (item)
		end

	set_localizes_format_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_localizes_format_ (item, a_flag)
		end

	format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_format_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_format_ (item, a_string__item)
		end

	attributed_string_for_zero: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_string_for_zero (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string_for_zero} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string_for_zero} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_string_for_zero_ (a_new_attributed_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributed_string__item: POINTER
		do
			if attached a_new_attributed_string as a_new_attributed_string_attached then
				a_new_attributed_string__item := a_new_attributed_string_attached.item
			end
			objc_set_attributed_string_for_zero_ (item, a_new_attributed_string__item)
		end

	attributed_string_for_nil: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_string_for_nil (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string_for_nil} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string_for_nil} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_string_for_nil_ (a_new_attributed_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributed_string__item: POINTER
		do
			if attached a_new_attributed_string as a_new_attributed_string_attached then
				a_new_attributed_string__item := a_new_attributed_string_attached.item
			end
			objc_set_attributed_string_for_nil_ (item, a_new_attributed_string__item)
		end

	attributed_string_for_not_a_number: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_string_for_not_a_number (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string_for_not_a_number} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string_for_not_a_number} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_string_for_not_a_number_ (a_new_attributed_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_new_attributed_string__item: POINTER
		do
			if attached a_new_attributed_string as a_new_attributed_string_attached then
				a_new_attributed_string__item := a_new_attributed_string_attached.item
			end
			objc_set_attributed_string_for_not_a_number_ (item, a_new_attributed_string__item)
		end

	rounding_behavior: detachable NS_DECIMAL_NUMBER_HANDLER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_rounding_behavior (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rounding_behavior} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rounding_behavior} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_rounding_behavior_ (a_new_rounding_behavior: detachable NS_DECIMAL_NUMBER_HANDLER)
			-- Auto generated Objective-C wrapper.
		local
			a_new_rounding_behavior__item: POINTER
		do
			if attached a_new_rounding_behavior as a_new_rounding_behavior_attached then
				a_new_rounding_behavior__item := a_new_rounding_behavior_attached.item
			end
			objc_set_rounding_behavior_ (item, a_new_rounding_behavior__item)
		end

feature {NONE} -- NSNumberFormatterCompatibility Externals

	objc_has_thousand_separators (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item hasThousandSeparators];
			 ]"
		end

	objc_set_has_thousand_separators_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setHasThousandSeparators:$a_flag];
			 ]"
		end

	objc_thousand_separator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item thousandSeparator];
			 ]"
		end

	objc_set_thousand_separator_ (an_item: POINTER; a_new_separator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setThousandSeparator:$a_new_separator];
			 ]"
		end

	objc_localizes_format (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSNumberFormatter *)$an_item localizesFormat];
			 ]"
		end

	objc_set_localizes_format_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setLocalizesFormat:$a_flag];
			 ]"
		end

	objc_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item format];
			 ]"
		end

	objc_set_format_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setFormat:$a_string];
			 ]"
		end

	objc_attributed_string_for_zero (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item attributedStringForZero];
			 ]"
		end

	objc_set_attributed_string_for_zero_ (an_item: POINTER; a_new_attributed_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setAttributedStringForZero:$a_new_attributed_string];
			 ]"
		end

	objc_attributed_string_for_nil (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item attributedStringForNil];
			 ]"
		end

	objc_set_attributed_string_for_nil_ (an_item: POINTER; a_new_attributed_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setAttributedStringForNil:$a_new_attributed_string];
			 ]"
		end

	objc_attributed_string_for_not_a_number (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item attributedStringForNotANumber];
			 ]"
		end

	objc_set_attributed_string_for_not_a_number_ (an_item: POINTER; a_new_attributed_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setAttributedStringForNotANumber:$a_new_attributed_string];
			 ]"
		end

	objc_rounding_behavior (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNumberFormatter *)$an_item roundingBehavior];
			 ]"
		end

	objc_set_rounding_behavior_ (an_item: POINTER; a_new_rounding_behavior: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNumberFormatter *)$an_item setRoundingBehavior:$a_new_rounding_behavior];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNumberFormatter"
		end

end
