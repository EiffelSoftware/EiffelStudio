indexing
	description: "COM Decimal Structure.  Wrapping COM DECIMAL type"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_DECIMAL

inherit	
	ECOM_STRUCTURE
		rename
			make as structure_make
		undefine
			is_equal
		end
	NUMERIC
		redefine
			is_equal
		end

creation
	make,
	make_from_pointer,
	make_from_double

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Initialiazation

	make is
		do
			structure_make
			ccom_decimal_value_zero (item)
		end

	make_from_double (dbl_value: DOUBLE) is
			-- Create with value 'dbl_value'
		do
			structure_make
			ccom_decimal_from_double (dbl_value, item)
		end

feature  -- Access

	zero: ECOM_DECIMAL is
			-- Neutral element for `+' operation
		do
			create Result.make;
			ccom_decimal_value_zero (Result.item)
		end

	one: ECOM_DECIMAL is
			-- Neutral element for `*' operation
		do
			create Result.make;
			ccom_decimal_value_one (Result.item)
		end

	scale: INTEGER is
			-- Scale of value.  e.g. 123.45 has a scale of 2
		require
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			Result := ccom_decimal_scale (item)
		end

feature -- status report

	is_equal (other: like Current): BOOLEAN is
			-- Is 'other' equal to Current object?
			-- Not implemented yet.
		do
			Result := True
		end

	divisible (other: ECOM_DECIMAL): BOOLEAN is
			-- Is divisible by `other'?
		do
			Result := not (other = zero)
		end

	exponentiable (other: ECOM_DECIMAL): BOOLEAN is
			-- Is exponentiable by `other'?
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
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_round (item, value, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	ceiled_integer_portion: ECOM_DECIMAL is
			-- Integer portion of decimal value. 
			-- The first negative integer >= to the value is returned if the value is negative.
		require
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_fix (item, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	truncated_to_integer_portion: ECOM_DECIMAL is
			-- Integer portion of a decimal value. The first negative integer 
			-- <= to the value is returned if the value is negative.
		require
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_integer (item, Result.item)
		ensure
			valid_result: Result /= Void
		end

	absolute: ECOM_DECIMAL is
			-- Absolute value of decimal
		require
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_absolute (item, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	truncated_to_double: DOUBLE is
			-- Double value
		do
			Result := ccom_decimal_to_double (item)
		end

feature -- Basic operations
	
	prefix "-": ECOM_DECIMAL is
			-- Negative value of decimal
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_negative (item, Result.item)
		end 
	
	infix "-" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Subtract with `other'
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_subtract (item, other.item, Result.item)
		end

	infix "+" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Add with `other'
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_add (item, other.item, Result.item)
		end 

	infix "*" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Multiply by `other'
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_multiply (item, other.item, Result.item)
		end

	infix "/" (other: ECOM_DECIMAL): ECOM_DECIMAL is
			-- Multiply by `other'
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_divide (item, other.item, Result.item)
		end

	prefix "+": ECOM_DECIMAL is
			-- Unary plus
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
		end

	infix "^" (other: NUMERIC):NUMERIC is
			-- Current objects to the power 'other'
		require else
			non_void_item: item /= Void
			valid_item: item /= default_pointer
		do
		end

feature {NONE} -- Externals

	ccom_decimal_to_double (a_ptr: POINTER): DOUBLE is
		external
			"C (DECIMAL *):EIF_DOUBLE|%"E_Decimal.h%""
		end

	ccom_decimal_from_double (dbl_value: DOUBLE; a_ptr: POINTER) is
		external
			"C [macro <oleauto.h>](EIF_DOUBLE, DECIMAL *)"
		alias
			"VarDecFromR8"
		end

	ccom_decimal_scale (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_Decimal.h%"] (DECIMAL *): EIF_INTEGER"
		end

	ccom_decimal_value_zero (a_ptr: POINTER) is
		external
			"C (DECIMAL *)|%"E_Decimal.h%""
		end

	ccom_decimal_value_one (a_ptr: POINTER) is
		external
			"C (DECIMAL *)|%"E_Decimal.h%""
		end

	ccom_decimal_divide (a_ptr, b_ptr, c_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_round (a_ptr: POINTER; a_value: INTEGER; b_ptr:POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, EIF_INTEGER, DECIMAL *)"
		end
		
	ccom_decimal_negative (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_integer (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_fix (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_absolute (a_ptr, b_ptr: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	c_size_of_decimal: INTEGER is
		external 
			"C [macro <wtypes.h>]"
		alias
			"sizeof(DECIMAL)"
		end

	ccom_decimal_add (ptr_1, ptr_2, ptr_3: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_multiply (ptr_1, ptr_2, ptr_3: POINTER) is
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *, DECIMAL *)"
		end
	
	ccom_decimal_subtract (ptr_1, ptr_2, ptr_3: POINTER) is
		external
			"C [macro %"E_Decimal.h%"] (DECIMAL *, DECIMAL *, DECIMAL *)"
		end

end -- class ECOM_DECIMAL

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
