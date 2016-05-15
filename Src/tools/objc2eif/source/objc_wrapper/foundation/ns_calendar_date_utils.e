note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CALENDAR_DATE_UTILS

inherit
	NS_DATE_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSCalendarDate

	calendar_date: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_calendar_date (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like calendar_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like calendar_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_with_string__calendar_format__locale_ (a_description: detachable NS_STRING; a_format: detachable NS_STRING; a_locale: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
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
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_date_with_string__calendar_format__locale_ (l_objc_class.item, a_description__item, a_format__item, a_locale__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_with_string__calendar_format__locale_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_with_string__calendar_format__locale_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_with_string__calendar_format_ (a_description: detachable NS_STRING; a_format: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_description__item: POINTER
			a_format__item: POINTER
		do
			if attached a_description as a_description_attached then
				a_description__item := a_description_attached.item
			end
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_date_with_string__calendar_format_ (l_objc_class.item, a_description__item, a_format__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_with_string__calendar_format_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_with_string__calendar_format_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_with_year__month__day__hour__minute__second__time_zone_ (a_year: INTEGER_64; a_month: NATURAL_64; a_day: NATURAL_64; a_hour: NATURAL_64; a_minute: NATURAL_64; a_second: NATURAL_64; a_time_zone: detachable NS_TIME_ZONE): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_time_zone__item: POINTER
		do
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_date_with_year__month__day__hour__minute__second__time_zone_ (l_objc_class.item, a_year, a_month, a_day, a_hour, a_minute, a_second, a_time_zone__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_with_year__month__day__hour__minute__second__time_zone_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_with_year__month__day__hour__minute__second__time_zone_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSCalendarDate Externals

	objc_calendar_date (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object calendarDate];
			 ]"
		end

	objc_date_with_string__calendar_format__locale_ (a_class_object: POINTER; a_description: POINTER; a_format: POINTER; a_locale: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dateWithString:$a_description calendarFormat:$a_format locale:$a_locale];
			 ]"
		end

	objc_date_with_string__calendar_format_ (a_class_object: POINTER; a_description: POINTER; a_format: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dateWithString:$a_description calendarFormat:$a_format];
			 ]"
		end

	objc_date_with_year__month__day__hour__minute__second__time_zone_ (a_class_object: POINTER; a_year: INTEGER_64; a_month: NATURAL_64; a_day: NATURAL_64; a_hour: NATURAL_64; a_minute: NATURAL_64; a_second: NATURAL_64; a_time_zone: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dateWithYear:$a_year month:$a_month day:$a_day hour:$a_hour minute:$a_minute second:$a_second timeZone:$a_time_zone];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCalendarDate"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
