indexing
	description: "Encapsulates information about currency formatting"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class I18N_CURRENCY_INFO

create
	make

feature -- Initialization

	make is
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

feature	-- Normal currency Informations

	currency_symbol: STRING_32
	currency_symbol_location: INTEGER
	currency_symbol_prefixed: INTEGER is 0
	currency_symbol_appended: INTEGER is 1
	currency_symbol_radix: INTEGER is 2
	currency_decimal_separator: STRING_32
	currency_numbers_after_decimal_separator: INTEGER
	currency_group_separator: STRING_32
	currency_number_list_separator: STRING_32
	currency_positive_sign: STRING_32
	currency_negative_sign: STRING_32
	currency_grouping: ARRAY[INTEGER]

feature -- International currency Informations

	currency_international_symbol: STRING_32
	currency_international_symbol_location: INTEGER
	currency_international_symbol_prefixed: INTEGER is 0
	currency_international_symbol_appended: INTEGER is 1
	currency_international_symbol_radix: INTEGER is 2
	currency_international_decimal_separator: STRING_32
	currency_international_numbers_after_decimal_separator: INTEGER
	currency_international_group_separator: STRING_32
	currency_international_number_list_separator: STRING_32
	currency_international_grouping: ARRAY[INTEGER]

feature -- Default values

	default_currency_symbol: STRING_32 is
		once
			Result := ""
		end

	default_currency_decimal_separator: STRING_32 is
		once
			Result := "."
		end

	default_currency_symbol_location: INTEGER is 0

	default_currency_numbers_after_decimal_separator: INTEGER is 2

	default_currency_group_separator: STRING_32 is
		once
			Result := ","
		end

	default_currency_number_list_separator: STRING_32 is
		once
			Result := ";"
		end

	default_currency_positive_sign: STRING_32 is
		once
			Result := ""
		end


	default_currency_negative_sign: STRING_32 is
		once
			Result := "-"
		end

	default_currency_grouping: ARRAY[INTEGER] is
		once
			Result := <<3,3,0>>
		end

feature -- Normal Element change

	set_currency_symbol (a_currency_symbol : STRING_GENERAL) is
			-- set the currency symbol
		require
			a_currency_symbol_exists: a_currency_symbol /= Void
		do
			currency_symbol := a_currency_symbol
		ensure
			symbol_set: currency_symbol = a_currency_symbol
		end

	set_currency_symbol_location(a_location:INTEGER) is
			-- set the currency symbol location
		require
			a_location_valid: (a_location >= 0) and (a_location <= 2)
		do
			currency_symbol_location := a_location
		ensure
			symbol_location_set: currency_symbol_location = a_location
		end

	set_currency_decimal_separator(separator:STRING_GENERAL) is
			-- set the decimal separator for currency values
		require
			argument_not_void: separator /= Void
		do
			currency_decimal_separator := separator.to_string_32
		ensure
			currency_decimal_separator_set: currency_decimal_separator.is_equal(separator.as_string_32)
		end

	set_currency_numbers_after_decimal_separator(numbers:INTEGER) is
			-- set the amount of numbers after a decimal separator in a currency value
		require
			numbers_positive: numbers >= 0
		do
			currency_numbers_after_decimal_separator := numbers
		ensure
			currency_numbers_after_decimal_separator_set: currency_numbers_after_decimal_separator = numbers
		end

	set_currency_group_separator(separator:STRING_GENERAL) is
			-- set the group separator for curency values - sometimes called "thousands separator"
		require
			argument_not_void: separator /= Void
		do
			currency_group_separator := separator.to_string_32
		ensure
			currency_group_separator_set: currency_group_separator.is_equal(separator.as_string_32)
		end

	set_currency_number_list_separator(separator:STRING_GENERAL) is
			-- set the  separator for lists of currency values
		require
			argument_not_void: separator /= Void
		do
			currency_number_list_separator := separator.to_string_32
		ensure
			currency_number_list_separator_set: currency_number_list_separator.is_equal(separator.as_string_32)
		end

	set_currency_positive_sign (a_string: STRING_GENERAL) is
			-- set positive sign used
		require
			argument_not_void: a_string/= Void
		do
			currency_positive_sign :=	a_string.to_string_32
		ensure
			currency_positive_sign_set: currency_positive_sign.is_equal (a_string.as_string_32)
		end

	set_currency_negative_sign (a_string: STRING_GENERAL) is
			-- set negative sign used
		require
			argument_not_void: a_string/= Void
		do
			currency_negative_sign :=	a_string.to_string_32
		ensure
			currency_negative_sign_set: currency_negative_sign.is_equal (a_string.as_string_32)
		end

	set_currency_grouping (a_array: ARRAY[INTEGER]) is
			-- set the grouping rules
		require
			a_array_exists: a_array /= Void
		do
			currency_grouping := a_array
		ensure
			grouping_set: currency_grouping = a_array
		end

feature -- International Element change

	set_international_currency_symbol (a_currency_symbol : STRING_GENERAL) is
			-- set the international currency symbol
		require
			a_currency_symbol_exists: a_currency_symbol /= Void
		do
			currency_international_symbol := a_currency_symbol
		ensure
			symbol_set: currency_international_symbol = a_currency_symbol
		end

	set_international_currency_symbol_location(a_location:INTEGER) is
			-- set the international currency symbol location
		require
			a_location_valid: (a_location >= 0) and (a_location <= 2)
		do
			currency_international_symbol_location := a_location
		ensure
			symbol_location_set: currency_international_symbol_location = a_location
		end

	set_international_currency_decimal_separator(separator:STRING_GENERAL) is
			-- set the decimal separator for currency values
		require
			argument_not_void: separator /= Void
		do
			currency_international_decimal_separator := separator.to_string_32
		ensure
			currency_decimal_separator_set: currency_international_decimal_separator.is_equal(separator.as_string_32)
		end

	set_international_currency_numbers_after_decimal_separator(numbers:INTEGER) is
			-- set the amount of numbers after a decimal separator in a currency value
		require
			numbers_positive: numbers >= 0
		do
			currency_international_numbers_after_decimal_separator := numbers
		ensure
			currency_international_numbers_after_decimal_separator_set: currency_numbers_after_decimal_separator = numbers
		end

	set_international_currency_group_separator(separator:STRING_GENERAL) is
			-- set the group separator for curency values - sometimes called "thousands separator"
		require
			argument_not_void: separator /= Void
		do
			currency_international_group_separator := separator.to_string_32
		ensure
			currency_group_separator_set: currency_international_group_separator.is_equal(separator.as_string_32)
		end

	set_international_currency_number_list_separator(separator:STRING_GENERAL) is
			-- set the  separator for lists of currency values
		require
			argument_not_void: separator /= Void
		do
			currency_international_number_list_separator := separator.to_string_32
		ensure
			currency_number_list_separator_set: currency_international_number_list_separator.is_equal(separator.as_string_32)
		end

	set_international_currency_grouping (a_array: ARRAY[INTEGER]) is
			-- set the grouping rules
		require
			a_array_exists: a_array /= Void
		do
			currency_international_grouping := a_array
		ensure
			grouping_set: currency_international_grouping = a_array
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
