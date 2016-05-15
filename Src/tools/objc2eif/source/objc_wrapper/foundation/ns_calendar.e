note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CALENDAR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_calendar_identifier_,
	make

feature {NONE} -- Initialization

	make_with_calendar_identifier_ (a_ident: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_ident__item: POINTER
		do
			if attached a_ident as a_ident_attached then
				a_ident__item := a_ident_attached.item
			end
			make_with_pointer (objc_init_with_calendar_identifier_(allocate_object, a_ident__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSCalendar Externals

	objc_init_with_calendar_identifier_ (an_item: POINTER; a_ident: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item initWithCalendarIdentifier:$a_ident];
			 ]"
		end

	objc_calendar_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item calendarIdentifier];
			 ]"
		end

	objc_set_locale_ (an_item: POINTER; a_locale: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCalendar *)$an_item setLocale:$a_locale];
			 ]"
		end

	objc_locale (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item locale];
			 ]"
		end

	objc_set_time_zone_ (an_item: POINTER; a_tz: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCalendar *)$an_item setTimeZone:$a_tz];
			 ]"
		end

	objc_time_zone (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item timeZone];
			 ]"
		end

	objc_set_first_weekday_ (an_item: POINTER; a_weekday: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCalendar *)$an_item setFirstWeekday:$a_weekday];
			 ]"
		end

	objc_first_weekday (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendar *)$an_item firstWeekday];
			 ]"
		end

	objc_set_minimum_days_in_first_week_ (an_item: POINTER; a_mdw: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCalendar *)$an_item setMinimumDaysInFirstWeek:$a_mdw];
			 ]"
		end

	objc_minimum_days_in_first_week (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendar *)$an_item minimumDaysInFirstWeek];
			 ]"
		end

	objc_minimum_range_of_unit_ (an_item: POINTER; result_pointer: POINTER; a_unit: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSCalendar *)$an_item minimumRangeOfUnit:$a_unit];
			 ]"
		end

	objc_maximum_range_of_unit_ (an_item: POINTER; result_pointer: POINTER; a_unit: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSCalendar *)$an_item maximumRangeOfUnit:$a_unit];
			 ]"
		end

	objc_range_of_unit__in_unit__for_date_ (an_item: POINTER; result_pointer: POINTER; a_smaller: NATURAL_64; a_larger: NATURAL_64; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSCalendar *)$an_item rangeOfUnit:$a_smaller inUnit:$a_larger forDate:$a_date];
			 ]"
		end

	objc_ordinality_of_unit__in_unit__for_date_ (an_item: POINTER; a_smaller: NATURAL_64; a_larger: NATURAL_64; a_date: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCalendar *)$an_item ordinalityOfUnit:$a_smaller inUnit:$a_larger forDate:$a_date];
			 ]"
		end

--	objc_range_of_unit__start_date__interval__for_date_ (an_item: POINTER; a_unit: NATURAL_64; a_datep: UNSUPPORTED_TYPE; a_tip: UNSUPPORTED_TYPE; a_date: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSCalendar *)$an_item rangeOfUnit:$a_unit startDate: interval: forDate:$a_date];
--			 ]"
--		end

	objc_date_from_components_ (an_item: POINTER; a_comps: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item dateFromComponents:$a_comps];
			 ]"
		end

	objc_components__from_date_ (an_item: POINTER; a_unit_flags: NATURAL_64; a_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item components:$a_unit_flags fromDate:$a_date];
			 ]"
		end

	objc_date_by_adding_components__to_date__options_ (an_item: POINTER; a_comps: POINTER; a_date: POINTER; a_opts: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item dateByAddingComponents:$a_comps toDate:$a_date options:$a_opts];
			 ]"
		end

	objc_components__from_date__to_date__options_ (an_item: POINTER; a_unit_flags: NATURAL_64; a_starting_date: POINTER; a_result_date: POINTER; a_opts: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCalendar *)$an_item components:$a_unit_flags fromDate:$a_starting_date toDate:$a_result_date options:$a_opts];
			 ]"
		end

feature -- NSCalendar

	calendar_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_calendar_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like calendar_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like calendar_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	set_first_weekday_ (a_weekday: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_first_weekday_ (item, a_weekday)
		end

	first_weekday: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_first_weekday (item)
		end

	set_minimum_days_in_first_week_ (a_mdw: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minimum_days_in_first_week_ (item, a_mdw)
		end

	minimum_days_in_first_week: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minimum_days_in_first_week (item)
		end

	minimum_range_of_unit_ (a_unit: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_minimum_range_of_unit_ (item, Result.item, a_unit)
		end

	maximum_range_of_unit_ (a_unit: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_maximum_range_of_unit_ (item, Result.item, a_unit)
		end

	range_of_unit__in_unit__for_date_ (a_smaller: NATURAL_64; a_larger: NATURAL_64; a_date: detachable NS_DATE): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			create Result.make
			objc_range_of_unit__in_unit__for_date_ (item, Result.item, a_smaller, a_larger, a_date__item)
		end

	ordinality_of_unit__in_unit__for_date_ (a_smaller: NATURAL_64; a_larger: NATURAL_64; a_date: detachable NS_DATE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			Result := objc_ordinality_of_unit__in_unit__for_date_ (item, a_smaller, a_larger, a_date__item)
		end

--	range_of_unit__start_date__interval__for_date_ (a_unit: NATURAL_64; a_datep: UNSUPPORTED_TYPE; a_tip: UNSUPPORTED_TYPE; a_date: detachable NS_DATE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_datep__item: POINTER
--			a_tip__item: POINTER
--			a_date__item: POINTER
--		do
--			if attached a_datep as a_datep_attached then
--				a_datep__item := a_datep_attached.item
--			end
--			if attached a_tip as a_tip_attached then
--				a_tip__item := a_tip_attached.item
--			end
--			if attached a_date as a_date_attached then
--				a_date__item := a_date_attached.item
--			end
--			Result := objc_range_of_unit__start_date__interval__for_date_ (item, a_unit, a_datep__item, a_tip__item, a_date__item)
--		end

	date_from_components_ (a_comps: detachable NS_DATE_COMPONENTS): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_comps__item: POINTER
		do
			if attached a_comps as a_comps_attached then
				a_comps__item := a_comps_attached.item
			end
			result_pointer := objc_date_from_components_ (item, a_comps__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_from_components_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_from_components_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	components__from_date_ (a_unit_flags: NATURAL_64; a_date: detachable NS_DATE): detachable NS_DATE_COMPONENTS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			result_pointer := objc_components__from_date_ (item, a_unit_flags, a_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components__from_date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components__from_date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_by_adding_components__to_date__options_ (a_comps: detachable NS_DATE_COMPONENTS; a_date: detachable NS_DATE; a_opts: NATURAL_64): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_comps__item: POINTER
			a_date__item: POINTER
		do
			if attached a_comps as a_comps_attached then
				a_comps__item := a_comps_attached.item
			end
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			result_pointer := objc_date_by_adding_components__to_date__options_ (item, a_comps__item, a_date__item, a_opts)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_by_adding_components__to_date__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_by_adding_components__to_date__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	components__from_date__to_date__options_ (a_unit_flags: NATURAL_64; a_starting_date: detachable NS_DATE; a_result_date: detachable NS_DATE; a_opts: NATURAL_64): detachable NS_DATE_COMPONENTS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_starting_date__item: POINTER
			a_result_date__item: POINTER
		do
			if attached a_starting_date as a_starting_date_attached then
				a_starting_date__item := a_starting_date_attached.item
			end
			if attached a_result_date as a_result_date_attached then
				a_result_date__item := a_result_date_attached.item
			end
			result_pointer := objc_components__from_date__to_date__options_ (item, a_unit_flags, a_starting_date__item, a_result_date__item, a_opts)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like components__from_date__to_date__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like components__from_date__to_date__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCalendar"
		end

end
