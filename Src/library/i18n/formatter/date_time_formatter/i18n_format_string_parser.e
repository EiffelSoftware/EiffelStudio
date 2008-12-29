note
	description: "[
		Object that allows parsing formatting strings,
		as defined in the POSIX standard
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_FORMAT_STRING_PARSER

inherit
	ANY

	I18N_FORMATTING_CHARACTERS
		export
			{NONE} all
		end

	I18N_FORMATTING_ACTIONS
		export
			{NONE} all
		end

create
	make

feature -- Parser

	make (a_locale_info: I18N_LOCALE_INFO)
			-- Creation procedure
		require
			a_locale_info_exists: a_locale_info /= Void
		do
			locale_info := a_locale_info
		end

	parse (a_string: STRING_32): LINKED_LIST [I18N_FORMATTING_ELEMENT]
			-- parse `a_string', for every format character, create
			-- appropriate formatting_element and put it in the list
			-- returned as result
		require
			a_string_exists: a_string /= Void
		local
			i: INTEGER_32
			next_escape_char: INTEGER_32
			l_format_code: I18N_FORMATTING_ELEMENT
			t_char: CHARACTER_8
		do
			create Result.make
			from
				i := 1
			until
				i > a_string.count
			loop
				next_escape_char := a_string.index_of (Escape_character, i)
				if next_escape_char = 0 or next_escape_char = a_string.count then
					create {I18N_USERSTRING_ELEMENT} l_format_code.make (a_string.substring (i, a_string.count))
					i := a_string.count + 1
					Result.extend (l_format_code.twin)
				else
					if (next_escape_char - i) > 0 then
						create {I18N_USERSTRING_ELEMENT} l_format_code.make (a_string.substring (i, next_escape_char - 1))
						Result.extend (l_format_code.twin)
					end
					t_char := a_string.item (next_escape_char + 1).to_character_8
					inspect t_char
					when Day_of_month then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent day_of_month_action)
					when Day_of_month_padded then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent day_of_month_padded_action)
					when Abbreviated_day_name then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent abbreviated_day_name_action (?, locale_info))
					when Day_name then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent day_name_action (?, locale_info))
					when Day_of_year then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent day_of_year_action)
					when Day_of_week then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent day_of_week_action)
					when Day_of_week_0 then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent day_of_week_0_action)
					when Month then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent month_action)
					when Month_padded then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent month_padded_action)
					when Abbreviated_month_name1, Abbreviated_month_name2 then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent abbreviated_month_name_action (?, locale_info))
					when Month_name then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent month_name_action (?, locale_info))
					when Century_number then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent century_number_action)
					when Iso_year_with_century then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent iso_year_with_century_action)
					when Iso_year_without_century then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent iso_year_without_century_action)
					when Week_number_iso then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent week_number_iso_action)
					when Week_number_sunday_as_first then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent week_number_sunday_as_first_action)
					when Week_number_monday_as_first then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent week_number_monday_as_first_action)
					when Year_1 then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent year_1_action)
					when Year_2 then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent year_2_action)
					when Year_4 then
						create {I18N_DATE_ELEMENT} l_format_code.make (agent year_4_action)
					when Hour_12_padded then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent hour_12_padded_action)
					when Hour_12 then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent hour_12_action)
					when Hour_24 then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent hour_24_action)
					when Hour_24_padded then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent hour_24_action)
					when Minutes then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent minutes_action)
					when Minutes_padded then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent minutes_padded_action)
					when Seconds then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent seconds_action)
					when Seconds_padded then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent seconds_padded_action)
					when Am_pm_1 then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent am_pm_1_action)
					when Am_pm_lowercase then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent am_pm_lowercase_action (?, locale_info))
					when Am_pm_uppercase then
						create {I18N_TIME_ELEMENT} l_format_code.make (agent am_pm_uppercase_action (?, locale_info))
					when Time_separator then
						create {I18N_USERSTRING_ELEMENT} l_format_code.make (locale_info.time_separator)
					when Date_separator then
						create {I18N_USERSTRING_ELEMENT} l_format_code.make (locale_info.date_separator)
					when Local_date_time then
						create {I18N_FORMAT_STRING} l_format_code.make (locale_info.date_time_format, locale_info)
					when Usa_date then
						create {I18N_FORMAT_STRING} l_format_code.make (Escape_character.out + Month_padded.out + "/" +
																		Escape_character.out + Day_of_month_padded.out + "/" +
																		Escape_character.out + Year_2.out, locale_info)
					when Iso_date then
						create {I18N_FORMAT_STRING} l_format_code.make (Escape_character.out + Year_4.out + "-" +
																		Escape_character.out + Month_padded.out + "-" +
																		Escape_character.out + Day_of_month_padded.out, locale_info)
					when Am_pm_time then
						create {I18N_FORMAT_STRING} l_format_code.make (Escape_character.out + Hour_12.out + ":" +
																		Escape_character.out + Minutes_padded.out + ":" +
																		Escape_character.out + Seconds.out + " " +
																		Escape_character.out + Am_pm_lowercase.out, locale_info)
					when Short_time_24h then
						create {I18N_FORMAT_STRING} l_format_code.make (Escape_character.out + Hour_24_padded.out + ":" +
																		Escape_character.out + Minutes_padded.out, locale_info)
					when Time_24h then
						create {I18N_FORMAT_STRING} l_format_code.make (Escape_character.out + Hour_24_padded.out + ":" +
																		Escape_character.out + Minutes_padded.out + ":" +
																		Escape_character.out + seconds.out, locale_info)
					when Local_date then
						create {I18N_FORMAT_STRING} l_format_code.make (locale_info.long_date_format, locale_info)
					when Locale_time then
						create {I18N_FORMAT_STRING} l_format_code.make (locale_info.long_time_format, locale_info)
					when Escape_character then
						create {I18N_USERSTRING_ELEMENT} l_format_code.make (Escape_character.out)
					when Tab then
						create {I18N_USERSTRING_ELEMENT} l_format_code.make ("%T")
					when New_line then
						create {I18N_USERSTRING_ELEMENT} l_format_code.make ("%N")
					when Modifier_character_1 then
						l_format_code := parse_modified_1 (t_char)
						i := next_escape_char + 2
					when Modifier_character_2 then
						l_format_code := parse_modified_2 (t_char)
						i := next_escape_char + 2
					else
						-- It isn't a supported character code, may be one of the following:
						--	. `era'
						--	. `time_zone_offset'
						--	. `time_zone_name'
						-- Ignore them and insert a space
						create {I18N_USERSTRING_ELEMENT} l_format_code.make (" ")
						i := next_escape_char + 1
					end
					i := next_escape_char + 2
					Result.extend (l_format_code)
				end
			end
		ensure
			Result_exists: Result /= Void
		end

 feature {NONE} -- Implementation

 	locale_info: I18N_LOCALE_INFO

 	parse_modified_1 (a_char: CHARACTER): I18N_FORMATTING_ELEMENT
 			-- this function is called when the escape character
 			-- was followed my the `modifier_character_1' = 'E'
 			-- NOTE: the formatting element produced, does not
 			-- correspond to the Value POSIX defined, because they are
 			-- still not implemented
 		do
 			inspect
 				a_char
 			when modified_date_time then
 				create {I18N_FORMAT_STRING} Result.make (locale_info.long_time_format+" "+locale_info.long_date_format, locale_info)
 			when modified_time then
 				create {I18N_FORMAT_STRING} Result.make (locale_info.long_time_format,locale_info)
 			when modified_date then
				create {I18N_FORMAT_STRING} Result.make (locale_info.long_date_format, locale_info)
 			when modified_year then
				create {I18N_DATE_ELEMENT} Result.make (agent year_4_action (?))
 			else
	 				-- not supported, it may be one of:
	 				--		. `modified_base_year_name'
	 				--		. `modified_base_year_offset'
	 				-- Insert a space
				create {I18N_USERSTRING_ELEMENT} Result.make (" ")
 			end
 		ensure
 			Result_exists: Result /= Void
 		end

 	parse_modified_2 (a_char: CHARACTER): I18N_FORMATTING_ELEMENT
 			-- this function is called when the escape character
 			-- was followed my the `modifier_character_1' = 'O'
 			-- NOTE: the formatting element produced, does not
 			-- correspond to the Value POSIX defined, because they are
 			-- still not implemented
 		do
 			inspect
 				a_char
 			when modified_time_24h then
 				create {I18N_FORMAT_STRING} Result.make (Escape_character.out+hour_24_padded.out+":"+
																Escape_character.out+minutes_padded.out+":"+
																Escape_character.out+seconds.out, locale_info)
 			when modified_time_12h then
				create {I18N_FORMAT_STRING} Result.make (Escape_character.out+hour_12.out+":"+
																Escape_character.out+minutes_padded.out+":"+
																Escape_character.out+seconds.out+" "+
																Escape_character.out+am_pm_lowercase.out, locale_info)
 			when modified_minutes then
				create {I18N_FORMAT_STRING} Result.make (Escape_character.out+minutes.out, locale_info)
 			when modified_seconds then
 				create {I18N_FORMAT_STRING} Result.make (Escape_character.out+seconds.out, locale_info)
 			when modified_day_of_month_0_padded then
 				create {I18N_DATE_ELEMENT} Result.make (agent day_of_month_action (?))
 			when modified_day_of_month_space_padded then
 				create {I18N_DATE_ELEMENT} Result.make (agent day_of_month_padded_action (?))
 			when modified_month then
				create {I18N_DATE_ELEMENT} Result.make (agent month_action (?))
			when modified_weekday then
				create {I18N_DATE_ELEMENT} Result.make (agent day_name_action (?, locale_info))
			when modified_week_number, modified_week_number_sunday_as_first then
				create {I18N_DATE_ELEMENT} Result.make (agent week_number_sunday_as_first_action (?))
			when modified_week_number_monday_as_first_2, modified_week_number_monday_as_first_1 then
				create {I18N_DATE_ELEMENT} Result.make (agent week_number_sunday_as_first_action (?))
 			else
	 				-- not supported, it may be one of:
	 				--		. `modified_era'
	 				-- Insert a space
				create {I18N_USERSTRING_ELEMENT} Result.make (" ")
 			end
 		ensure
 			Result_exists: Result /= Void
 		end

invariant
	locale_info_exists: locale_info /= Void

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
