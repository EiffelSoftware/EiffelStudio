indexing
	description: "Implementation of HOST_LOCALE using the Windows NLS API. Does not require Windows Vista."
	author: "ES-i18n team (es-18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_HOST_LOCALE_IMP


	inherit


		SHARED_I18N_NLS_LCID_TOOLS
		I18N_HOST_LOCALE
		I18N_NLS_GETLOCALEINFO
		I18N_NLS_PICTURE_TOOLS


feature -- Creation

		create_locale_info_from_user_locale: I18N_LOCALE_INFO is
				-- fill in
			do
				current_lcid := user_locale
				Result := fill
				Result.set_id (lcid_tools.lcid_to_locale_id (current_lcid))
			end

		create_locale_info (locale: I18N_LOCALE_ID):I18N_LOCALE_INFO is
				-- fill in
			do
				current_lcid := lcid_tools.locale_id_to_lcid (locale)
				Result := fill
				Result.set_id (locale)
			end

feature -- Information

		available_locales : LINEAR[I18N_LOCALE_ID] is
				-- All supported locales on the system
			do
				Result := lcid_tools.supported_locales
			end

		default_locale_id: I18N_LOCALE_ID is
				--
			do
				Result := lcid_tools.lcid_to_locale_id (user_locale)
			end

		is_available (a_locale_id : I18N_LOCALE_ID) : BOOLEAN is
				--
			do
				Result := lcid_tools.is_supported_locale (lcid_tools.locale_id_to_lcid (a_locale_id))
			end



 feature {NONE} -- fill

 		fill: I18N_LOCALE_INFO is
 				-- fills an locale_info
 			do
 				create Result.make
 				Result.set_abbreviated_day_names (get_abbreviated_day_names)
 				Result.set_abbreviated_month_names (get_abbreviated_month_names)
 				Result.set_am_suffix (get_am_suffix)
 				Result.set_currency_decimal_separator (get_currency_decimal_separator)
 				Result.set_currency_group_separator (get_currency_group_separator)
 				Result.set_currency_grouping (get_currency_grouping)
 				Result.set_currency_number_list_separator (get_value_number_list_separator)
 				Result.set_currency_numbers_after_decimal_separator (get_currency_numbers_after_decimal_separator)
				Result.set_currency_symbol (get_currency_symbol)
				Result.set_currency_symbol_location (get_currency_symbol_location)
				Result.set_currency_positive_sign (get_currency_positive_sign)
				Result.set_currency_negative_sign (get_currency_negative_sign)
				Result.set_day_names (get_day_names)
			--	Result.set_international_currency_decimal_separator ()
			--	Result.set_international_currency_group_separator  ()
			--	Result.set_international_currency_grouping ()
			--	Result.set_international_currency_number_list_separator ()
				Result.set_international_currency_numbers_after_decimal_separator (
										get_international_currency_numbers_after_decimal_separator)
				Result.set_international_currency_symbol (get_international_currency_symbol)
			--	Result.set_international_currency_symbol_location ()
				Result.set_long_date_format (get_long_date_format)
				Result.set_long_time_format (get_long_time_format)
				Result.set_month_names (get_month_names)
				Result.set_pm_suffix (get_pm_suffix)
				Result.set_short_date_format (get_short_date_format)
				Result.set_short_time_format (get_short_time_format)
				Result.set_date_time_format (get_date_time_format)
				Result.set_value_decimal_separator (get_value_decimal_separator)
				Result.set_value_group_separator (get_value_group_separator)
				Result.set_value_number_list_separator (get_value_number_list_separator)
				Result.set_value_numbers_after_decimal_separator (get_value_numbers_after_decimal_separator)
 			end


	feature {NONE} -- Value formatting

		get_value_group_separator: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_sthousand,
												nls_constants.locale_sthousand_maxlen)
			end

		get_value_grouping: ARRAY[INTEGER] is
				--
			do
				Result := grouping_string_to_integer(extract_locale_string (current_lcid,
										nls_constants.locale_sgrouping, nls_constants.locale_sgrouping ))

			end


		get_value_decimal_separator: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_sdecimal,
												nls_constants.locale_sdecimal_maxlen)
			end


		get_value_numbers_after_decimal_separator: INTEGER is
				--
			do
				Result := extract_locale_integer(current_lcid, nls_constants.locale_idigits)
			end

		get_value_number_list_separator: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_slist,
												nls_constants.locale_slist_maxlen)
			end


	feature {NONE} -- Currency formatting

		get_currency_decimal_separator: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_smondecimalsep,
													nls_constants.locale_smondecimalsep_maxlen )
			end

		get_currency_grouping: ARRAY[INTEGER] is
				--
			do
				Result := grouping_string_to_integer(extract_locale_string (current_lcid,
										nls_constants.locale_smongrouping, nls_constants.locale_smongrouping ))
			end

		get_currency_number_list_separator: STRING_32 is
				--
			do
				Result := get_value_number_list_separator
			end

		get_currency_symbol: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_scurrency,
												nls_constants.locale_scurrency_maxlen)
			end

		get_currency_symbol_location: INTEGER is
				--
			local
				i: INTEGER
			do
				i := extract_locale_integer (current_lcid, nls_constants.locale_icurrency)
				if i=1 or i=3  then
					Result := {I18N_CURRENCY_INFO}.currency_symbol_appended
				else
					Result := {I18N_CURRENCY_INFO}.currency_symbol_prefixed
				end
			end


		get_currency_numbers_after_decimal_separator: INTEGER is
				--
			do
				Result := extract_locale_integer(current_lcid, nls_constants.locale_icurrdigits)
			end

		get_currency_group_separator: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_spositivesign,
												nls_constants.locale_spositivesign_maxlen)
			end

		get_currency_positive_sign: STRING_32 is
				--
			do
			--	Result := extract_locale_string (current_lcid, nls_constants.locale_snegativesign,
			--									nls_constants.locale_snegativesign_maxlen)
				Result := ""
			end

		get_currency_negative_sign: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_smonthousandsep,
												nls_constants.locale_smonthousandsep_maxlen)
			end

		get_international_currency_symbol: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_sintlsymbol,
												nls_constants.locale_sintlsymbol_maxlen)
			end

		get_international_currency_numbers_after_decimal_separator: INTEGER is
				--
			do
				Result := extract_locale_integer (current_lcid, nls_constants.locale_iintlcurrdigits)
			end







	feature {NONE}  -- Default locales

		system_locale: INTEGER is
			-- Encapsulation of GetSystemDefaultLCID
		external
			"C (): int| %"nls_locale.h%""
		alias
			"GetSystemDefaultLCID"
		end

		user_locale: INTEGER is
			-- Encapsulation of GetUserDefaultLCID
		external
			"C (): int| %"nls_locale.h%""
		alias
			"GetUserDefaultLCID"
		end


	feature {NONE} -- date and time formatting

		get_short_date_format: STRING_32 is
				--
			do
				Result:= translate_date_format (
					extract_locale_string (current_lcid,nls_constants.locale_sshortdate,
												nls_constants.locale_sshortdate_maxlen))
			end

		get_long_date_format: STRING_32 is
				--
			do
				Result:= translate_date_format (
					extract_locale_string (current_lcid,nls_constants.locale_slongdate,
												nls_constants.locale_slongdate_maxlen))
			end

		get_date_time_format: STRING_32 is
				--
			do
				--NLS doesn't support this. I'll just concatenate date and time.
				Result:=  get_long_date_format + " " + get_short_time_format
			end





		get_day_names: ARRAY[STRING_32] is
				--
			do
				Result := <<
								extract_locale_string (current_lcid, nls_constants.locale_sdayname1,
												nls_constants.locale_sdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sdayname2,
												nls_constants.locale_sdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sdayname3,
												nls_constants.locale_sdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sdayname4,
												nls_constants.locale_sdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sdayname5,
												nls_constants.locale_sdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sdayname6,
												nls_constants.locale_sdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sdayname7,
												nls_constants.locale_sdayname_maxlen)
							>>
			end

		get_abbreviated_day_names: ARRAY[STRING_32] is
				--
			do
				Result := <<
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname1,
												nls_constants.locale_sabbrevdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname2,
												nls_constants.locale_sabbrevdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname3,
												nls_constants.locale_sabbrevdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname4,
												nls_constants.locale_sabbrevdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname5,
												nls_constants.locale_sabbrevdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname6,
												nls_constants.locale_sabbrevdayname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevdayname7,
												nls_constants.locale_sabbrevdayname_maxlen)
							>>
			end

		get_month_names: ARRAY[STRING_32] is
				--
			do
				Result := <<
								extract_locale_string (current_lcid, nls_constants.locale_smonthname1,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname2,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname3,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname4,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname5,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname6,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname7,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname8,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname9,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname10,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname11,
												nls_constants.locale_smonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_smonthname12,
												nls_constants.locale_smonthname_maxlen)
							>>
			end


	get_abbreviated_month_names: ARRAY[STRING_32] is
				--
			do
				Result := <<
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname1,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname2,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname3,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname4,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname5,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname6,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname7,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname8,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname9,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname10,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname11,
												nls_constants.locale_sabbrevmonthname_maxlen),
								extract_locale_string (current_lcid, nls_constants.locale_sabbrevmonthname12,
												nls_constants.locale_sabbrevmonthname_maxlen)
							>>
			end

	feature {NONE} -- time formatting

		get_am_suffix: STRING_32 is
				--
			do
				Result := extract_locale_string (current_lcid, nls_constants.locale_s1159,
												nls_constants.locale_s1159_maxlen)
			end

		get_pm_suffix: STRING_32 is
				--
			do
				Result:= extract_locale_string (current_lcid, nls_constants.locale_s2359,
												nls_constants.locale_s2359_maxlen)
			end

		get_short_time_format: STRING_32 is
				-- TODO: Returns native string, this needs to fixed when we get the time formatter sorted out!
			do
				Result:= translate_time_format (
						extract_locale_string (current_lcid, nls_constants.locale_stimeformat,
												nls_constants.locale_stimeformat_maxlen))
			end

		get_long_time_format: STRING_32 is
				--
			do
				Result := get_short_time_format
			end

	feature {NONE} -- Current locale

		current_lcid: INTEGER

	feature {NONE} -- Transformation

	grouping_string_to_integer(string: STRING_32): ARRAY[INTEGER] is
				--
			local
				temp: LIST[STRING_32]
				position: INTEGER
			do
				temp := string.split (';')
				create Result.make(1, temp.count)
				from
					temp.start
					position := 1
				until
					temp.after
				loop
					Result.put(temp.item.to_integer,position)
					position := position + 1
					temp.forth
				end
			end
end
