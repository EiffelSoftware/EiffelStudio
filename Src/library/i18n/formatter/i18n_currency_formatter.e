note
	description: "Class that can format a currency value according to the rules in a CURRENCY_INFO"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_CURRENCY_FORMATTER

create
	make

feature  -- Initialization

	make (a_currency_info: I18N_CURRENCY_INFO)
			-- Initialization
		require
			a_currency_info_exists: a_currency_info /= Void
		do
			currency_symbol_location := a_currency_info.currency_symbol_location
			currency_symbol := a_currency_info.currency_symbol
			create currency_value_formatter.make_from_currency_info (a_currency_info)
		end

feature -- Utility

	format_currency (a_value: REAL_64): STRING_32
			-- format a_value according the `format_string'
			--if unknoen location, result done with Prefix rules
		do
			if currency_symbol_location= {I18N_CURRENCY_INFO}.currency_symbol_prefixed then
				create Result.make_from_string (currency_symbol+" "+
												  currency_value_formatter.format_real_64 (a_value))
			elseif currency_symbol_location= {I18N_CURRENCY_INFO}.currency_symbol_appended then
				create Result.make_from_string (currency_value_formatter.format_real_64 (a_value)
												+" "+currency_symbol)
			elseif currency_symbol_location= {I18N_CURRENCY_INFO}.currency_symbol_radix then
				create Result.make_from_string (currency_value_formatter.format_real_64 (a_value))
			else
					-- default: prefixed
				create Result.make_from_string (currency_symbol+" "+
												  currency_value_formatter.format_real_64 (a_value))
			end
		ensure
			result_exists: Result /= Void
		end


feature {NONE} -- Implementation

	currency_symbol: STRING_32
		-- the currency symbol

	currency_symbol_location: INTEGER
		-- location of currency_symbol

	currency_value_formatter: I18N_CURRENCY_VALUE_FORMATTER

invariant
	currency_symbol_exist: currency_symbol /= Void
	currency_value_formatter_exists: currency_value_formatter /= Void

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
