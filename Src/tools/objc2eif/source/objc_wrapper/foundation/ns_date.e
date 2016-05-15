note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE

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
	make,
	make_with_time_interval_since_now_,
	make_with_time_interval_since_reference_date_,
	make_with_time_interval_since1970_,
	make_with_time_interval__since_date_,
	make_with_string_

feature -- NSDate

	time_interval_since_reference_date: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_time_interval_since_reference_date (item)
		end

feature {NONE} -- NSDate Externals

	objc_time_interval_since_reference_date (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDate *)$an_item timeIntervalSinceReferenceDate];
			 ]"
		end

feature -- NSExtendedDate

	time_interval_since_date_ (a_another_date: detachable NS_DATE): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_another_date__item: POINTER
		do
			if attached a_another_date as a_another_date_attached then
				a_another_date__item := a_another_date_attached.item
			end
			Result := objc_time_interval_since_date_ (item, a_another_date__item)
		end

	time_interval_since_now: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_time_interval_since_now (item)
		end

	time_interval_since1970: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_time_interval_since1970 (item)
		end

	date_by_adding_time_interval_ (a_ti: REAL_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_date_by_adding_time_interval_ (item, a_ti)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_by_adding_time_interval_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_by_adding_time_interval_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	earlier_date_ (a_another_date: detachable NS_DATE): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_another_date__item: POINTER
		do
			if attached a_another_date as a_another_date_attached then
				a_another_date__item := a_another_date_attached.item
			end
			result_pointer := objc_earlier_date_ (item, a_another_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like earlier_date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like earlier_date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	later_date_ (a_another_date: detachable NS_DATE): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_another_date__item: POINTER
		do
			if attached a_another_date as a_another_date_attached then
				a_another_date__item := a_another_date_attached.item
			end
			result_pointer := objc_later_date_ (item, a_another_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like later_date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like later_date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	compare_ (a_other: detachable NS_DATE): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_other__item: POINTER
		do
			if attached a_other as a_other_attached then
				a_other__item := a_other_attached.item
			end
			Result := objc_compare_ (item, a_other__item)
		end

	is_equal_to_date_ (a_other_date: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_other_date__item: POINTER
		do
			if attached a_other_date as a_other_date_attached then
				a_other_date__item := a_other_date_attached.item
			end
			Result := objc_is_equal_to_date_ (item, a_other_date__item)
		end

	description_with_locale_ (a_locale: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_description_with_locale_ (item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSExtendedDate Externals

	objc_time_interval_since_date_ (an_item: POINTER; a_another_date: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDate *)$an_item timeIntervalSinceDate:$a_another_date];
			 ]"
		end

	objc_time_interval_since_now (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDate *)$an_item timeIntervalSinceNow];
			 ]"
		end

	objc_time_interval_since1970 (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDate *)$an_item timeIntervalSince1970];
			 ]"
		end

	objc_date_by_adding_time_interval_ (an_item: POINTER; a_ti: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item dateByAddingTimeInterval:$a_ti];
			 ]"
		end

	objc_earlier_date_ (an_item: POINTER; a_another_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item earlierDate:$a_another_date];
			 ]"
		end

	objc_later_date_ (an_item: POINTER; a_another_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item laterDate:$a_another_date];
			 ]"
		end

	objc_compare_ (an_item: POINTER; a_other: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDate *)$an_item compare:$a_other];
			 ]"
		end

	objc_is_equal_to_date_ (an_item: POINTER; a_other_date: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDate *)$an_item isEqualToDate:$a_other_date];
			 ]"
		end

	objc_description_with_locale_ (an_item: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item descriptionWithLocale:$a_locale];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_time_interval_since_now_ (a_secs: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_time_interval_since_now_(allocate_object, a_secs))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_time_interval_since_reference_date_ (a_secs_to_be_added: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_time_interval_since_reference_date_(allocate_object, a_secs_to_be_added))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_time_interval_since1970_ (a_ti: REAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_time_interval_since1970_(allocate_object, a_ti))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_time_interval__since_date_ (a_secs_to_be_added: REAL_64; a_another_date: detachable NS_DATE)
			-- Initialize `Current'.
		local
			a_another_date__item: POINTER
		do
			if attached a_another_date as a_another_date_attached then
				a_another_date__item := a_another_date_attached.item
			end
			make_with_pointer (objc_init_with_time_interval__since_date_(allocate_object, a_secs_to_be_added, a_another_date__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_string_ (a_description: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_description__item: POINTER
		do
			if attached a_description as a_description_attached then
				a_description__item := a_description_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_description__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDateCreation Externals

	objc_init_with_time_interval_since_now_ (an_item: POINTER; a_secs: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item initWithTimeIntervalSinceNow:$a_secs];
			 ]"
		end

	objc_init_with_time_interval_since_reference_date_ (an_item: POINTER; a_secs_to_be_added: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item initWithTimeIntervalSinceReferenceDate:$a_secs_to_be_added];
			 ]"
		end

	objc_init_with_time_interval_since1970_ (an_item: POINTER; a_ti: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item initWithTimeIntervalSince1970:$a_ti];
			 ]"
		end

	objc_init_with_time_interval__since_date_ (an_item: POINTER; a_secs_to_be_added: REAL_64; a_another_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item initWithTimeInterval:$a_secs_to_be_added sinceDate:$a_another_date];
			 ]"
		end

feature -- NSCalendarDateExtras

	date_with_calendar_format__time_zone_ (a_format: detachable NS_STRING; a_time_zone: detachable NS_TIME_ZONE): detachable NS_CALENDAR_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_format__item: POINTER
			a_time_zone__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			result_pointer := objc_date_with_calendar_format__time_zone_ (item, a_format__item, a_time_zone__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_with_calendar_format__time_zone_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_with_calendar_format__time_zone_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description_with_calendar_format__time_zone__locale_ (a_format: detachable NS_STRING; a_time_zone: detachable NS_TIME_ZONE; a_locale: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_format__item: POINTER
			a_time_zone__item: POINTER
			a_locale__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_description_with_calendar_format__time_zone__locale_ (item, a_format__item, a_time_zone__item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description_with_calendar_format__time_zone__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description_with_calendar_format__time_zone__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSCalendarDateExtras Externals

	objc_date_with_calendar_format__time_zone_ (an_item: POINTER; a_format: POINTER; a_time_zone: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item dateWithCalendarFormat:$a_format timeZone:$a_time_zone];
			 ]"
		end

	objc_description_with_calendar_format__time_zone__locale_ (an_item: POINTER; a_format: POINTER; a_time_zone: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item descriptionWithCalendarFormat:$a_format timeZone:$a_time_zone locale:$a_locale];
			 ]"
		end

	objc_init_with_string_ (an_item: POINTER; a_description: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDate *)$an_item initWithString:$a_description];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDate"
		end

end
