note
	description: "Encapsulates information about date and time formatting"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class I18N_DATE_TIME_INFO

create make

feature {NONE} -- Initialization

	make
			-- initialize all attributes
		do
			set_date_time_format (Default_date_time_format)
			set_long_date_format (Default_long_time_format)
			set_short_date_format (Default_short_date_format)
			set_long_time_format (Default_long_time_format)
			set_short_time_format (Default_short_time_format)
			set_am_suffix (Default_am_suffix)
			set_pm_suffix (Default_pm_suffix)
			set_time_separator (Default_time_separator)
			set_date_separator (Default_date_separator)
			set_day_names (Default_day_names)
			set_month_names (Default_month_names)
			set_abbreviated_day_names (Default_abbreviated_day_names)
			set_abbreviated_month_names (Default_abbreviated_month_names)
		end


feature -- Access: Date and time formatting

	date_time_format: STRING_32

	long_date_format: STRING_32
	short_date_format: STRING_32

	long_time_format: STRING_32
	short_time_format: STRING_32

	am_suffix: STRING_32
	pm_suffix: STRING_32

	time_separator,
	date_separator: STRING_32

feature	-- Access: Day and month names

	day_names: ARRAY[STRING_32]
	month_names: ARRAY[STRING_32]

	abbreviated_day_names: ARRAY[STRING_32]
	abbreviated_month_names: ARRAY[STRING_32]

feature -- Element change

	set_day_names (a_day_names : ARRAY[STRING_32])
			-- set the day names
		require
			a_day_names_exist: a_day_names /= Void
		do
			day_names := a_day_names
		ensure
			day_names_set: day_names = a_day_names
		end

	set_abbreviated_day_names (a_abbreviated_day_names : ARRAY[STRING_32])
			-- set abbreviated day names
		require
			a_abbreviated_day_names_exists: a_abbreviated_day_names /= Void
		do
			abbreviated_day_names := a_abbreviated_day_names
		ensure
			abbreviated_day_names_set: abbreviated_day_names = a_abbreviated_day_names
		end

	set_month_names ( a_month_names : ARRAY[STRING_32])
			-- set month names
		require
			a_month_names_exists: a_month_names /= Void
		do
			month_names := a_month_names
		ensure
			minth_names_set: month_names = a_month_names
		end

	set_abbreviated_month_names (a_abbreviated_month_names : ARRAY[STRING_32])
			-- Set abbreviated month names
		require
			a_abbreviated_month_names_exists: a_abbreviated_month_names /= Void
		do
			abbreviated_month_names := a_abbreviated_month_names
		ensure
			abbreviated_month_names_set: abbreviated_month_names = a_abbreviated_month_names
		end

	set_date_time_format(format:READABLE_STRING_GENERAL)
			-- set the long date format string
		require
			argument_not_void: format /= Void
		do
			date_time_format := format.to_string_32
		ensure
			long_date_format_set: date_time_format.is_equal(format.as_string_32)
		end

	set_long_date_format(format:READABLE_STRING_GENERAL)
			-- set the long date format string
		require
			argument_not_void: format /= Void
		do
			long_date_format := format.to_string_32
		ensure
			long_date_format_set: long_date_format.is_equal(format.as_string_32)
		end

	set_short_date_format(format:READABLE_STRING_GENERAL)
			-- set the short date format string
		require
			argument_not_void: format /= Void
		do
			short_date_format := format.to_string_32
		ensure
			short_date_format_set: short_date_format.is_equal(format.as_string_32)
		end

	set_long_time_format(format:READABLE_STRING_GENERAL)
			-- set the long time format string
		require
			argument_not_void: format /= Void
		do
			long_time_format := format.to_string_32
		ensure
			long_time_format_set: long_time_format.is_equal(format.as_string_32)
		end

	set_short_time_format(format:READABLE_STRING_GENERAL)
			-- set the short time format string
		require
			argument_not_void: format /= Void
		do
			short_time_format := format.to_string_32
		ensure
			short_time_format_set: short_time_format.is_equal(format.as_string_32)
		end

	set_am_suffix(suffix:READABLE_STRING_GENERAL)
			-- set the am suffix
		require
			argument_not_void: suffix /= Void
		do
			am_suffix := suffix.to_string_32
		ensure
			am_suffix_set: am_suffix.is_equal(suffix.as_string_32)
		end

	set_pm_suffix(suffix:READABLE_STRING_GENERAL)
			-- set the pm suffix
		require
			argument_not_void: suffix /= Void
		do
			pm_suffix := suffix.to_string_32
		ensure
			pm_suffix_set: pm_suffix.is_equal(suffix.as_string_32)
		end

	set_time_separator(sep:READABLE_STRING_GENERAL)
			-- set the pm suffix
		require
			argument_not_void: sep /= Void
		do
			time_separator := sep.to_string_32
		ensure
			separator_set: time_separator.is_equal(sep.as_string_32)
		end

	set_date_separator(sep:READABLE_STRING_GENERAL)
			-- set the pm suffix
		require
			argument_not_void: sep /= Void
		do
			date_separator := sep.to_string_32
		ensure
			separator_set: date_separator.is_equal(sep.as_string_32)
		end

feature -- Access: Default Values

	Default_date_time_format: STRING_32
			-- The ISO 8601 complete date plus hours, minutes and seconds format
			-- without timezone information
			-- YYYY-MM-DDThh:mm:ss (eg 1997-07-16T19:20:30)
		once
			create Result.make_empty
			Result.append (Default_long_date_format)
			Result.extend ('T')
			Result.append (Default_long_time_format)
		ensure
			result_exists: Result /= Void
		end

	Default_long_date_format: STRING_32
			-- The ISO 8601 Complete date:
      		-- YYYY-MM-DD (eg 1997-07-16)
		once
			create Result.make_empty
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Year_4)
			Result.extend ('-')
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Month_padded)
			Result.extend ('-')
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Day_of_month)
		ensure
			result_exists: Result /= Void
		end

	Default_short_date_format: STRING_32
			-- The ISO 8601 Year and month:
      		-- YYYY-MM (eg 1997-07)
		once
			create Result.make_empty
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Year_4)
			Result.extend ('-')
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Month_padded)
		ensure
			result_exists: Result /= Void
		end

	Default_long_time_format: STRING_32
			-- hh:mm:ss (eg 19:20:30)
		once
			create Result.make_empty
			Result.append (Default_short_time_format)
			Result.extend (':')
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Seconds_padded)
		ensure
			result_exists: Result /= Void
		end

	Default_short_time_format: STRING_32
			-- hh:mm (eg 19:20)
		once
			create Result.make_empty
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Hour_24)
			Result.extend (':')
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Escape_character)
			Result.extend ({I18N_FORMATTING_CHARACTERS}.Minutes_padded)
		ensure
			result_exists: Result /= Void
		end

	Default_am_suffix: STRING_32
		once
			Result := {STRING_32} "am"
		ensure
			result_exists: Result /= Void
		end

	Default_pm_suffix: STRING_32
		once
			Result := {STRING_32} "pm"
		ensure
			result_exists: Result /= Void
		end

	Default_day_names: ARRAY[STRING_32]
		once
			Result := <<("Monday").to_string_32,
						("Tuesday").to_string_32,
						("Wednesday").to_string_32,
						("Thursday").to_string_32,
						("Friday").to_string_32,
						("Saturday").to_string_32,
						("Sunday").to_string_32>>
		ensure
			result_exists: Result /= Void
		end

	Default_month_names: ARRAY[STRING_32]
		once
			Result := <<("January").to_string_32,
						("February").to_string_32,
						("March").to_string_32,
						("April").to_string_32,
						("May").to_string_32,
						("June").to_string_32,
						("July").to_string_32,
						("August").to_string_32,
						("September").to_string_32,
						("October").to_string_32,
						("November").to_string_32,
						("December").to_string_32 >>
		ensure
			result_exists: Result /= Void
		end

	Default_abbreviated_day_names: ARRAY[STRING_32]
		once
			Result := <<("Mon").to_string_32,
						("Tue").to_string_32,
						("Wed").to_string_32,
						("Thu").to_string_32,
						("Fri").to_string_32,
						("Sat").to_string_32,
						("Sun").to_string_32 >>
		ensure
			result_exists: Result /= Void
		end

	Default_abbreviated_month_names: ARRAY[STRING_32]
		once
			Result := <<("Jan").to_string_32,
						("Feb").to_string_32,
						("Mar").to_string_32,
						("Apr").to_string_32,
						("May").to_string_32,
						("Jun").to_string_32,
						("Jul").to_string_32,
						("Aug").to_string_32,
						("Sep").to_string_32,
						("Oct").to_string_32,
						("Nov").to_string_32,
						("Dec").to_string_32>>
		ensure
			result_exists: Result /= Void
		end

	Default_date_separator: STRING_32
		once
			Result := {STRING_32} "/"
		ensure
			result_exists: Result /= Void
		end

	Default_time_separator: STRING_32
		once
			Result := {STRING_32} ":"
		ensure
			result_exists: Result /= Void
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
