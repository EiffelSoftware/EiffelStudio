note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE_PICKER

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSDatePicker

	date_picker_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_date_picker_style (item)
		end

	set_date_picker_style_ (a_new_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_date_picker_style_ (item, a_new_style)
		end

	is_bezeled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bezeled (item)
		end

	set_bezeled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezeled_ (item, a_flag)
		end

	is_bordered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bordered (item)
		end

	set_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bordered_ (item, a_flag)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_text_color_ (item, a_color__item)
		end

	date_picker_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_date_picker_mode (item)
		end

	set_date_picker_mode_ (a_new_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_date_picker_mode_ (item, a_new_mode)
		end

	date_picker_elements: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_date_picker_elements (item)
		end

	set_date_picker_elements_ (a_element_flags: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_date_picker_elements_ (item, a_element_flags)
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

	set_calendar_ (a_new_calendar: detachable NS_CALENDAR)
			-- Auto generated Objective-C wrapper.
		local
			a_new_calendar__item: POINTER
		do
			if attached a_new_calendar as a_new_calendar_attached then
				a_new_calendar__item := a_new_calendar_attached.item
			end
			objc_set_calendar_ (item, a_new_calendar__item)
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

	set_locale_ (a_new_locale: detachable NS_LOCALE)
			-- Auto generated Objective-C wrapper.
		local
			a_new_locale__item: POINTER
		do
			if attached a_new_locale as a_new_locale_attached then
				a_new_locale__item := a_new_locale_attached.item
			end
			objc_set_locale_ (item, a_new_locale__item)
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

	set_time_zone_ (a_new_time_zone: detachable NS_TIME_ZONE)
			-- Auto generated Objective-C wrapper.
		local
			a_new_time_zone__item: POINTER
		do
			if attached a_new_time_zone as a_new_time_zone_attached then
				a_new_time_zone__item := a_new_time_zone_attached.item
			end
			objc_set_time_zone_ (item, a_new_time_zone__item)
		end

	date_value: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_date_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_date_value_ (a_new_start_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_new_start_date__item: POINTER
		do
			if attached a_new_start_date as a_new_start_date_attached then
				a_new_start_date__item := a_new_start_date_attached.item
			end
			objc_set_date_value_ (item, a_new_start_date__item)
		end

	time_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_time_interval (item)
		end

	set_time_interval_ (a_new_time_interval: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_time_interval_ (item, a_new_time_interval)
		end

	min_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_min_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like min_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like min_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_min_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			objc_set_min_date_ (item, a_date__item)
		end

	max_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_max_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like max_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like max_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_max_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			objc_set_max_date_ (item, a_date__item)
		end

	delegate: detachable NS_DATE_PICKER_CELL_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (an_object: detachable NS_DATE_PICKER_CELL_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

feature {NONE} -- NSDatePicker Externals

	objc_date_picker_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item datePickerStyle];
			 ]"
		end

	objc_set_date_picker_style_ (an_item: POINTER; a_new_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setDatePickerStyle:$a_new_style];
			 ]"
		end

	objc_is_bezeled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item isBezeled];
			 ]"
		end

	objc_set_bezeled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setBezeled:$a_flag];
			 ]"
		end

	objc_is_bordered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item isBordered];
			 ]"
		end

	objc_set_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setBordered:$a_flag];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item drawsBackground];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item backgroundColor];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_text_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item textColor];
			 ]"
		end

	objc_set_text_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setTextColor:$a_color];
			 ]"
		end

	objc_date_picker_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item datePickerMode];
			 ]"
		end

	objc_set_date_picker_mode_ (an_item: POINTER; a_new_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setDatePickerMode:$a_new_mode];
			 ]"
		end

	objc_date_picker_elements (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item datePickerElements];
			 ]"
		end

	objc_set_date_picker_elements_ (an_item: POINTER; a_element_flags: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setDatePickerElements:$a_element_flags];
			 ]"
		end

	objc_calendar (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item calendar];
			 ]"
		end

	objc_set_calendar_ (an_item: POINTER; a_new_calendar: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setCalendar:$a_new_calendar];
			 ]"
		end

	objc_locale (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item locale];
			 ]"
		end

	objc_set_locale_ (an_item: POINTER; a_new_locale: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setLocale:$a_new_locale];
			 ]"
		end

	objc_time_zone (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item timeZone];
			 ]"
		end

	objc_set_time_zone_ (an_item: POINTER; a_new_time_zone: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setTimeZone:$a_new_time_zone];
			 ]"
		end

	objc_date_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item dateValue];
			 ]"
		end

	objc_set_date_value_ (an_item: POINTER; a_new_start_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setDateValue:$a_new_start_date];
			 ]"
		end

	objc_time_interval (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDatePicker *)$an_item timeInterval];
			 ]"
		end

	objc_set_time_interval_ (an_item: POINTER; a_new_time_interval: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setTimeInterval:$a_new_time_interval];
			 ]"
		end

	objc_min_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item minDate];
			 ]"
		end

	objc_set_min_date_ (an_item: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setMinDate:$a_date];
			 ]"
		end

	objc_max_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item maxDate];
			 ]"
		end

	objc_set_max_date_ (an_item: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setMaxDate:$a_date];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDatePicker *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDatePicker *)$an_item setDelegate:$an_object];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDatePicker"
		end

end
