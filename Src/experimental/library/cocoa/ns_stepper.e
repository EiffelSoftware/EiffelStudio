note
	description: "Wrapper for NSStepper."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STEPPER

inherit
	NS_CONTROL
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_shared (stepper_new)
		end

feature -- Access

	set_min_value (a_value: DOUBLE)
		do
			stepper_set_min_value (item, a_value)
		end

	set_max_value (a_value: DOUBLE)
		do
			stepper_set_max_value (item, a_value)
		end

	set_value_wraps (a_flag: BOOLEAN)
		do
			stepper_set_value_wraps (item, a_flag)
		end

feature {NONE} -- Objective-C implementation

	frozen stepper_new: POINTER
			-- Create a new NSButton
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSStepper new];"
		end

	frozen stepper_min_value (a_stepper: POINTER): DOUBLE
			--- (double)minValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSStepper*)$a_stepper minValue];"
		end

	frozen stepper_set_min_value (a_stepper: POINTER; a_double: DOUBLE)
			-- - (void)setMinValue:(double)minValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSStepper*)$a_stepper setMinValue: $a_double];"
		end

	frozen stepper_max_value (a_stepper: POINTER): DOUBLE
			--- (double)maxValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSStepper*)$a_stepper maxValue];"
		end

	frozen stepper_set_max_value (a_stepper: POINTER; a_double: DOUBLE)
			-- - (void)setMaxValue:(double)maxValue;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSStepper*)$a_stepper setMaxValue: $a_double];"
		end

--- (double)increment;
--- (void)setIncrement:(double)increment;

--- (BOOL)valueWraps;
	frozen stepper_set_value_wraps (a_stepper: POINTER; a_flag: BOOLEAN)
			-- - (void)setValueWraps:(BOOL)valueWraps;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSStepper*)$a_stepper setValueWraps: $a_flag];"
		end

--- (BOOL)autorepeat;
--- (void)setAutorepeat:(BOOL)autorepeat;


end
