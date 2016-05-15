note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CALENDAR_DATE

inherit
	NS_DATE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_string__calendar_format__locale_,
	make_with_string__calendar_format_,
	make_with_string_,
	make_with_year__month__day__hour__minute__second__time_zone_,
	make,
	make_with_time_interval_since_now_,
	make_with_time_interval_since_reference_date_,
	make_with_time_interval_since1970_,
	make_with_time_interval__since_date_

feature -- NSCalendarDate

	date_by_adding_years__months__days__hours__minutes__seconds_ (a_year: INTEGER_64; a_month: INTEGER_64; a_day: INTEGER_64; a_hour: INTEGER_64; a_minute: INTEGER_64; a_second: INTEGER_64): detachable NS_CALENDAR_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_date_by_adding_years__months__days__hours__minutes__seconds_ (item, a_year, a_month, a_day, a_hour, a_minute, a_second)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_by_adding_years__months__days__hours__minutes__seconds_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_by_adding_years__months__days__hours__minutes__seconds_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	day_of_common_era: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_day_of_common_era (item)
		end

	day_of_month: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_day_of_month (item)
		end

	day_of_week: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_day_of_week (item)
		end

	day_of_year: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_day_of_year (item)
		end

	hour_of_day: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hour_of_day (item)
		end

	minute_of_hour: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minute_of_hour (item)
		end

	month_of_year: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_month_of_year (item)
		end

	second_of_minute: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_second_of_minute (item)
		end

	year_of_common_era: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_year_of_common_era (item)
		end

	calendar_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_calendar_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like calendar_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like calendar_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description_with_calendar_format__locale_ (a_format: detachable NS_STRING; a_locale: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_format__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_description_with_calendar_format__locale_ (item, a_format__item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_calendar_format__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_calendar_format__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description_with_calendar_format_ (a_format: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			result_pointer := objc_description_with_calendar_format_ (item, a_format__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_calendar_format_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_calendar_format_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	set_calendar_format_ (a_format: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			objc_set_calendar_format_ (item, a_format__item)
		end

	set_time_zone_ (a_time_zone: detachable NS_TIME_ZONE)
			-- Auto generated Objective-C wrapper.
		local
			a_time_zone__item: POINTER
		do
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			objc_set_time_zone_ (item, a_time_zone__item)
		end

--	years__months__days__hours__minutes__seconds__since_date_ (a_yp: UNSUPPORTED_TYPE; a_mop: UNSUPPORTED_TYPE; a_dp: UNSUPPORTED_TYPE; a_hp: UNSUPPORTED_TYPE; a_mip: UNSUPPORTED_TYPE; a_sp: UNSUPPORTED_TYPE; a_date: detachable NS_CALENDAR_DATE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_yp__item: POINTER
--			a_mop__item: POINTER
--			a_dp__item: POINTER
--			a_hp__item: POINTER
--			a_mip__item: POINTER
--			a_sp__item: POINTER
--			a_date__item: POINTER
--		do
--			if attached a_yp as a_yp_attached then
--				a_yp__item := a_yp_attached.item
--			end
--			if attached a_mop as a_mop_attached then
--				a_mop__item := a_mop_attached.item
--			end
--			if attached a_dp as a_dp_attached then
--				a_dp__item := a_dp_attached.item
--			end
--			if attached a_hp as a_hp_attached then
--				a_hp__item := a_hp_attached.item
--			end
--			if attached a_mip as a_mip_attached then
--				a_mip__item := a_mip_attached.item
--			end
--			if attached a_sp as a_sp_attached then
--				a_sp__item := a_sp_attached.item
--			end
--			if attached a_date as a_date_attached then
--				a_date__item := a_date_attached.item
--			end
--			objc_years__months__days__hours__minutes__seconds__since_date_ (item, a_yp__item, a_mop__item, a_dp__item, a_hp__item, a_mip__item, a_sp__item, a_date__item)
--		end

feature {NONE} -- NSCalendarDate Externals

	objc_date_by_adding_years__months__days__hours__minutes__seconds_ (an_item: POINTER; a_year: INTEGER_64; a_month: INTEGER_64; a_day: INTEGER_64; a_hour: INTEGER_64; a_minute: INTEGER_64; a_second: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item dateByAddingYears:$a_year months:$a_month days:$a_day hours:$a_hour minutes:$a_minute seconds:$a_second];
			 ]"
		end

	objc_day_of_common_era (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item dayOfCommonEra];
			 ]"
		end

	objc_day_of_month (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item dayOfMonth];
			 ]"
		end

	objc_day_of_week (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item dayOfWeek];
			 ]"
		end

	objc_day_of_year (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item dayOfYear];
			 ]"
		end

	objc_hour_of_day (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item hourOfDay];
			 ]"
		end

	objc_minute_of_hour (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item minuteOfHour];
			 ]"
		end

	objc_month_of_year (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item monthOfYear];
			 ]"
		end

	objc_second_of_minute (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item secondOfMinute];
			 ]"
		end

	objc_year_of_common_era (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendarDate *)$an_item yearOfCommonEra];
			 ]"
		end

	objc_calendar_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item calendarFormat];
			 ]"
		end

	objc_description_with_calendar_format__locale_ (an_item: POINTER; a_format: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item descriptionWithCalendarFormat:$a_format locale:$a_locale];
			 ]"
		end

	objc_description_with_calendar_format_ (an_item: POINTER; a_format: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item descriptionWithCalendarFormat:$a_format];
			 ]"
		end

	objc_time_zone (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item timeZone];
			 ]"
		end

	objc_init_with_string__calendar_format__locale_ (an_item: POINTER; a_description: POINTER; a_format: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item initWithString:$a_description calendarFormat:$a_format locale:$a_locale];
			 ]"
		end

	objc_init_with_string__calendar_format_ (an_item: POINTER; a_description: POINTER; a_format: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item initWithString:$a_description calendarFormat:$a_format];
			 ]"
		end

	objc_init_with_year__month__day__hour__minute__second__time_zone_ (an_item: POINTER; a_year: INTEGER_64; a_month: NATURAL_64; a_day: NATURAL_64; a_hour: NATURAL_64; a_minute: NATURAL_64; a_second: NATURAL_64; a_time_zone: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendarDate *)$an_item initWithYear:$a_year month:$a_month day:$a_day hour:$a_hour minute:$a_minute second:$a_second timeZone:$a_time_zone];
			 ]"
		end

	objc_set_calendar_format_ (an_item: POINTER; a_format: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCalendarDate *)$an_item setCalendarFormat:$a_format];
			 ]"
		end

	objc_set_time_zone_ (an_item: POINTER; a_time_zone: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCalendarDate *)$an_item setTimeZone:$a_time_zone];
			 ]"
		end

--	objc_years__months__days__hours__minutes__seconds__since_date_ (an_item: POINTER; a_yp: UNSUPPORTED_TYPE; a_mop: UNSUPPORTED_TYPE; a_dp: UNSUPPORTED_TYPE; a_hp: UNSUPPORTED_TYPE; a_mip: UNSUPPORTED_TYPE; a_sp: UNSUPPORTED_TYPE; a_date: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSCalendarDate *)$an_item years: months: days: hours: minutes: seconds: sinceDate:$a_date];
--			 ]"
--		end

feature {NONE} -- Initialization

	make_with_string__calendar_format__locale_ (a_description: detachable NS_STRING; a_format: detachable NS_STRING; a_locale: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_description__item: POINTER
			a_format__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_description as a_description_attached then
				a_description__item := a_description_attached.item
			end
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			make_with_pointer (objc_init_with_string__calendar_format__locale_(allocate_object, a_description__item, a_format__item, a_locale__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string__calendar_format_ (a_description: detachable NS_STRING; a_format: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_description__item: POINTER
			a_format__item: POINTER
		do
			if attached a_description as a_description_attached then
				a_description__item := a_description_attached.item
			end
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			make_with_pointer (objc_init_with_string__calendar_format_(allocate_object, a_description__item, a_format__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_year__month__day__hour__minute__second__time_zone_ (a_year: INTEGER_64; a_month: NATURAL_64; a_day: NATURAL_64; a_hour: NATURAL_64; a_minute: NATURAL_64; a_second: NATURAL_64; a_time_zone: detachable NS_TIME_ZONE)
			-- Initialize `Current'.
		local
			a_time_zone__item: POINTER
		do
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			make_with_pointer (objc_init_with_year__month__day__hour__minute__second__time_zone_(allocate_object, a_year, a_month, a_day, a_hour, a_minute, a_second, a_time_zone__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCalendarDate"
		end

end
