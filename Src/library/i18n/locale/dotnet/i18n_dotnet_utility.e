note
	description: "[
		Object that allows convertion from a .NET
		format string to a format supported by
		the Eiffel i18n library
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "i18n-team"
	date: "$Date$"
	revision: "$Revision$"

class I18N_DOTNET_UTILITY

feature {I18N_HOST_LOCALE_IMP} -- Convertion functions

	convert_format_string (s: detachable SYSTEM_STRING): STRING_32
			-- convert a .NET format string
			-- to a format string supported by
			-- Eiffel i18n library
		do
			if s = Void then
				create Result.make_empty
			elseif s.length = 2 and s.chars (0) = '%%' then
					-- it is a single format code
				Result := s
				Result := convert_format_specifier (Result)
			else
					-- a format string
				Result := convert_format_specifier (s)
			end
		end

	convert_format_specifier (s: STRING_32): STRING_32
			-- convert a .NET format string
			-- to a format string supported by
			--Eiffel i18n library
		require
			s /= Void
		local
			i, next, count : INTEGER
			l_char: CHARACTER
		do
			create Result.make_empty
			from
				i := 1
--			variant
--				s.count - i + 1
			until
				i > s.count
			loop
				l_char := s.item (i).to_character_8
				if l_char = '%'' then
					-- it is a user string
					next := s.index_of ('%'',i+1)
					if next /= 0 then
						Result.append (s.substring (i+1, next-1))
						i := next + 1
					else
						Result.append (s.substring (i+1, s.count))
						i := s.count+1
					end
				elseif l_char = '\' then
							-- Displays the character literally.
							-- To display the backslash character, use "\\".
						if i + 1 <= s.count then
							Result.append_character (s.item (i+1))
						end
						i := i + 2
				else
					next := next_code (s, l_char, i)
					count := next - i
					inspect
						l_char
					when 'd' then
						if count = 1 then -- The day of the month. Single-digit days will not have a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Day_of_month)
						elseif count = 2 then -- The day of the month. Single-digit days will have a leading zero.			
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.day_of_month_padded)
						elseif count = 3 then -- The abbreviated name of the day of the week,
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Abbreviated_day_name)
						else -- The full name of the day of the week (count = 4)
							next := i + 4 -- max lenght of a format specifier is 4
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Day_name)
						end
					when 'h' then
						if count = 1 then -- The hour in a 12-hour clock.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Hour_12)
						else -- The hour in a 12-hour clock. Single-digit hours will have a leading zero. (count = 2)
							next := i + 2
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Hour_12_padded)
						end
					when 'H' then
						if count = 1 then
							-- The hour in a 24-hour clock. Single-digit hours will not have a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Hour_24)
						else -- The hour in a 24-hour clock. Single-digit hours will have a leading zero. (count = 2)
							next := i + 2
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Hour_24_padded)
						end
					when 'm' then
						if count = 1 then -- The minute. Single-digit minutes will not have a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Minutes)
						else -- The minute. Single-digit minutes will have a leading zero. (count = 2)
							next := i + 2
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Minutes_padded)
						end
					when 'M' then
						if count = 1 then
								-- The numeric month. Single-digit months will not have a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Month)
						elseif count = 2 then -- The numeric month. Single-digit months will have a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Month_padded)
						elseif count = 3 then -- The abbreviated name of the month,
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Abbreviated_month_name1)
						else -- The full name of the month. (count = 4)
							next := i + 4
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Month_name)
						end
					when 's' then
						if count = 1 then -- The second. Single-digit seconds will not have a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Seconds)
						else -- The second. Single-digit seconds will have a leading zero. (count = 2)
							next := i + 2
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Seconds_padded)
						end
					when 't' then
						if count = 1 then -- The first character in the AM/PM designator.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Am_pm_1)
						else -- The AM/PM designator defined in AMDesignator or PMDesignator, if any. (count = 2)
							next := i + 2
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Am_pm_uppercase)
						end
					when 'y' then
						if count = 1 then -- The year without the century. If the year without the century is less than 10, the year is displayed with no leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Year_1)
						elseif count = 2 then --The year without the century. If the year without the century is less than 10, the year is displayed with a leading zero.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Year_2)
						else -- The year in four digits
								-- We do not support years with more than 4 digits!
								-- including the century. Will pad with leading zeroes to get four digits.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Year_4)
						end
					when ':' then
								-- The default time separator defined in TimeSeparator.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Time_separator)
					when '/' then
								-- The default date separator defined in DateSeparator.
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Escape_character)
							Result.append_character ({I18N_FORMATTING_CHARACTERS}.Date_separator)
					when 'z', 'k', 'g' then
						-- One of the not supproted fotmat specifier:
						--		. z: time zone offset
						--		. k:Different values of the DateTime. Kind property, that is, Local, Utc, or Unspecified.
						--		. g:The period or era.
						-- Ignore them
					else
						Result.append_character (l_char)
					end
					i := next
				end
			end
		end

	next_code (s: STRING_32; a_char: CHARACTER; index: INTEGER): INTEGER
			-- find index of next format specifier
		do
			from
				Result := index + 1
			until
				Result > s.count or else a_char /= s.item (Result)
			loop
				Result := Result + 1
			variant
				s.count - Result + 1
			end
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
