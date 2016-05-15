note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATE_COMPONENTS

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
	make

feature -- NSDateComponents

	era: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_era (item)
		end

	year: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_year (item)
		end

	month: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_month (item)
		end

	day: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_day (item)
		end

	hour: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hour (item)
		end

	minute: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_minute (item)
		end

	second: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_second (item)
		end

	week: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_week (item)
		end

	weekday: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_weekday (item)
		end

	weekday_ordinal: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_weekday_ordinal (item)
		end

	quarter: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_quarter (item)
		end

	set_era_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_era_ (item, a_v)
		end

	set_year_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_year_ (item, a_v)
		end

	set_month_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_month_ (item, a_v)
		end

	set_day_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_day_ (item, a_v)
		end

	set_hour_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hour_ (item, a_v)
		end

	set_minute_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_minute_ (item, a_v)
		end

	set_second_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_second_ (item, a_v)
		end

	set_week_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_week_ (item, a_v)
		end

	set_weekday_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_weekday_ (item, a_v)
		end

	set_weekday_ordinal_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_weekday_ordinal_ (item, a_v)
		end

	set_quarter_ (a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_quarter_ (item, a_v)
		end

feature {NONE} -- NSDateComponents Externals

	objc_era (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item era];
			 ]"
		end

	objc_year (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item year];
			 ]"
		end

	objc_month (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item month];
			 ]"
		end

	objc_day (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item day];
			 ]"
		end

	objc_hour (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item hour];
			 ]"
		end

	objc_minute (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item minute];
			 ]"
		end

	objc_second (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item second];
			 ]"
		end

	objc_week (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item week];
			 ]"
		end

	objc_weekday (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item weekday];
			 ]"
		end

	objc_weekday_ordinal (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item weekdayOrdinal];
			 ]"
		end

	objc_quarter (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDateComponents *)$an_item quarter];
			 ]"
		end

	objc_set_era_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setEra:$a_v];
			 ]"
		end

	objc_set_year_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setYear:$a_v];
			 ]"
		end

	objc_set_month_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setMonth:$a_v];
			 ]"
		end

	objc_set_day_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setDay:$a_v];
			 ]"
		end

	objc_set_hour_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setHour:$a_v];
			 ]"
		end

	objc_set_minute_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setMinute:$a_v];
			 ]"
		end

	objc_set_second_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setSecond:$a_v];
			 ]"
		end

	objc_set_week_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setWeek:$a_v];
			 ]"
		end

	objc_set_weekday_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setWeekday:$a_v];
			 ]"
		end

	objc_set_weekday_ordinal_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setWeekdayOrdinal:$a_v];
			 ]"
		end

	objc_set_quarter_ (an_item: POINTER; a_v: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDateComponents *)$an_item setQuarter:$a_v];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDateComponents"
		end

end
