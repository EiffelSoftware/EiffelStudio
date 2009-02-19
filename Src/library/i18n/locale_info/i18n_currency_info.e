note
	description: "Encapsulates information about currency formatting"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class I18N_CURRENCY_INFO

create
	make

feature {NONE} -- Initialization

	make
			-- initialize all fields
		do
			set_currency_symbol (default_currency_symbol)
			set_currency_symbol_location (default_currency_symbol_location)
			set_currency_decimal_separator (default_currency_decimal_separator)
			set_currency_numbers_after_decimal_separator (default_currency_numbers_after_decimal_separator)
			set_currency_group_separator (default_currency_group_separator)
			set_currency_number_list_separator (default_currency_number_list_separator)
			set_currency_positive_sign (default_currency_positive_sign)
			set_currency_negative_sign (default_currency_negative_sign)
			set_currency_grouping (default_currency_grouping)

			set_international_currency_symbol (default_currency_symbol)
			set_international_currency_symbol_location (default_currency_symbol_location)
			set_international_currency_decimal_separator (default_currency_decimal_separator)
			set_international_currency_numbers_after_decimal_separator (default_currency_numbers_after_decimal_separator)
			set_international_currency_group_separator (default_currency_group_separator)
			set_international_currency_number_list_separator (default_currency_number_list_separator)
			set_international_currency_grouping (default_currency_grouping)

		end

feature	-- Access: Normal currency informations

	currency_symbol: STRING_32
	currency_symbol_location: INTEGER
	currency_symbol_prefixed: INTEGER = 0
	currency_symbol_appended: INTEGER = 1
	currency_symbol_radix: INTEGER = 2
	currency_decimal_separator: STRING_32
	currency_numbers_after_decimal_separator: INTEGER
	currency_group_separator: STRING_32
	currency_number_list_separator: STRING_32
	currency_positive_sign: STRING_32
	currency_negative_sign: STRING_32
	currency_grouping: ARRAY[INTEGER]

feature -- Access: International currency informations

	currency_international_symbol: STRING_32
	currency_international_symbol_location: INTEGER
	currency_international_symbol_prefixed: INTEGER = 0
	currency_international_symbol_appended: INTEGER = 1
	currency_international_symbol_radix: INTEGER = 2
	currency_international_decimal_separator: STRING_32
	currency_international_numbers_after_decimal_separator: INTEGER
	currency_international_group_separator: STRING_32
	currency_international_number_list_separator: STRING_32
	currency_international_grouping: ARRAY[INTEGER]

feature -- Access: Default values

	default_currency_symbol: STRING_32
		once
			Result := ""
		end

	default_currency_decimal_separator: STRING_32
		once
			Result := "."
		end

	default_currency_symbol_location: INTEGER = 0

	default_currency_numbers_after_decimal_separator: INTEGER = 2

	default_currency_group_separator: STRING_32
		once
			Result := ","
		end

	default_currency_number_list_separator: STRING_32
		once
			Result := ";"
		end

	default_currency_positive_sign: STRING_32
		once
			Result := ""
		end


	default_currency_negative_sign: STRING_32
		once
			Result := "-"
		end

	default_currency_grouping: ARRAY[INTEGER]
		once
			Result := <<3,3,0>>
		end

feature -- Element change: Normal values

	set_currency_symbol (a_currency_symbol : STRING_GENERAL)
			-- set the currency symbol
		require
			a_currency_symbol_exists: a_currency_symbol /= Void
		do
			currency_symbol := a_currency_symbol
		ensure
			symbol_set: currency_symbol = a_currency_symbol
		end

	set_currency_symbol_location(a_location:INTEGER)
			-- set the currency symbol location
		require
			a_location_valid: (a_location >= 0) and (a_location <= 2)
		do
			currency_symbol_location := a_location
		ensure
			symbol_location_set: currency_symbol_location = a_location
		end

	set_currency_decimal_separator(separator:STRING_GENERAL)
			-- set the decimal separator for currency values
		require
			argument_not_void: separator /= Void
		do
			currency_decimal_separator := separator.to_string_32
		ensure
			currency_decimal_separator_set: currency_decimal_separator.is_equal(separator.as_string_32)
		end

	set_currency_numbers_after_decimal_separator(numbers:INTEGER)
			-- set the amount of numbers after a decimal separator in a currency value
		require
			numbers_positive: numbers >= 0
		do
			currency_numbers_after_decimal_separator := numbers
		ensure
			currency_numbers_after_decimal_separator_set: currency_numbers_after_decimal_separator = numbers
		end

	set_currency_group_separator(separator:STRING_GENERAL)
			-- set the group separator for curency values - sometimes called "thousands separator"
		require
			argument_not_void: separator /= Void
		do
			currency_group_separator := separator.to_string_32
		ensure
			currency_group_separator_set: currency_group_separator.is_equal(separator.as_string_32)
		end

	set_currency_number_list_separator(separator:STRING_GENERAL)
			-- set the  separator for lists of currency values
		require
			argument_not_void: separator /= Void
		do
			currency_number_list_separator := separator.to_string_32
		ensure
			currency_number_list_separator_set: currency_number_list_separator.is_equal(separator.as_string_32)
		end

	set_currency_positive_sign (a_string: STRING_GENERAL)
			-- set positive sign used
		require
			argument_not_void: a_string/= Void
		do
			currency_positive_sign :=	a_string.to_string_32
		ensure
			currency_positive_sign_set: currency_positive_sign.is_equal (a_string.as_string_32)
		end

	set_currency_negative_sign (a_string: STRING_GENERAL)
			-- set negative sign used
		require
			argument_not_void: a_string/= Void
		do
			currency_negative_sign :=	a_string.to_string_32
		ensure
			currency_negative_sign_set: currency_negative_sign.is_equal (a_string.as_string_32)
		end

	set_currency_grouping (a_array: ARRAY[INTEGER])
			-- set the grouping rules
		require
			a_array_exists: a_array /= Void
		do
			currency_grouping := a_array
		ensure
			grouping_set: currency_grouping = a_array
		end

feature -- Element change: International values

	set_international_currency_symbol (a_currency_symbol : STRING_GENERAL)
			-- set the international currency symbol
		require
			a_currency_symbol_exists: a_currency_symbol /= Void
		do
			currency_international_symbol := a_currency_symbol
		ensure
			symbol_set: currency_international_symbol = a_currency_symbol
		end

	set_international_currency_symbol_location(a_location:INTEGER)
			-- set the international currency symbol location
		require
			a_location_valid: (a_location >= 0) and (a_location <= 2)
		do
			currency_international_symbol_location := a_location
		ensure
			symbol_location_set: currency_international_symbol_location = a_location
		end

	set_international_currency_decimal_separator(separator:STRING_GENERAL)
			-- set the decimal separator for currency values
		require
			argument_not_void: separator /= Void
		do
			currency_international_decimal_separator := separator.to_string_32
		ensure
			currency_decimal_separator_set: currency_international_decimal_separator.is_equal(separator.as_string_32)
		end

	set_international_currency_numbers_after_decimal_separator(numbers:INTEGER)
			-- set the amount of numbers after a decimal separator in a currency value
		require
			numbers_positive: numbers >= 0
		do
			currency_international_numbers_after_decimal_separator := numbers
		ensure
			currency_international_numbers_after_decimal_separator_set: currency_numbers_after_decimal_separator = numbers
		end

	set_international_currency_group_separator(separator:STRING_GENERAL)
			-- set the group separator for curency values - sometimes called "thousands separator"
		require
			argument_not_void: separator /= Void
		do
			currency_international_group_separator := separator.to_string_32
		ensure
			currency_group_separator_set: currency_international_group_separator.is_equal(separator.as_string_32)
		end

	set_international_currency_number_list_separator(separator:STRING_GENERAL)
			-- set the  separator for lists of currency values
		require
			argument_not_void: separator /= Void
		do
			currency_international_number_list_separator := separator.to_string_32
		ensure
			currency_number_list_separator_set: currency_international_number_list_separator.is_equal(separator.as_string_32)
		end

	set_international_currency_grouping (a_array: ARRAY[INTEGER])
			-- set the grouping rules
		require
			a_array_exists: a_array /= Void
		do
			currency_international_grouping := a_array
		ensure
			grouping_set: currency_international_grouping = a_array
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
