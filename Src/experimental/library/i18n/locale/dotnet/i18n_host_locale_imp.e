note
	description: "Implementation of I18N_HOST_LOCALE for .NET"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_HOST_LOCALE_IMP

inherit
	I18N_HOST_LOCALE
		undefine
			default_create
		end
	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create
			-- Default `culture_info' to `System.Globalization.CultureInfo.CurrentCulture'
		do
			check attached {CULTURE_INFO}.current_culture as l_culture then
				culture_info := l_culture
			end
		end

	create_locale_info_from_user_locale: I18N_LOCALE_INFO
			-- create locale form the user locale
		local
			l_locale_id: I18N_LOCALE_ID
		do
			check attached {CULTURE_INFO}.current_culture as l_info then
				create culture_info.make_from_name (l_info.name)
				if attached culture_info.name as l_culture_name then
					create l_locale_id.make_from_string (create {STRING_32}.make_from_cil (l_culture_name))
				else
					create l_locale_id.make ("en", "US", Void)
				end
				create Result.make
				fill (Result)
				Result.set_id (l_locale_id)
			end
		ensure then
			culture_info_exists: culture_info /= Void
		end

	create_locale_info (a_locale_id : I18N_LOCALE_ID): I18N_LOCALE_INFO
			-- Create locale with a_locale_id
		do
			if attached a_locale_id.name as l_name then
				create culture_info.make_from_name (format_id_to_dotnet (l_name))
			end
			create Result.make
			fill (Result)
			Result.set_id (a_locale_id)
		ensure then
			culture_info_exists : culture_info /= Void
		end

feature {NONE} -- Fill

	fill (a_locale_info: I18N_LOCALE_INFO)
			-- fill `a_locale_info' with all available informations
		require
			a_locale_info_exists: a_locale_info /= Void
		do
			fill_date_time_info (a_locale_info)
			fill_numeric_info (a_locale_info)
			fill_currency_info (a_locale_info)
		end

	fill_currency_info (a_currency_info: I18N_CURRENCY_INFO)
			-- fill a `a_currency_info' with currency infomation
		require
			a_currency_info_exists: a_currency_info /= Void
		do
			a_currency_info.set_currency_symbol (get_currency_symbol)
			a_currency_info.set_currency_decimal_separator (get_currency_decimal_separator)
			a_currency_info.set_currency_numbers_after_decimal_separator (get_currency_numbers_after_decimal_separator)
			a_currency_info.set_currency_group_separator (get_currency_group_separator)
			a_currency_info.set_currency_grouping (get_currency_grouping)
			a_currency_info.set_international_currency_symbol (get_int_currency_symbol)
			a_currency_info.set_international_currency_decimal_separator (get_int_currency_decimal_separator)
			a_currency_info.set_international_currency_numbers_after_decimal_separator (get_int_currency_numbers_after_decimal_separator)
			a_currency_info.set_international_currency_group_separator (get_int_currency_group_separator)
		end

	fill_date_time_info (a_date_time_info: I18N_DATE_TIME_INFO)
			-- fill `a_date_time_info' with date/time informations
		require
			a_date_time_info_exists: a_date_time_info /= Void
		do
			a_date_time_info.set_date_time_format (get_date_time_format)
			a_date_time_info.set_long_date_format (get_long_date_format)
			a_date_time_info.set_long_time_format (get_long_time_format)
			a_date_time_info.set_short_date_format (get_short_date_format)
			a_date_time_info.set_short_time_format (get_short_time_format)
			a_date_time_info.set_am_suffix (get_am_suffix)
			a_date_time_info.set_pm_suffix (get_pm_suffix)
			a_date_time_info.set_day_names (get_day_names)
			a_date_time_info.set_month_names (get_month_names)
			a_date_time_info.set_abbreviated_day_names (get_abbreviated_day_names)
			a_date_time_info.set_abbreviated_month_names (get_abbreviated_month_names)
		end

	fill_numeric_info (a_numeric_info: I18N_NUMERIC_INFO)
			-- fill `a_date_time_info' with numeric informations
		require
			a_date_time_info_exists: a_numeric_info /= Void
		do
			a_numeric_info.set_value_decimal_separator (get_value_decimal_separator)
			a_numeric_info.set_value_numbers_after_decimal_separator (get_value_numbers_after_decimal_separator)
			a_numeric_info.set_value_group_separator (get_value_group_separator)
			a_numeric_info.set_value_grouping (get_value_grouping)
		end



feature -- Element change

	set_locale (a_locale_name : STRING_32)
			-- set current locale to `a_locale_name'
		do
			if a_locale_name /= Void and then (attached {STRING} a_locale_name.string as l_name) then
				create culture_info.make_from_name (format_id_to_dotnet (l_name))
			end
		end

feature -- Informations

	is_available (a_locale_id : I18N_LOCALE_ID) : BOOLEAN
			-- I guess it is always true
		local
			l_list: LINKED_LIST [I18N_LOCALE_ID]
		do
			l_list := available_locales
			from
				l_list.start
			until
				l_list.after or else Result
			loop
				Result := l_list.item.is_equal (a_locale_id)
				l_list.forth
			end
		end

	available_locales : LINKED_LIST [I18N_LOCALE_ID]
			-- get list of available locales
		local
			l_list: detachable NATIVE_ARRAY [detachable CULTURE_INFO]
			i : INTEGER
			l_locale_id: I18N_LOCALE_ID
		do
			create Result.make
			l_list := culture_info.get_cultures ({CULTURE_TYPES}.specific_cultures)
			if l_list /= Void then
				from
					i := l_list.lower
				until
					i > l_list.upper
				loop
					if
						attached l_list.item (i) as l_culture and then
						attached l_culture.name as l_culture_name
					then
						create l_locale_id.make_from_string (create {STRING_32}.make_from_cil (l_culture_name))
						Result.extend (l_locale_id.twin)
					end
					i := i + 1
				variant
					l_list.count-i+1
				end
			end
		end

	current_locale_id : I18N_LOCALE_ID
			-- return the current locale info
		do
			if
				attached culture_info.current_culture as l_culture_info and then
				attached l_culture_info.name as l_name
			then
				create Result.make_from_string (create {STRING_32}.make_from_cil (l_name))
			else
				create Result.make ("en", "US", Void)
			end
		ensure then
			result_exists: Result /= Void
		end

feature -- Date and time formatting

	get_long_date_format: STRING_32
		do
			Result :=  conv.convert_format_string (date_time_format.long_date_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_long_time_format : STRING_32
			--
		do
			Result := conv.convert_format_string (date_time_format.long_time_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_short_time_format : STRING_32
			--
		do
			Result := conv.convert_format_string (date_time_format.short_time_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_short_date_format : STRING_32
			--
		do
			Result := conv.convert_format_string (date_time_format.short_date_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_am_suffix  : STRING_32
			--
		do
			if attached date_time_format.am_designator as l_am then
				Result := l_am
			else
				Result := {STRING_32} "AM"
			end
		ensure
			result_exists: Result /= Void
		end

	get_pm_suffix : STRING_32
			-- No description
		do
			if attached date_time_format.pm_designator as l_pm then
				Result := l_pm
			else
				Result := {STRING_32} "PM"
			end
		ensure
			result_exists: Result /= Void
		end

	get_date_separator : STRING_32
			-- separator in the date pattern
		do
			if attached date_time_format.date_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} "/"
			end
		ensure
			result_exists: Result /= Void
		end

	get_time_separator : STRING_32
			-- separator in the time pattern
		do
			if attached date_time_format.time_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} ":"
			end
		ensure
			result_exists: Result /= Void
		end

	get_date_time_format : STRING_32
			-- full date time pattern
		do
			Result := conv.convert_format_string (date_time_format.full_date_time_pattern)
		end

	get_month_day_format : STRING_32
			-- pattern with month and day
		do
			Result := conv.convert_format_string (date_time_format.month_day_pattern)
		end

	get_year_month_format : STRING_32
			-- pattern with year and month
		do
			Result := conv.convert_format_string (date_time_format.month_day_pattern)
		end

	get_rfc1123_format : STRING_32
			-- rfc1123 is: ddd, dd MMM yyyy HH':'mm':'ss 'GMT'
		do
			Result := conv.convert_format_string (date_time_format.rfc1123_pattern)
		end

	get_sortable_date_time_format: STRING_32
			-- a sortable time pattern
			-- yyyy'-'MM'-'dd'T'HH':'mm':'ss
		do
			Result := conv.convert_format_string (date_time_format.sortable_date_time_pattern)
		end

	get_universal_sortable_date_time_format: STRING_32
			-- a sortable pattern
			-- yyyy'-'MM'-'dd HH':'mm':'ss'Z'
		do
			Result := conv.convert_format_string (date_time_format.universal_sortable_date_time_pattern)
		end

feature -- day/months names

	get_day_names: ARRAY [STRING_32]
			--
		local
			i : INTEGER
		do
			create Result.make_filled ({STRING_32} "", 1, {DATE_CONSTANTS}.Days_in_week)
			if attached date_time_format.day_names as l_array then
				from
					i := Result.lower
				until
					i > Result.upper
				loop
					if attached l_array.item (i\\{DATE_CONSTANTS}.Days_in_week) as l_day then
						Result.put (l_day, i)
					end
					i := i + 1
				end
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Days_in_week
		end

	get_month_names: ARRAY [STRING_32]
			--
		local
			i : INTEGER
		do
			create Result.make_filled ({STRING_32} "", 1, {DATE_CONSTANTS}.Months_in_year)
			if attached date_time_format.month_names as l_array then
				from
					i := l_array.lower
				until
					i > l_array.upper-1
				loop
					if attached l_array.item (i) as l_month then
						Result.put (l_month, i + 1)
					end
					i := i + 1
				end
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Months_in_year
		end

	get_abbreviated_day_names: ARRAY [STRING_32]
			--
		local
			i : INTEGER
		do
			create Result.make_filled ({STRING_32} "", 1, {DATE_CONSTANTS}.Days_in_week)
			if attached date_time_format.abbreviated_day_names as l_array then
				from
					i := Result.lower
				until
					i > Result.upper
				loop
					if attached l_array.item (i\\{DATE_CONSTANTS}.Days_in_week) as l_day then
						Result.put (l_day, i)
					end
					i := i + 1
				end
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Days_in_week
		end

	get_abbreviated_month_names: ARRAY [STRING_32]
			--
		local
			i : INTEGER
		do
			create Result.make_filled ({STRING_32} "", 1, {DATE_CONSTANTS}.Months_in_year)
			if attached date_time_format.abbreviated_month_names as l_array then
				from
					i := l_array.lower
				until
					i > l_array.upper-1
				loop
					if attached l_array.item (i) as l_month then
						Result.put (l_month, i + 1)
					end
					i := i + 1
				end
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Months_in_year
		end

feature	-- number formatting

	get_value_decimal_separator: STRING_32
		do
			if attached number_format.number_decimal_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} "."
			end
		ensure
			result_exists: Result /= Void
		end

	get_value_numbers_after_decimal_separator: INTEGER
			--
		do
			Result := number_format.number_decimal_digits
		ensure
			result_sensible: Result > 0
		end

	get_value_group_separator: STRING_32
			--
		do
			if attached number_format.number_group_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} ","
			end
		ensure
			result_exists: Result /= Void
		end

	get_value_grouping: ARRAY [INTEGER_32]
			-- grouping rules for values
		do
			Result := native_array_to_array (number_format.number_group_sizes)
		ensure
			result_exists: Result /= Void
		end

feature	-- currency formatting

	get_currency_symbol: STRING_32
			--
		do
			if attached number_format.currency_symbol as l_symbol then
				Result := l_symbol
			else
				Result := {STRING_32} "$"
			end
		ensure
			result_exists: Result /= Void
		end

	get_currency_decimal_separator: STRING_32
			--
		do
			if attached number_format.currency_decimal_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} "."
			end
		ensure
			result_exists: Result /= Void
		end

	get_currency_numbers_after_decimal_separator: INTEGER
			--
		do
			Result := number_format.currency_decimal_digits
		ensure
			result_sensible: Result > 0
		end

	get_currency_group_separator: STRING_32
			--
		do
			if attached number_format.currency_group_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} ","
			end
		ensure
			result_exists: Result /= Void
		end

	get_currency_grouping: ARRAY [INTEGER_32]
			-- Gropuing rules for currency
		do
			Result := native_array_to_array (number_format.currency_group_sizes)
		ensure
			result_exists: Result /= Void
		end

feature -- International currency formatting

	get_int_currency_symbol: STRING_32
			-- get the interational currency symbol
			-- like "USD"
		do
			if attached invariant_culture_number_format.currency_symbol as l_symbol then
				Result := l_symbol
			else
				Result := {STRING_32} "USD"
			end
		ensure
			result_exists: Result /= Void
		end

	get_int_currency_decimal_separator: STRING_32
			--
		do
			if attached invariant_culture_number_format.currency_decimal_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} "."
			end
		ensure
			result_exists: Result /= Void
		end

	get_int_currency_numbers_after_decimal_separator: INTEGER
			--
		do
			Result := invariant_culture_number_format.currency_decimal_digits
		ensure
			result_sensible: Result > 0
		end

	get_int_currency_group_separator: STRING_32
			--
		do
			if attached invariant_culture_number_format.currency_group_separator as l_sep then
				Result := l_sep
			else
				Result := {STRING_32} ","
			end
		ensure
			result_exists: Result /= Void
		end

	get_int_currency_grouping: ARRAY [INTEGER_32]
			-- Gropuing rules for currency
		do
			Result := native_array_to_array (invariant_culture_number_format.currency_group_sizes)
		ensure
			result_exists: Result /= Void
		end

feature -- General Information

	name: STRING_32
			-- name of current locale
		do
			if attached culture_info.name as l_culture_name then
				Result := l_culture_name
			else
				Result := {STRING_32}"en-US"
			end
		end

	default_locale_id: I18N_LOCALE_ID
			-- default locale id
		do
			if
				attached {CULTURE_INFO}.current_culture as l_culture and then
				attached l_culture.name as l_culture_name
			then
				create Result.make_from_string (create {STRING_32}.make_from_cil (l_culture_name))
			else
				create Result.make ("en", "US", Void)
			end
		end

	system_locale_id: I18N_LOCALE_ID
			-- Default system locale id.
		do
			if
				attached {CULTURE_INFO}.installed_ui_culture as l_culture and then
				attached l_culture.name as l_culture_name
			then
				create Result.make_from_string (create {STRING_32}.make_from_cil (l_culture_name))
			else
				create Result.make ("en", "US", Void)
			end
		end

feature {NONE} -- Implementation

	conv: I18N_DOTNET_UTILITY
			-- format string converter
		once
			create Result
		end

	culture_info : CULTURE_INFO

	date_time_format: DATE_TIME_FORMAT_INFO
		do
			check attached culture_info.date_time_format as l_result then
				Result := l_result
			end
		end

	number_format: NUMBER_FORMAT_INFO
		do
				-- Per .NET specification
			check attached culture_info.number_format as l_result then
				Result := l_result
			end
		end

	invariant_culture_number_format: NUMBER_FORMAT_INFO
		do
				-- Per .NET specification
			check attached {NUMBER_FORMAT_INFO}.invariant_info as l_result then
				Result := l_result
			end
		end

	first_day : INTEGER
			-- first day of the week
		do
			Result := date_time_format.first_day_of_week.to_integer
		end

feature {NONE} -- Help fuction

	native_array_to_array (a_native_array: detachable NATIVE_ARRAY [INTEGER_32]): ARRAY [INTEGER_32]
			--
		local
			i, dif: INTEGER
		do
			if a_native_array /= Void then
				create Result.make_filled (0, 1, a_native_array.count)
				from
					dif := 1-a_native_array.lower
					i := a_native_array.lower
				until
					i > a_native_array.upper
				loop
					Result.put (a_native_array.item (i), i+dif)
					i := i + 1
				end
			else
				create Result.make_empty
			end
		end

	format_id_to_dotnet (a_id: READABLE_STRING_GENERAL): STRING_32
			-- Format id to dotnet style.
			-- Replace "_", "@" and "." with "-"
		local
			i: INTEGER
			l_c: CHARACTER_32
		do
			create Result.make (a_id.count)
			from
				i := 1
			until
				i > a_id.count
			loop
				l_c := a_id.item (i)
				if l_c = '_' or else l_c = '@' or else l_c = '.' or else l_c = '-' then
					Result.append_character ('-')
				else
					Result.append_character (l_c)
				end
				i := i + 1
			end
		end

invariant
	culture_info_exists: culture_info /= Void
note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
