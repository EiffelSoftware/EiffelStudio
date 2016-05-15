note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE_FORMATTER

inherit
	NS_FORMATTER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_date_format__allow_natural_language_,
	make

feature -- NSDateFormatter

--	get_object_value__for_string__range__error_ (a_obj: UNSUPPORTED_TYPE; a_string: detachable NS_STRING; a_rangep: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_obj__item: POINTER
--			a_string__item: POINTER
--			a_rangep__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_obj as a_obj_attached then
--				a_obj__item := a_obj_attached.item
--			end
--			if attached a_string as a_string_attached then
--				a_string__item := a_string_attached.item
--			end
--			if attached a_rangep as a_rangep_attached then
--				a_rangep__item := a_rangep_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_get_object_value__for_string__range__error_ (item, a_obj__item, a_string__item, a_rangep__item, a_error__item)
--		end

	string_from_date_ (a_date: detachable NS_DATE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			result_pointer := objc_string_from_date_ (item, a_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_from_date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_from_date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_from_string_ (a_string: detachable NS_STRING): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			result_pointer := objc_date_from_string_ (item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_from_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_from_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_date_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_date_style (item)
		end

	set_date_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_date_style_ (item, a_style)
		end

	time_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_time_style (item)
		end

	set_time_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_time_style_ (item, a_style)
		end

	locale: detachable NS_LOCALE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_locale (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like locale} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like locale} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_locale_ (a_locale: detachable NS_LOCALE)
			-- Auto generated Objective-C wrapper.
		local
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			objc_set_locale_ (item, a_locale__item)
		end

	generates_calendar_dates: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_generates_calendar_dates (item)
		end

	set_generates_calendar_dates_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_generates_calendar_dates_ (item, a_b)
		end

	formatter_behavior: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_formatter_behavior (item)
		end

	set_formatter_behavior_ (a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_formatter_behavior_ (item, a_behavior)
		end

	set_date_format_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_date_format_ (item, a_string__item)
		end

	time_zone: detachable NS_TIME_ZONE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_time_zone (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like time_zone} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like time_zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_time_zone_ (a_tz: detachable NS_TIME_ZONE)
			-- Auto generated Objective-C wrapper.
		local
			a_tz__item: POINTER
		do
			if attached a_tz as a_tz_attached then
				a_tz__item := a_tz_attached.item
			end
			objc_set_time_zone_ (item, a_tz__item)
		end

	calendar: detachable NS_CALENDAR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_calendar (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like calendar} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like calendar} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_calendar_ (a_calendar: detachable NS_CALENDAR)
			-- Auto generated Objective-C wrapper.
		local
			a_calendar__item: POINTER
		do
			if attached a_calendar as a_calendar_attached then
				a_calendar__item := a_calendar_attached.item
			end
			objc_set_calendar_ (item, a_calendar__item)
		end

	is_lenient: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_lenient (item)
		end

	set_lenient_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_lenient_ (item, a_b)
		end

	two_digit_start_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_two_digit_start_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like two_digit_start_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like two_digit_start_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_two_digit_start_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			objc_set_two_digit_start_date_ (item, a_date__item)
		end

	default_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_default_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_default_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			objc_set_default_date_ (item, a_date__item)
		end

	era_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_era_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like era_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like era_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_era_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_era_symbols_ (item, a_array__item)
		end

	month_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_month_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like month_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like month_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_month_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_month_symbols_ (item, a_array__item)
		end

	short_month_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_short_month_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like short_month_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like short_month_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_short_month_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_short_month_symbols_ (item, a_array__item)
		end

	weekday_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_weekday_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like weekday_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like weekday_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_weekday_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_weekday_symbols_ (item, a_array__item)
		end

	short_weekday_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_short_weekday_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like short_weekday_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like short_weekday_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_short_weekday_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_short_weekday_symbols_ (item, a_array__item)
		end

	am_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_am_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like am_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like am_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_am_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_am_symbol_ (item, a_string__item)
		end

	pm_symbol: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pm_symbol (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pm_symbol} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pm_symbol} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_pm_symbol_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_pm_symbol_ (item, a_string__item)
		end

	long_era_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_long_era_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like long_era_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like long_era_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_long_era_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_long_era_symbols_ (item, a_array__item)
		end

	very_short_month_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_very_short_month_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like very_short_month_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like very_short_month_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_very_short_month_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_very_short_month_symbols_ (item, a_array__item)
		end

	standalone_month_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standalone_month_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standalone_month_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standalone_month_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_standalone_month_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_standalone_month_symbols_ (item, a_array__item)
		end

	short_standalone_month_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_short_standalone_month_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like short_standalone_month_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like short_standalone_month_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_short_standalone_month_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_short_standalone_month_symbols_ (item, a_array__item)
		end

	very_short_standalone_month_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_very_short_standalone_month_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like very_short_standalone_month_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like very_short_standalone_month_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_very_short_standalone_month_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_very_short_standalone_month_symbols_ (item, a_array__item)
		end

	very_short_weekday_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_very_short_weekday_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like very_short_weekday_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like very_short_weekday_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_very_short_weekday_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_very_short_weekday_symbols_ (item, a_array__item)
		end

	standalone_weekday_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standalone_weekday_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standalone_weekday_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standalone_weekday_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_standalone_weekday_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_standalone_weekday_symbols_ (item, a_array__item)
		end

	short_standalone_weekday_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_short_standalone_weekday_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like short_standalone_weekday_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like short_standalone_weekday_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_short_standalone_weekday_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_short_standalone_weekday_symbols_ (item, a_array__item)
		end

	very_short_standalone_weekday_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_very_short_standalone_weekday_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like very_short_standalone_weekday_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like very_short_standalone_weekday_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_very_short_standalone_weekday_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_very_short_standalone_weekday_symbols_ (item, a_array__item)
		end

	quarter_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_quarter_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like quarter_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like quarter_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_quarter_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_quarter_symbols_ (item, a_array__item)
		end

	short_quarter_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_short_quarter_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like short_quarter_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like short_quarter_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_short_quarter_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_short_quarter_symbols_ (item, a_array__item)
		end

	standalone_quarter_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standalone_quarter_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standalone_quarter_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standalone_quarter_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_standalone_quarter_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_standalone_quarter_symbols_ (item, a_array__item)
		end

	short_standalone_quarter_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_short_standalone_quarter_symbols (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like short_standalone_quarter_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like short_standalone_quarter_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_short_standalone_quarter_symbols_ (a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_set_short_standalone_quarter_symbols_ (item, a_array__item)
		end

	gregorian_start_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_gregorian_start_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like gregorian_start_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like gregorian_start_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_gregorian_start_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			objc_set_gregorian_start_date_ (item, a_date__item)
		end

	does_relative_date_formatting: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_does_relative_date_formatting (item)
		end

	set_does_relative_date_formatting_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_does_relative_date_formatting_ (item, a_b)
		end

feature {NONE} -- NSDateFormatter Externals

--	objc_get_object_value__for_string__range__error_ (an_item: POINTER; a_obj: UNSUPPORTED_TYPE; a_string: POINTER; a_rangep: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSDateFormatter *)$an_item getObjectValue: forString:$a_string range: error:];
--			 ]"
--		end

	objc_string_from_date_ (an_item: POINTER; a_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item stringFromDate:$a_date];
			 ]"
		end

	objc_date_from_string_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item dateFromString:$a_string];
			 ]"
		end

	objc_date_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item dateFormat];
			 ]"
		end

	objc_date_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item dateStyle];
			 ]"
		end

	objc_set_date_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setDateStyle:$a_style];
			 ]"
		end

	objc_time_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item timeStyle];
			 ]"
		end

	objc_set_time_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setTimeStyle:$a_style];
			 ]"
		end

	objc_locale (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item locale];
			 ]"
		end

	objc_set_locale_ (an_item: POINTER; a_locale: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setLocale:$a_locale];
			 ]"
		end

	objc_generates_calendar_dates (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item generatesCalendarDates];
			 ]"
		end

	objc_set_generates_calendar_dates_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setGeneratesCalendarDates:$a_b];
			 ]"
		end

	objc_formatter_behavior (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item formatterBehavior];
			 ]"
		end

	objc_set_formatter_behavior_ (an_item: POINTER; a_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setFormatterBehavior:$a_behavior];
			 ]"
		end

	objc_set_date_format_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setDateFormat:$a_string];
			 ]"
		end

	objc_time_zone (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item timeZone];
			 ]"
		end

	objc_set_time_zone_ (an_item: POINTER; a_tz: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setTimeZone:$a_tz];
			 ]"
		end

	objc_calendar (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item calendar];
			 ]"
		end

	objc_set_calendar_ (an_item: POINTER; a_calendar: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setCalendar:$a_calendar];
			 ]"
		end

	objc_is_lenient (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item isLenient];
			 ]"
		end

	objc_set_lenient_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setLenient:$a_b];
			 ]"
		end

	objc_two_digit_start_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item twoDigitStartDate];
			 ]"
		end

	objc_set_two_digit_start_date_ (an_item: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setTwoDigitStartDate:$a_date];
			 ]"
		end

	objc_default_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item defaultDate];
			 ]"
		end

	objc_set_default_date_ (an_item: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setDefaultDate:$a_date];
			 ]"
		end

	objc_era_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item eraSymbols];
			 ]"
		end

	objc_set_era_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setEraSymbols:$a_array];
			 ]"
		end

	objc_month_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item monthSymbols];
			 ]"
		end

	objc_set_month_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setMonthSymbols:$a_array];
			 ]"
		end

	objc_short_month_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item shortMonthSymbols];
			 ]"
		end

	objc_set_short_month_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setShortMonthSymbols:$a_array];
			 ]"
		end

	objc_weekday_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item weekdaySymbols];
			 ]"
		end

	objc_set_weekday_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setWeekdaySymbols:$a_array];
			 ]"
		end

	objc_short_weekday_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item shortWeekdaySymbols];
			 ]"
		end

	objc_set_short_weekday_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setShortWeekdaySymbols:$a_array];
			 ]"
		end

	objc_am_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item AMSymbol];
			 ]"
		end

	objc_set_am_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setAMSymbol:$a_string];
			 ]"
		end

	objc_pm_symbol (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item PMSymbol];
			 ]"
		end

	objc_set_pm_symbol_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setPMSymbol:$a_string];
			 ]"
		end

	objc_long_era_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item longEraSymbols];
			 ]"
		end

	objc_set_long_era_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setLongEraSymbols:$a_array];
			 ]"
		end

	objc_very_short_month_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item veryShortMonthSymbols];
			 ]"
		end

	objc_set_very_short_month_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setVeryShortMonthSymbols:$a_array];
			 ]"
		end

	objc_standalone_month_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item standaloneMonthSymbols];
			 ]"
		end

	objc_set_standalone_month_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setStandaloneMonthSymbols:$a_array];
			 ]"
		end

	objc_short_standalone_month_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item shortStandaloneMonthSymbols];
			 ]"
		end

	objc_set_short_standalone_month_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setShortStandaloneMonthSymbols:$a_array];
			 ]"
		end

	objc_very_short_standalone_month_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item veryShortStandaloneMonthSymbols];
			 ]"
		end

	objc_set_very_short_standalone_month_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setVeryShortStandaloneMonthSymbols:$a_array];
			 ]"
		end

	objc_very_short_weekday_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item veryShortWeekdaySymbols];
			 ]"
		end

	objc_set_very_short_weekday_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setVeryShortWeekdaySymbols:$a_array];
			 ]"
		end

	objc_standalone_weekday_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item standaloneWeekdaySymbols];
			 ]"
		end

	objc_set_standalone_weekday_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setStandaloneWeekdaySymbols:$a_array];
			 ]"
		end

	objc_short_standalone_weekday_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item shortStandaloneWeekdaySymbols];
			 ]"
		end

	objc_set_short_standalone_weekday_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setShortStandaloneWeekdaySymbols:$a_array];
			 ]"
		end

	objc_very_short_standalone_weekday_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item veryShortStandaloneWeekdaySymbols];
			 ]"
		end

	objc_set_very_short_standalone_weekday_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setVeryShortStandaloneWeekdaySymbols:$a_array];
			 ]"
		end

	objc_quarter_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item quarterSymbols];
			 ]"
		end

	objc_set_quarter_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setQuarterSymbols:$a_array];
			 ]"
		end

	objc_short_quarter_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item shortQuarterSymbols];
			 ]"
		end

	objc_set_short_quarter_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setShortQuarterSymbols:$a_array];
			 ]"
		end

	objc_standalone_quarter_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item standaloneQuarterSymbols];
			 ]"
		end

	objc_set_standalone_quarter_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setStandaloneQuarterSymbols:$a_array];
			 ]"
		end

	objc_short_standalone_quarter_symbols (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item shortStandaloneQuarterSymbols];
			 ]"
		end

	objc_set_short_standalone_quarter_symbols_ (an_item: POINTER; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setShortStandaloneQuarterSymbols:$a_array];
			 ]"
		end

	objc_gregorian_start_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item gregorianStartDate];
			 ]"
		end

	objc_set_gregorian_start_date_ (an_item: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setGregorianStartDate:$a_date];
			 ]"
		end

	objc_does_relative_date_formatting (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item doesRelativeDateFormatting];
			 ]"
		end

	objc_set_does_relative_date_formatting_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateFormatter *)$an_item setDoesRelativeDateFormatting:$a_b];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_date_format__allow_natural_language_ (a_format: detachable NS_STRING; a_flag: BOOLEAN)
			-- Initialize `Current'.
		local
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			make_with_pointer (objc_init_with_date_format__allow_natural_language_(allocate_object, a_format__item, a_flag))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDateFormatterCompatibility Externals

	objc_init_with_date_format__allow_natural_language_ (an_item: POINTER; a_format: POINTER; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDateFormatter *)$an_item initWithDateFormat:$a_format allowNaturalLanguage:$a_flag];
			 ]"
		end

	objc_allows_natural_language (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateFormatter *)$an_item allowsNaturalLanguage];
			 ]"
		end

feature -- NSDateFormatterCompatibility

	allows_natural_language: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_natural_language (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDateFormatter"
		end

end
