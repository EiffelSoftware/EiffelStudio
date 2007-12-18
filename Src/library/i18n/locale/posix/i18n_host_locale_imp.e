indexing
	description: "Implementation of I18N_HOST_LOCALE for posix platforms"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_HOST_LOCALE_IMP
inherit
		IMPORTED_UTF8_READER_WRITER
			export
				{NONE} all
			end
		I18N_HOST_LOCALE
		I18N_POSIX_CONSTANTS
			export
				{NONE} all
			end
		I18N_UNIX_C_FUNCTIONS
			export
				{NONE} all
			end
		I18N_LOCALE_CONV
			export
				{NONE} all
			end

feature -- Initialization

	create_locale_info_from_user_locale: I18N_LOCALE_INFO is
			-- Creation procedure.
			-- create locale form the user locale
		do
			Result := create_locale_info (default_locale_id)
		end

	create_locale_info (a_locale_id : I18N_LOCALE_ID): I18N_LOCALE_INFO is
			-- Creation procedure
			-- Create locale with a_locale_id
		do
			if c_is_solaris then
				unix_set_locale (guess_proper_locale (a_locale_id.full_name))
			else
				unix_set_locale (a_locale_id.full_name)
			end
			create Result.make
			fill (Result)
			Result.set_id(a_locale_id)
		ensure then
			locale_set: locale_name.is_equal(a_locale_id.full_name) or
						locale_name.is_equal (guess_proper_locale (a_locale_id.full_name)) or
						locale_name.is_equal ("C")  and a_locale_id.full_name.is_equal ("POSIX")
		end

feature -- Informations

	is_available (a_locale_id : I18N_LOCALE_ID) : BOOLEAN is
			-- is 'a_locale' available?
		do
			if c_is_solaris then
				Result := unix_is_available (guess_proper_locale (a_locale_id.full_name))
			else
				Result := unix_is_available (a_locale_id.full_name)
			end
		end

	available_locales : LINKED_LIST[I18N_LOCALE_ID] is
			-- get list of available locales
		local
			l_locale_id: I18N_LOCALE_ID
			directory: DIRECTORY
			dir_entries: ARRAYED_LIST[STRING]
		do
			create Result.make
				-- This is the Linux location.
			create directory.make ("/usr/share/i18n/locales/")
			if not directory.exists then
					-- This is the Solaris location.
				directory.make ("/usr/lib/locale")
			end
			if directory.exists then
					-- if it does not exist, unfortunately the system
					-- does not follow POSIX
				dir_entries := directory.linear_representation
				from
					dir_entries.start
				until
					dir_entries.after
				loop
					create l_locale_id.make_from_string (dir_entries.item)
						-- The locale id is from file name,
						-- so there is no need to use `is_available' where guess is possibly done.
					if unix_is_available (l_locale_id.full_name) then
						Result.extend (l_locale_id)
					end
					dir_entries.forth
				end
			end
		end

	default_locale_id: I18N_LOCALE_ID is
		do
			unix_set_locale ("")
			Result := current_locale_id
		end

	system_locale_id: I18N_LOCALE_ID is
		do
			Result := default_locale_id
		end

	current_locale_id : I18N_LOCALE_ID is
			-- current locale id
		do
			create Result.make_from_string (locale_name)
		end

	locale_name : STRING_32 is
			-- name of current locale
		do
			Result := unix_locale_name
		end

 feature {NONE} -- fill

 		fill (a_locale_info: I18N_LOCALE_INFO) is
 				-- fill `a_locale_info' with all available informations
 			require
 				a_locale_info_exists: a_locale_info /= Void
 			do
				fill_date_time_info (a_locale_info)
				fill_numeric_info (a_locale_info)
				fill_currency_info (a_locale_info)
				fill_code_page_info (a_locale_info)
 			end

 		fill_date_time_info (a_date_time_info: I18N_DATE_TIME_INFO) is
 				-- fill `a_date_time_info' with the available informations
 			require
 				a_date_time_info_exists: a_date_time_info /= Void
 			do
 					-- set date time formatting
 				a_date_time_info.set_date_time_format (get_date_time_format)
				a_date_time_info.set_long_date_format (get_long_date_format)
				a_date_time_info.set_long_time_format (get_long_time_format)
 				a_date_time_info.set_am_suffix (get_am_suffix)
				a_date_time_info.set_pm_suffix (get_pm_suffix)
					-- set day/month names
				a_date_time_info.set_day_names (get_day_names)
				a_date_time_info.set_month_names (get_month_names)
 				a_date_time_info.set_abbreviated_day_names (get_abbreviated_day_names)
 				a_date_time_info.set_abbreviated_month_names (get_abbreviated_month_names)
 			end

 		fill_numeric_info (a_numeric_info: I18N_NUMERIC_INFO) is
 				-- fill `a_numeric_info' with the available informations
 			require
 				a_numeric_info_exists: a_numeric_info /= Void
 			do
 					-- set number formatting
				a_numeric_info.set_value_decimal_separator (get_value_decimal_separator)
				a_numeric_info.set_value_group_separator (get_value_group_separator)
				a_numeric_info.set_value_grouping (get_value_grouping)
			end

		fill_currency_info (a_currency_info: I18N_CURRENCY_INFO) is
 				-- fill `a_currency_info' with the available informations
 			require
 				a_currency_info_exists: a_currency_info /= Void
 			do
 					-- set currency formatting
				a_currency_info.set_currency_symbol (get_currency_symbol)
				a_currency_info.set_currency_symbol_location (get_currency_symbol_location)
 				a_currency_info.set_currency_decimal_separator (get_currency_decimal_separator)
 				a_currency_info.set_currency_numbers_after_decimal_separator (get_currency_numbers_after_decimal_separator)
 				a_currency_info.set_currency_group_separator (get_currency_group_separator)
 				a_currency_info.set_currency_positive_sign (get_currency_positive_sign)
 				a_currency_info.set_currency_negative_sign (get_currency_negative_sign)
 				a_currency_info.set_currency_grouping (get_currency_grouping)
					-- set international currency formatting
				a_currency_info.set_international_currency_symbol (get_int_currency_symbol)
				a_currency_info.set_international_currency_numbers_after_decimal_separator (get_int_currency_numbers_after_decimal_separator)
 			end

 		fill_code_page_info (a_code_page_info: I18N_CODE_PAGE_INFO) is
 				-- fill `a_code_page_info' with the availiable informations
 			require
 				a_code_page_info_exists: a_code_page_info /= Void
 			local
 				l_str: STRING_8
 			do
 				l_str := get_code_page.as_string_8
				a_code_page_info.set_ansi_code_page (l_str)
				a_code_page_info.set_oem_code_page (l_str)
				a_code_page_info.set_mac_code_page (l_str)
 			end

feature {NONE} -- Date and time formatting


	get_long_date_format: STRING_32 is
			-- get the long date format string
			-- according the current locale setting
		do
			Result := utf8_pointer_to_string (unix_get_locale_info (D_fmt))
			Result.replace_substring_all ("%%","&")
		ensure
			result_exists: Result /= Void
		end

	get_long_time_format: STRING_32 is
			-- get the long time format string
			-- according the current locale setting
		do
			Result := utf8_pointer_to_string (unix_get_locale_info (T_fmt))
			Result.replace_substring_all ("%%","&")
		--	io.put_string(Result)
		ensure
			result_exists: Result /= Void
		end

	get_am_suffix : STRING_32 is
			-- get the am suffix
			-- if the not available: empty_string
		do
			Result := utf8_pointer_to_string (unix_get_locale_info (Am_str))
		ensure
			result_exists: Result /= Void
		end

	get_pm_suffix : STRING_32 is
			-- get the pm suffix
			-- if the not available: empty_string
		do
			Result := utf8_pointer_to_string (unix_get_locale_info (Pm_str))
		ensure
			result_exists: Result /= Void
		end

	get_date_time_format: STRING_32 is
			-- time and date in a locale-specific way.
		do
			Result := utf8_pointer_to_string (unix_get_locale_info (D_t_fmt))
			Result.replace_substring_all ("%%","&")
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- day/months names

	get_day_names: ARRAY[STRING_32] is
			-- array with the full weekday names
			-- according the current locale settings
		local
			i,upper : INTEGER
			l_string : STRING_32
		do
			upper := {DATE_CONSTANTS}.Days_in_week
			create Result.make(1,upper)
			from
				i := Result.lower
			variant
				Result.count - i + 1
			until
				i > Result.upper
			loop
				create l_string.make_from_string( utf8_pointer_to_string (unix_get_locale_info (Day_1 +((i-1)\\upper))))
				Result.put (l_string, i)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Days_in_week
		end

	get_month_names: ARRAY[STRING_32] is
			-- array with the full month names
			-- according the current locale settings
		local
			i : INTEGER
			l_string : STRING_32
		do
			create Result.make(1,{DATE_CONSTANTS}.Months_in_year)
			from
				i := Result.lower
			variant
				Result.count - i + 1
			until
				i > Result.upper
			loop
				create l_string.make_from_string( utf8_pointer_to_string  (unix_get_locale_info (Mon_1 +i-1)))
				Result.put (l_string, i)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Months_in_year
		end

	get_abbreviated_day_names: ARRAY[STRING_32] is
			-- array with the abbreviated weekday names
			-- according the current locale settings
		local
			i, upper : INTEGER
			l_string : STRING_32
		do
			upper := {DATE_CONSTANTS}.Days_in_week
			create Result.make(1,upper)
			create Result.make(1,7)
			from
				i := Result.lower
			variant
				Result.count - i + 1
			until
				i > Result.upper
			loop
				create l_string.make_from_string (utf8_pointer_to_string (unix_get_locale_info (Abday_1 +((i-1)\\upper))))
				Result.put (l_string, i)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Days_in_week
		end

	get_abbreviated_month_names: ARRAY[STRING_32] is
			-- array with the abbreviated month names
			-- according the current locale settings
		local
			i : INTEGER
			l_string : STRING_32
		do
			create Result.make(1,{DATE_CONSTANTS}.Months_in_year)
			from
				i := Result.lower
			variant
				Result.count - i + 1
			until
				i > Result.upper
			loop
				create l_string.make_from_string (utf8_pointer_to_string  (unix_get_locale_info (Abmon_1 +i-1)))
				Result.put (l_string, i)
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
			correct_size: Result.count = {DATE_CONSTANTS}.Months_in_year
		end

feature	{NONE} -- number formatting

	get_value_decimal_separator: STRING_32 is
			-- get the decimal separator of numbers
			-- according the current locales setting
		do
			create Result.make_from_c (decimal_point (localeconv))
		ensure
			result_exists: Result /= Void
		end

	get_value_group_separator: STRING_32 is
			-- get the group separator (the separator thousend sep.)
			-- according the current locales setting
		do
			create Result.make_from_c (thousands_sep (localeconv))
		ensure
			result_exists: Result /= Void
		end

	get_value_grouping: ARRAY[INTEGER] is
			--
		do
			Result := pointer_to_array (grouping (localeconv))
		ensure
			result_exists: Result /= Void
		end

feature	{NONE} -- currency formatting

	get_currency_symbol: STRING_32 is
			-- get the currency symbol
			-- according the current locales setting
		do
			Result := utf8_pointer_to_string (unix_get_locale_info (Crncystr))
			Result.remove_head (1)
				-- could use:
				-- create Result.make_from_c (currency_symbol (localeconv))
				-- but it would need a character set convertion...
		ensure
			result_exists: Result /= Void
		end

	get_currency_symbol_location : INTEGER is
			-- get the integer that represents
			-- the currency symbol localtion
		local
			l_string: STRING_32
		do
			create l_string.make_from_string(utf8_pointer_to_string (unix_get_locale_info (Crncystr)))
			if	l_string.item (1).is_equal ('-') then
				Result := {I18N_LOCALE_INFO}.Currency_symbol_prefixed
			elseif l_string.item (1).is_equal ('+') then
				Result := {I18N_LOCALE_INFO}.Currency_symbol_appended
			elseif l_string.item (1).is_equal ('.') then
				Result := {I18N_LOCALE_INFO}.Currency_symbol_radix
			else
					-- Return as default value currency_symbol_prefixed
				Result := {I18N_LOCALE_INFO}.Currency_symbol_prefixed
			end
		ensure
			Result_correct: Result = {I18N_LOCALE_INFO}.currency_symbol_prefixed or
							Result = {I18N_LOCALE_INFO}.currency_symbol_appended or
							Result = {I18N_LOCALE_INFO}.currency_symbol_radix
		end

	get_currency_decimal_separator: STRING_32 is
			-- get the decimal separator of currency numbers
			-- according the current locales setting
		do
			create Result.make_from_c (mon_decimal_point (localeconv))
		ensure
			result_exists: Result /= Void
		end

	get_currency_numbers_after_decimal_separator: INTEGER is
			-- numbers after the decimal separator for currencynumbers
			-- according the current locales setting
		do
			Result := frac_digits (localeconv).natural_32_code.to_integer_32
			if Result = {CHARACTER_8}.Max_value then
				Result := {I18N_CURRENCY_INFO}.Default_currency_numbers_after_decimal_separator
			end
		ensure
			non_negative: Result >= 0
		end

	get_currency_group_separator: STRING_32 is
			-- get the decimal separator of numbers
			-- according the current locales setting
		do
			create Result.make_from_c (mon_thousands_sep (localeconv))
		ensure
			result_exists: Result /= Void
		end

	get_currency_positive_sign: STRING_32 is
			-- positive sign according the current locales setting
		do
			create Result.make_from_c (positive_sign (localeconv))
		ensure
			result_exists: Result /= Void
		end

	get_currency_negative_sign: STRING_32 is
			-- positive sign according the current locales setting
		do
			create Result.make_from_c (negative_sign (localeconv))
		ensure
			result_exists: Result /= Void
		end

	get_currency_grouping: ARRAY[INTEGER] is
			-- get grouping rules for currency values
		do
			Result := pointer_to_array (mon_grouping (localeconv))
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Code Page

	get_code_page: STRING_32 is
			-- Codeset name
		do
			Result := utf8_pointer_to_string (c_current_codeset)
		end

feature {NONE} -- International currency formatting

	get_int_currency_symbol: STRING_32 is
			-- ISO 4217 currency code
		do
			create Result.make_from_c (int_curr_symbol (localeconv))
		end

	get_int_currency_numbers_after_decimal_separator: INTEGER is
			-- numbers after the decimal separator for currencynumbers
			-- according the current locales setting
		do
			Result := int_frac_digits (localeconv).natural_32_code.to_integer_32
			if Result = {CHARACTER_8}.Max_value then
				Result := {I18N_CURRENCY_INFO}.Default_currency_numbers_after_decimal_separator
			end
		ensure
			non_negative: Result >= 0
		end

feature {NONE} --Implementation

	pointer_to_array (a_pointer: POINTER): ARRAY[INTEGER] is
		local
			l_string: STRING_32
			i, t: INTEGER
		do
			create l_string.make_from_c (a_pointer)
			create Result.make (1, l_string.count)
			from
				i := 1
			until
				i > l_string.count
			loop
				t := (l_string.item (i)).natural_32_code.as_integer_32
				if t = {CHARACTER}.Max_value then
						-- finished with the string
					i := l_string.count
				else
					Result.put (t, i)
				end
				i := i + 1
			end
			if t /= {CHARACTER}.Max_value then
				Result.force (0, i)
			end
		end


	c_strlen (ptr: POINTER): INTEGER is
				-- length of a c string
		external
			"C (void *): EIF_INTEGER| %"string.h%""
		alias
			"strlen"
		end

	c_is_solaris: BOOLEAN is
			-- Is current OS Solaris?
		external
			"C inline use <eif_eiffel.h>"
		alias
			"[
				#if EIF_OS == EIF_OS_SUNOS
					return (EIF_BOOLEAN)1;
				#else
					return (EIF_BOOLEAN)0;
				#endif
			]"
		end

	utf8_pointer_to_string (ptr:POINTER): STRING_32 is
			-- convert a C UTF-8 string
		local
			managed: MANAGED_POINTER
		do
			create managed.make_from_pointer (ptr,c_strlen(ptr))
			if managed.count > 0 then
				create Result.make_from_string (
					utf8_rw.array_natural_8_to_string_32 (managed.read_array (0, managed.count)))
			else
				create Result.make_empty
			end
		end

	guess_proper_locale (a_name: STRING): STRING is
			-- We try to guess a locale from `a_name', when `a_name', for example in LL_RR style, can 
			-- not be recognized by `setlocale' on Solaris, but LL_RR.ENC does exist as system locale mostly.
			-- First take the system locale, then try to find a most matching one.
		require
			a_name_not_void: a_name /= Void
		local
			l_str: C_STRING
			l_ptr, l_null: POINTER
			l_s, l_name: STRING
			l_available_locales: like available_locales
		do
			if a_name.has ('_') then
				create l_str.make (a_name)
				l_ptr := c_setlocale (c_lc_all, l_str.item)
				if l_ptr = l_null then
					l_name := a_name.as_lower
						-- Try to match system locale.
					create l_str.make ("")
					l_ptr := c_setlocale (c_lc_all, l_str.item)
					if l_ptr /= l_null then
						create l_str.share_from_pointer (l_ptr)
						l_s := l_str.string
						if l_s.as_lower.has_substring (l_name) then
							Result := l_s
						end
					end
						-- Try to find a most matching locale supported.
					if Result = Void then
						l_available_locales := available_locales
						from
							l_available_locales.start
						until
							l_available_locales.after or Result /= Void
						loop
							l_s := l_available_locales.item.full_name
							if l_s.as_lower.has_substring (l_name) then
								Result := l_s
							end
							l_available_locales.forth
						end
					end
				end
			end
			if Result = Void then
				Result := a_name
			end
		ensure
			result_not_void: Result /= Void
		end

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
