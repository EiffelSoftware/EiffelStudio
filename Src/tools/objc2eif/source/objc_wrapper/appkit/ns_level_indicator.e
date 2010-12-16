note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_LEVEL_INDICATOR

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

feature -- NSLevelIndicator

	min_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_value (item)
		end

	set_min_value_ (a_min_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_value_ (item, a_min_value)
		end

	max_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_value (item)
		end

	set_max_value_ (a_max_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_value_ (item, a_max_value)
		end

	warning_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_warning_value (item)
		end

	set_warning_value_ (a_warning_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_warning_value_ (item, a_warning_value)
		end

	critical_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_critical_value (item)
		end

	set_critical_value_ (a_critical_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_critical_value_ (item, a_critical_value)
		end

	tick_mark_position: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tick_mark_position (item)
		end

	set_tick_mark_position_ (a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_tick_mark_position_ (item, a_position)
		end

	number_of_tick_marks: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_tick_marks (item)
		end

	set_number_of_tick_marks_ (a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_number_of_tick_marks_ (item, a_count)
		end

	number_of_major_tick_marks: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_major_tick_marks (item)
		end

	set_number_of_major_tick_marks_ (a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_number_of_major_tick_marks_ (item, a_count)
		end

	tick_mark_value_at_index_ (a_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tick_mark_value_at_index_ (item, a_index)
		end

	rect_of_tick_mark_at_index_ (a_index: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_of_tick_mark_at_index_ (item, Result.item, a_index)
		end

feature {NONE} -- NSLevelIndicator Externals

	objc_min_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item minValue];
			 ]"
		end

	objc_set_min_value_ (an_item: POINTER; a_min_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setMinValue:$a_min_value];
			 ]"
		end

	objc_max_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item maxValue];
			 ]"
		end

	objc_set_max_value_ (an_item: POINTER; a_max_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setMaxValue:$a_max_value];
			 ]"
		end

	objc_warning_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item warningValue];
			 ]"
		end

	objc_set_warning_value_ (an_item: POINTER; a_warning_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setWarningValue:$a_warning_value];
			 ]"
		end

	objc_critical_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item criticalValue];
			 ]"
		end

	objc_set_critical_value_ (an_item: POINTER; a_critical_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setCriticalValue:$a_critical_value];
			 ]"
		end

	objc_tick_mark_position (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item tickMarkPosition];
			 ]"
		end

	objc_set_tick_mark_position_ (an_item: POINTER; a_position: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setTickMarkPosition:$a_position];
			 ]"
		end

	objc_number_of_tick_marks (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item numberOfTickMarks];
			 ]"
		end

	objc_set_number_of_tick_marks_ (an_item: POINTER; a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setNumberOfTickMarks:$a_count];
			 ]"
		end

	objc_number_of_major_tick_marks (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item numberOfMajorTickMarks];
			 ]"
		end

	objc_set_number_of_major_tick_marks_ (an_item: POINTER; a_count: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLevelIndicator *)$an_item setNumberOfMajorTickMarks:$a_count];
			 ]"
		end

	objc_tick_mark_value_at_index_ (an_item: POINTER; a_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLevelIndicator *)$an_item tickMarkValueAtIndex:$a_index];
			 ]"
		end

	objc_rect_of_tick_mark_at_index_ (an_item: POINTER; result_pointer: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLevelIndicator *)$an_item rectOfTickMarkAtIndex:$a_index];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSLevelIndicator"
		end

end