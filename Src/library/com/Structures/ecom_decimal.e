indexing
	description: "COM Decimal Structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DECIMAL

inherit	
	ECOM_STRUCTURE
	NUMERIC

creation
	make,
	make_by_pointer

feature  -- Access

	zero: ECOM_DECIMAL is
			--
		do
			create Result.make;
			ccom_decimal_value_zero (Result.item)
		end

	one: ECOM_DECIMAL is
			--
		do
			create Result.make;
			ccom_decimal_value_one (Result.item)
		end

feature -- status report

	divisible (other: ECOM_DECIMAL): BOOLEAN is
			--
		do
			Result := not (other = zero)
		end

	exponentiable (other: ECOM_DECIMAL): BOOLEAN is
			--
		do
			Result := false
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of DECIMAL (DECIMAL) structure
		do
			Result := c_size_of_decimal 
		end

feature -- Conversion

	rounded (value: INTEGER): ECOM_DECIMAL is
			-- Round value with `value' decimal places
		require
			valid_value: value >= 0
		do
			create Result.make
			ccom_decimal_round (item, value, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	ceiled_integer_portion: ECOM_DECIMAL is
			-- Integer portion of decimal value. The first negative 
			-- integer >= to the value is returned if the value is negative.
		do
			create Result.make
			ccom_decimal_fix (item, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	truncated_to_integer_portion: ECOM_DECIMAL is
			-- Integer portion of a decimal value. The first negative integer 
			-- <= to the value is returned if the value is negative.
		do
			create Result.make
			ccom_decimal_integer (item, Result.item)
		ensure
			valid_result: Result /= Void
		end

	absolute: ECOM_DECIMAL is
			-- Absolute value of decimal
		do
			create Result.make
			ccom_decimal_absolute (item, Result.item)
		ensure
			non_void_result: Result /= Void
		end

feature -- Basic operations
	
	prefix "-": ECOM_DECIMAL is
			-- Negative value of decimal
		do
			create Result.make
			ccom_decimal_negative (item, Result.item)
		end 
	
	infix "-" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Subtract with `other'
		do
			create Result.make
			ccom_decimal_subtract (item, other.item, Result.item)
		end

	infix "+" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Add with `other'
		do
			create Result.make
			ccom_decimal_add (item, other.item, Result.item)
		end 

	infix "*" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Multiply by `other'
		do
			create Result.make
			ccom_decimal_multiply (item, other.item, Result.item)
		end

	infix "/" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Multiply by `other'
		do
			create Result.make
			ccom_decimal_divide (item, other.item, Result.item)
		end

	prefix "+": ECOM_DECIMAL is
			-- Unary plus
		do
		end

	infix "^" (other: NUMERIC):NUMERIC is
			-- Current objects to the power 'other'
		do
		end

feature {NONE} -- Externals

	ccom_decimal_value_zero (a_ptr: POINTER) is
		external
			"C (EIF_POINTER)|%"E_Decimal.h%""
		end

	ccom_decimal_value_one (a_ptr: POINTER) is
		external
			"C (EIF_POINTER)|%"E_Decimal.h%""
		end

	ccom_decimal_divide (a_ptr, b_ptr, c_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		end

	ccom_decimal_round (a_ptr: POINTER; a_value: INTEGER; b_ptr:POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_INTEGER, EIF_POINTER)"
		end
		
	ccom_decimal_negative (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER)"
		end

	ccom_decimal_integer (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER)"
		end

	ccom_decimal_fix (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER)"
		end

	ccom_decimal_absolute (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER)"
		end

	c_size_of_decimal: INTEGER is
		external 
			"C [macro <wtypes.h>]"
		alias
			"sizeof(DECIMAL)"
		end

	ccom_decimal_add (ptr_1, ptr_2, ptr_3: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		end

	ccom_decimal_multiply (ptr_1, ptr_2, ptr_3: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		end
	
	ccom_decimal_subtract (ptr_1, ptr_2, ptr_3: POINTER) is
		external
			"c [macro %"E_Decimal.h%"] (EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		end

end -- class ECOM_DECIMAL

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
