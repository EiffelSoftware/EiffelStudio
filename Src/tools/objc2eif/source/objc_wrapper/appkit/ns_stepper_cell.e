note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STEPPER_CELL

inherit
	NS_ACTION_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSStepperCell

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

	increment: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_increment (item)
		end

	set_increment_ (a_increment: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_increment_ (item, a_increment)
		end

	value_wraps: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_value_wraps (item)
		end

	set_value_wraps_ (a_value_wraps: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_value_wraps_ (item, a_value_wraps)
		end

	autorepeat: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autorepeat (item)
		end

	set_autorepeat_ (a_autorepeat: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autorepeat_ (item, a_autorepeat)
		end

feature {NONE} -- NSStepperCell Externals

	objc_min_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStepperCell *)$an_item minValue];
			 ]"
		end

	objc_set_min_value_ (an_item: POINTER; a_min_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStepperCell *)$an_item setMinValue:$a_min_value];
			 ]"
		end

	objc_max_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStepperCell *)$an_item maxValue];
			 ]"
		end

	objc_set_max_value_ (an_item: POINTER; a_max_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStepperCell *)$an_item setMaxValue:$a_max_value];
			 ]"
		end

	objc_increment (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStepperCell *)$an_item increment];
			 ]"
		end

	objc_set_increment_ (an_item: POINTER; a_increment: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStepperCell *)$an_item setIncrement:$a_increment];
			 ]"
		end

	objc_value_wraps (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStepperCell *)$an_item valueWraps];
			 ]"
		end

	objc_set_value_wraps_ (an_item: POINTER; a_value_wraps: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStepperCell *)$an_item setValueWraps:$a_value_wraps];
			 ]"
		end

	objc_autorepeat (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStepperCell *)$an_item autorepeat];
			 ]"
		end

	objc_set_autorepeat_ (an_item: POINTER; a_autorepeat: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStepperCell *)$an_item setAutorepeat:$a_autorepeat];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSStepperCell"
		end

end
