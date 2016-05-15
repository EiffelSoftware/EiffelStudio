note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TIME_ZONE

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
	make_with_name_,
	make_with_name__data_,
	make

feature -- NSTimeZone

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	seconds_from_gmt_for_date_ (a_date: detachable NS_DATE): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			Result := objc_seconds_from_gmt_for_date_ (item, a_date__item)
		end

	abbreviation_for_date_ (a_date: detachable NS_DATE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			result_pointer := objc_abbreviation_for_date_ (item, a_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like abbreviation_for_date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like abbreviation_for_date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_daylight_saving_time_for_date_ (a_date: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			Result := objc_is_daylight_saving_time_for_date_ (item, a_date__item)
		end

	daylight_saving_time_offset_for_date_ (a_date: detachable NS_DATE): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			Result := objc_daylight_saving_time_offset_for_date_ (item, a_date__item)
		end

	next_daylight_saving_time_transition_after_date_ (a_date: detachable NS_DATE): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			result_pointer := objc_next_daylight_saving_time_transition_after_date_ (item, a_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_daylight_saving_time_transition_after_date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_daylight_saving_time_transition_after_date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSTimeZone Externals

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item name];
			 ]"
		end

	objc_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item data];
			 ]"
		end

	objc_seconds_from_gmt_for_date_ (an_item: POINTER; a_date: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item secondsFromGMTForDate:$a_date];
			 ]"
		end

	objc_abbreviation_for_date_ (an_item: POINTER; a_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item abbreviationForDate:$a_date];
			 ]"
		end

	objc_is_daylight_saving_time_for_date_ (an_item: POINTER; a_date: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item isDaylightSavingTimeForDate:$a_date];
			 ]"
		end

	objc_daylight_saving_time_offset_for_date_ (an_item: POINTER; a_date: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item daylightSavingTimeOffsetForDate:$a_date];
			 ]"
		end

	objc_next_daylight_saving_time_transition_after_date_ (an_item: POINTER; a_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item nextDaylightSavingTimeTransitionAfterDate:$a_date];
			 ]"
		end

feature -- NSExtendedTimeZone

	seconds_from_gmt: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_seconds_from_gmt (item)
		end

	abbreviation: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_abbreviation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like abbreviation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like abbreviation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_daylight_saving_time: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_daylight_saving_time (item)
		end

	daylight_saving_time_offset: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_daylight_saving_time_offset (item)
		end

	next_daylight_saving_time_transition: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_daylight_saving_time_transition (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_daylight_saving_time_transition} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_daylight_saving_time_transition} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_equal_to_time_zone_ (a_time_zone: detachable NS_TIME_ZONE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_time_zone__item: POINTER
		do
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			Result := objc_is_equal_to_time_zone_ (item, a_time_zone__item)
		end

	localized_name__locale_ (a_style: INTEGER_64; a_locale: detachable NS_LOCALE): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			result_pointer := objc_localized_name__locale_ (item, a_style, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSExtendedTimeZone Externals

	objc_seconds_from_gmt (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item secondsFromGMT];
			 ]"
		end

	objc_abbreviation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item abbreviation];
			 ]"
		end

	objc_is_daylight_saving_time (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item isDaylightSavingTime];
			 ]"
		end

	objc_daylight_saving_time_offset (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item daylightSavingTimeOffset];
			 ]"
		end

	objc_next_daylight_saving_time_transition (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item nextDaylightSavingTimeTransition];
			 ]"
		end

	objc_is_equal_to_time_zone_ (an_item: POINTER; a_time_zone: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTimeZone *)$an_item isEqualToTimeZone:$a_time_zone];
			 ]"
		end

	objc_localized_name__locale_ (an_item: POINTER; a_style: INTEGER_64; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item localizedName:$a_style locale:$a_locale];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_name_ (a_tz_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_tz_name__item: POINTER
		do
			if attached a_tz_name as a_tz_name_attached then
				a_tz_name__item := a_tz_name_attached.item
			end
			make_with_pointer (objc_init_with_name_(allocate_object, a_tz_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_name__data_ (a_tz_name: detachable NS_STRING; a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_tz_name__item: POINTER
			a_data__item: POINTER
		do
			if attached a_tz_name as a_tz_name_attached then
				a_tz_name__item := a_tz_name_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_name__data_(allocate_object, a_tz_name__item, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTimeZoneCreation Externals

	objc_init_with_name_ (an_item: POINTER; a_tz_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item initWithName:$a_tz_name];
			 ]"
		end

	objc_init_with_name__data_ (an_item: POINTER; a_tz_name: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTimeZone *)$an_item initWithName:$a_tz_name data:$a_data];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTimeZone"
		end

end
