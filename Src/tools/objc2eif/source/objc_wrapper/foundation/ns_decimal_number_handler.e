note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DECIMAL_NUMBER_HANDLER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_DECIMAL_NUMBER_BEHAVIORS_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_,
	make

feature {NONE} -- Initialization

	make_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_ (a_rounding_mode: NATURAL_64; a_scale: INTEGER_16; a_exact: BOOLEAN; a_overflow: BOOLEAN; a_underflow: BOOLEAN; a_divide_by_zero: BOOLEAN)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_(allocate_object, a_rounding_mode, a_scale, a_exact, a_overflow, a_underflow, a_divide_by_zero))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDecimalNumberHandler Externals

	objc_init_with_rounding_mode__scale__raise_on_exactness__raise_on_overflow__raise_on_underflow__raise_on_divide_by_zero_ (an_item: POINTER; a_rounding_mode: NATURAL_64; a_scale: INTEGER_16; a_exact: BOOLEAN; a_overflow: BOOLEAN; a_underflow: BOOLEAN; a_divide_by_zero: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDecimalNumberHandler *)$an_item initWithRoundingMode:$a_rounding_mode scale:$a_scale raiseOnExactness:$a_exact raiseOnOverflow:$a_overflow raiseOnUnderflow:$a_underflow raiseOnDivideByZero:$a_divide_by_zero];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDecimalNumberHandler"
		end

end
