note
	description: "Class that encapsulates value formatting information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NUMERIC_INFO

create
	make

feature {NONE} -- Initialization

	make
			-- initialize all fields
		do
			set_value_decimal_separator (default_value_decimal_separator)
			set_value_numbers_after_decimal_separator (default_value_numbers_after_decimal_separator)
			set_value_group_separator (default_value_group_separator)
			set_value_number_list_separator (default_value_number_list_separator)
			set_value_grouping (default_value_grouping)
			set_value_positive_sign (default_positive_sign)
			set_value_negative_sign (default_negative_sign)
		end

feature	-- Access: Number formatting

	value_decimal_separator: STRING_32
	value_numbers_after_decimal_separator: INTEGER
	value_group_separator: STRING_32
	value_number_list_separator: STRING_32
	value_positive_sign: STRING_32
	value_negative_sign: STRING_32
	value_grouping: ARRAY[INTEGER]

feature -- Access: Default values

	default_value_decimal_separator: STRING_32
		once
			Result := "."
		end

	default_value_numbers_after_decimal_separator: INTEGER = 2

	default_value_group_separator: STRING_32
		once
			Result := ","
		end

	default_value_number_list_separator: STRING_32
		once
			Result := ";"
		end

	default_positive_sign: STRING_32
		once
			Result := ""
		end

	default_negative_sign: STRING_32
		once
			Result := "-"
		end

	default_value_grouping: ARRAY[INTEGER]
		once
			Result := << 3, 3, 0 >>
		end

feature -- Element change

	set_value_decimal_separator(separator:STRING_GENERAL)
			-- set the decimal separator for values
		require
			argument_not_void: separator /= Void
		do
			value_decimal_separator := separator.to_string_32
		ensure
			value_decimal_separator_set: value_decimal_separator.is_equal(separator.as_string_32)
		end

	set_value_numbers_after_decimal_separator(numbers:INTEGER)
			-- set the amount of numbers after a decimal separator in a numeric value
		require
			numbers_positive: numbers >= 0
		do
			value_numbers_after_decimal_separator := numbers
		ensure
			value_numbers_after_decimal_separator_set: value_numbers_after_decimal_separator = numbers
		end

	set_value_group_separator(separator:STRING_GENERAL)
			-- set the group separator for values - sometimes called "thousands separator"
		require
			argument_not_void: separator /= Void
		do
			value_group_separator := separator.to_string_32
		ensure
			value_group_separator_set: value_group_separator.is_equal(separator.as_string_32)
		end

	set_value_number_list_separator(separator:STRING_GENERAL)
			-- set the  separator for lists of numbers
		require
			argument_not_void: separator /= Void
		do
			value_number_list_separator := separator.to_string_32
		ensure
			value_number_list_separator_set: value_number_list_separator.is_equal(separator.as_string_32)
		end

	set_value_positive_sign (a_string: STRING_GENERAL)
			-- set the positive sign to use
		require
			argument_not_void: a_string /= Void
		do
			value_positive_sign := a_string
		ensure
			value_positive_sign_set: value_positive_sign.is_equal (a_string)
		end

	set_value_negative_sign (a_string: STRING_GENERAL)
			-- set the negative sign to use
		require
			argument_not_void: a_string /= Void
		do
			value_negative_sign := a_string
		ensure
			value_negative_sign_set: value_negative_sign.is_equal (a_string)
		end

	set_value_grouping (a_array: ARRAY[INTEGER])
			-- set the grouping rules
		require
			a_array_exists: a_array /= Void
		do
			value_grouping := a_array
		ensure
			groiping_set: value_grouping = a_array
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
