note
	description: "Class that allows formatting of the numerical part of a monetary quantity"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_CURRENCY_VALUE_FORMATTER

inherit
	I18N_VALUE_FORMATTER
		rename
			make as make_from_locale_info
		redefine
			make_from_locale_info
		end

create
	make_from_locale_info,
	make_from_currency_info

feature -- Initialization

	make_from_currency_info (a_currency_info: I18N_CURRENCY_INFO)
			-- Initialize values according
			-- the currency information in
			-- `a_locale_info'
		do
			decimal_separator := a_currency_info.currency_decimal_separator
					-- decimal separator
			numbers_after_decimal_separator := a_currency_info.currency_numbers_after_decimal_separator
					-- numbers after the decimal separator
			group_separator := a_currency_info.currency_group_separator
					-- separator character for thousands (groups of three digits)
 			grouping := a_currency_info.currency_grouping
					-- how the value are grouped
			positive_sign := a_currency_info.currency_positive_sign
			negative_sign := a_currency_info.currency_negative_sign
		end

	make_from_locale_info (a_locale_info: I18N_LOCALE_INFO)
			-- Initialize values according
			-- the currency information in
			-- `a_currency_info'
		do
			make_from_currency_info (a_locale_info)
		end

note
	library:   "Internationalization library"
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

