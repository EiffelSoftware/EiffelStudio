indexing
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

	default_create is
			-- Default `culture_info' to `System.Globalization.CultureInfo.CurrentCulture'
		do
			culture_info := {CULTURE_INFO}.current_culture
		end

	create_locale_info_from_user_locale: I18N_LOCALE_INFO is
			-- create locale form the user locale
		local
			t_culture_info : CULTURE_INFO
			l_locale_id: I18N_LOCALE_ID
		do
			create culture_info.make_from_name (t_culture_info.current_culture.name)
			create l_locale_id.make_from_string (culture_info.name)
			create Result.make
			fill (Result)
			Result.set_id (l_locale_id)
		ensure then
			culture_info_exists: culture_info /= Void
		end

	create_locale_info (a_locale_id : I18N_LOCALE_ID): I18N_LOCALE_INFO is
			-- Create locale with a_locale_id
		do
			if {l_name: !STRING}a_locale_id.name.string then
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

	set_locale (a_locale_name : STRING_32) is
			-- set current locale to `a_locale_name'
		do
			if a_locale_name /= Void and then ({l_name: !STRING}a_locale_name.string) then
				create culture_info.make_from_name (format_id_to_dotnet (l_name))
			end
		end

feature -- Informations

	is_available (a_locale_id : I18N_LOCALE_ID) : BOOLEAN is
			-- I guess it is always true
		local
			l_list: LINKED_LIST[I18N_LOCALE_ID]
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

	available_locales : LINKED_LIST[I18N_LOCALE_ID] is
			-- get list of available locales
		local
			l_culture_type : CULTURE_TYPES
			l_list: NATIVE_ARRAY [CULTURE_INFO]
			i : INTEGER
			l_locale_id: I18N_LOCALE_ID
		do
			create l_culture_type
			l_list := culture_info.get_cultures (l_culture_type.specific_cultures)
			from
				create Result.make
				i := l_list.lower
			variant
				l_list.count-i+1
			until
				i > l_list.upper
			loop
				create l_locale_id.make_from_string (l_list.item (i).name)
				Result.extend (l_locale_id.twin)
				i := i + 1
			end
		end

	current_locale_id : I18N_LOCALE_ID is
			-- return the current locale info
		do
			create Result.make_from_string (culture_info.current_culture.name)
		ensure then
			result_exists: Result /= Void
		end


feature -- Date and time formatting

	get_long_date_format: STRING_32 is
		do
			Result :=  conv.convert_format_string (culture_info.date_time_format.long_date_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_long_time_format : STRING_32 is
			--
		do
			Result := conv.convert_format_string (culture_info.date_time_format.long_time_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_short_time_format : STRING_32 is
			--
		do
			Result := conv.convert_format_string (culture_info.date_time_format.short_time_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_short_date_format : STRING_32 is
			--
		do
			Result := conv.convert_format_string (culture_info.date_time_format.short_date_pattern)
		ensure
			result_exists: Result /= Void
		end

	get_am_suffix  : STRING_32 is
			--
		do
			Result := culture_info.date_time_format.am_designator
		ensure
			result_exists: Result /= Void
		end

	get_pm_suffix : STRING_32 is
			-- No description
		do
			Result := culture_info.date_time_format.pm_designator
		ensure
			result_exists: Result /= Void
		end

	get_date_separator : STRING_32 is
			-- separator in the date pattern
		do
			Result := culture_info.date_time_format.date_separator
		ensure
			result_exists: Result /= Void
		end

	get_time_separator : STRING_32 is
			-- separator in the time pattern
		do
			Result := culture_info.date_time_format.time_separator
		ensure
			result_exists: Result /= Void
		end

	get_date_time_format : STRING_32 is
			-- full date time pattern
		do
			Result := conv.convert_format_string (culture_info.date_time_format.full_date_time_pattern)
		end

	get_month_day_format : STRING_32 is
			-- pattern with month and day
		do
			Result := conv.convert_format_string (culture_info.date_time_format.month_day_pattern)
		end

	get_year_month_format : STRING_32 is
			-- pattern with year and month
		do
			Result := conv.convert_format_string (culture_info.date_time_format.month_day_pattern)

		end

	get_rfc1123_format : STRING_32 is
			-- rfc1123 is: ddd, dd MMM yyyy HH':'mm':'ss 'GMT'
		do
			Result := conv.convert_format_string (culture_info.date_time_format.rfc1123_pattern)
		end

	get_sortable_date_time_format: STRING_32 is
			-- a sortable time pattern
			-- yyyy'-'MM'-'dd'T'HH':'mm':'ss
		do
			Result := conv.convert_format_string (culture_info.date_time_format.sortable_date_time_pattern)
		end

	get_universal_sortable_date_time_format: STRING_32 is
			-- a sortable pattern
			-- yyyy'-'MM'-'dd HH':'mm':'ss'Z'
		do
			Result := conv.convert_format_string (culture_info.date_time_format.universal_sortable_date_time_pattern)
		end

feature -- day/months names

	get_day_names: ARRAY[STRING_32] is
			--
		local
			l_array: NATIVE_ARRAY[SYSTEM_STRING]
			i : INTEGER
		do
			l_array := culture_info.date_time_format.day_names
			create Result.make (1, {DATE_CONSTANTS}.Days_in_week)
			from
				i := Result.lower
			until
				i > Result.upper
			loop
				Result.put (l_array.item (i\\{DATE_CONSTANTS}.Days_in_week),i)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Days_in_week
		end

	get_month_names: ARRAY[STRING_32] is
			--
		local
			l_array : NATIVE_ARRAY[SYSTEM_STRING]
			i : INTEGER
		do
			l_array := culture_info.date_time_format.month_names
			create Result.make (1, {DATE_CONSTANTS}.Months_in_year)
			from
				i := l_array.lower
			until
				i > l_array.upper-1
			loop
				Result.put (l_array.item (i),i+1)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Months_in_year
		end

	get_abbreviated_day_names: ARRAY[STRING_32] is
			--
		local
			l_array : NATIVE_ARRAY[SYSTEM_STRING]
			i : INTEGER
		do
			l_array := culture_info.date_time_format.abbreviated_day_names
			create Result.make (1, {DATE_CONSTANTS}.Days_in_week)
			from
				i := Result.lower
			until
				i > Result.upper
			loop
				Result.put (l_array.item (i\\{DATE_CONSTANTS}.Days_in_week),i)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Days_in_week
		end

	get_abbreviated_month_names: ARRAY[STRING_32] is
			--
		local
			l_array : NATIVE_ARRAY[SYSTEM_STRING]
			i : INTEGER
		do
			l_array := culture_info.date_time_format.abbreviated_month_names
			create Result.make (1, {DATE_CONSTANTS}.Months_in_year)
			from
				i := l_array.lower
			until
				i > l_array.upper-1
			loop
				Result.put (l_array.item (i),i+1)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Months_in_year
		end

feature	-- number formatting

	get_value_decimal_separator: STRING_32 is
		do
			Result := culture_info.number_format.number_decimal_separator
		ensure
			result_exists: Result /= Void
		end

	get_value_numbers_after_decimal_separator: INTEGER is
			--
		do
			Result := culture_info.number_format.number_decimal_digits
		ensure
			result_sensible: Result > 0
		end

	get_value_group_separator: STRING_32 is
			--
		do
			Result := culture_info.number_format.number_group_separator
		ensure
			result_exists: Result /= Void
		end

	get_value_grouping: ARRAY[INTEGER_32] is
			-- grouping rules for values
		do
			Result := native_array_to_array (culture_info.number_format.number_group_sizes)
		ensure
			result_exists: Result /= Void
		end

feature	-- currency formatting

	get_currency_symbol: STRING_32 is
			--
		do
			Result := culture_info.number_format.currency_symbol
		ensure
			result_exists: Result /= Void
		end

	get_currency_decimal_separator: STRING_32 is
			--
		do
			Result := culture_info.number_format.currency_decimal_separator
		ensure
			result_exists: Result /= Void
		end

	get_currency_numbers_after_decimal_separator: INTEGER is
			--
		do
			Result := culture_info.number_format.currency_decimal_digits
		ensure
			result_sensible: Result > 0
		end

	get_currency_group_separator: STRING_32 is
			--
		do
			Result := culture_info.number_format.currency_group_separator
		ensure
			result_exists: Result /= Void
		end

	get_currency_grouping: ARRAY[INTEGER_32] is
			-- Gropuing rules for currency
		do
			Result := native_array_to_array (culture_info.number_format.currency_group_sizes)
		ensure
			result_exists: Result /= Void
		end

feature -- International currency formatting

	get_int_currency_symbol: STRING_32 is
			-- get the interational currency symbol
			-- like "USD"
		do
			Result := culture_info.invariant_culture.number_format.currency_symbol
		ensure
			result_exists: Result /= Void
		end

	get_int_currency_decimal_separator: STRING_32 is
			--
		do
			Result := culture_info.invariant_culture.number_format.currency_decimal_separator
		ensure
			result_exists: Result /= Void
		end

	get_int_currency_numbers_after_decimal_separator: INTEGER is
			--
		do
			Result := culture_info.invariant_culture.number_format.currency_decimal_digits
		ensure
			result_sensible: Result > 0
		end

	get_int_currency_group_separator: STRING_32 is
			--
		do
			Result := culture_info.invariant_culture.number_format.currency_group_separator
		ensure
			result_exists: Result /= Void
		end

	get_int_currency_grouping: ARRAY[INTEGER_32] is
			-- Gropuing rules for currency
		do
			Result := native_array_to_array (culture_info.invariant_culture.number_format.currency_group_sizes)
		ensure
			result_exists: Result /= Void
		end

feature -- General Information

	name : STRING_32 is
			-- name of current locale
		do
			Result := culture_info.name
		end

	default_locale_id: I18N_LOCALE_ID is
			-- default locale id
		local
			l_culture_info: CULTURE_INFO
		do
			l_culture_info := {CULTURE_INFO}.current_culture
			create Result.make_from_string (l_culture_info.name)
		end

	system_locale_id: I18N_LOCALE_ID is
			-- Default system locale id.
		local
			l_culture_info: CULTURE_INFO
		do
			l_culture_info := {CULTURE_INFO}.installed_ui_culture
			create Result.make_from_string (l_culture_info.name)
		end

feature {NONE} -- Implementation

	conv: I18N_DOTNET_UTILITY
			-- format string converter
		once
			create Result
		end

	culture_info : CULTURE_INFO

	first_day : INTEGER is
			-- first day of the week
		do
			Result := culture_info.date_time_format.first_day_of_week.to_integer
		end
feature {NONE} -- Help fuction

	native_array_to_array (a_native_array: NATIVE_ARRAY[INTEGER_32]): ARRAY[INTEGER_32] is
			--
		local
			i, dif: INTEGER
		do
			create Result.make (1, a_native_array.count)
			from
				dif := 1-a_native_array.lower
				i := a_native_array.lower
			until
				i > a_native_array.upper
			loop
				Result.put (a_native_array.item (i), i+dif)
				i := i + 1
			end
		end

	format_id_to_dotnet (a_id: !STRING): !STRING is
			-- Format id to dotnet style.
			-- Replace "_", "@" and "." with "-"
		local
			i: INTEGER
			l_c: CHARACTER
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
indexing
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
