note
	description: "COM Decimal Structure.  Wrapping COM DECIMAL type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			copy
		redefine
			is_equal
		end

create
	make,
	make_from_pointer,
	make_from_double

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature {NONE} -- Initialiazation

	make
		do
			structure_make
			ccom_decimal_value_zero (item)
		end

	make_from_double (dbl_value: DOUBLE)
			-- Create with value 'dbl_value'
		do
			structure_make
			ccom_decimal_from_double (dbl_value, item)
		end

feature  -- Access

	zero: ECOM_DECIMAL
			-- Neutral element for `+' operation
		do
			create Result.make;
			ccom_decimal_value_zero (Result.item)
		end

	one: ECOM_DECIMAL
			-- Neutral element for `*' operation
		do
			create Result.make;
			ccom_decimal_value_one (Result.item)
		end

	scale: INTEGER
			-- Scale of value.  e.g. 123.45 has a scale of 2
		require
			valid_item: item /= default_pointer
		do
			Result := ccom_decimal_scale (item)
		end

feature -- status report

	is_equal (other: like Current): BOOLEAN
			-- Is 'other' equal to Current object?
			-- Not implemented yet.
		do
			Result := True
		end

	divisible (other: ECOM_DECIMAL): BOOLEAN
			-- Is divisible by `other'?
		do
			Result := other /= zero
		end

	exponentiable (other: ECOM_DECIMAL): BOOLEAN
			-- Is exponentiable by `other'?
		do
			Result := False
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of DECIMAL (DECIMAL) structure
		do
			Result := c_size_of_decimal
		end

feature -- Conversion

	rounded (value: INTEGER): ECOM_DECIMAL
			-- Round value with `value' decimal places
		require
			valid_value: value >= 0
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_round (item, value, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	ceiled_integer_portion: ECOM_DECIMAL
			-- Integer portion of decimal value.
			-- The first negative integer >= to the value is returned if the value is negative.
		require
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_fix (item, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	truncated_to_integer_portion: ECOM_DECIMAL
			-- Integer portion of a decimal value. The first negative integer
			-- <= to the value is returned if the value is negative.
		require
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_integer (item, Result.item)
		ensure
			valid_result: Result /= Void
		end

	absolute: ECOM_DECIMAL
			-- Absolute value of decimal
		require
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_absolute (item, Result.item)
		ensure
			non_void_result: Result /= Void
		end

	truncated_to_double: DOUBLE
			-- Double value
		do
			Result := ccom_decimal_to_double (item)
		end

feature -- Basic operations

	opposite alias "-" alias "−": like Current
			-- Negative value of decimal
		require else
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_negative (item, Result.item)
		end

	minus alias "-" alias "−" (other: like Current): like Current
			-- Subtract with `other'
		require else
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_subtract (item, other.item, Result.item)
		end

	plus alias "+" (other: like Current): like Current
			-- Add with `other'
		require else
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_add (item, other.item, Result.item)
		end

	product alias "*" alias "×" (other: like Current): like Current
			-- Multiply by `other'
		require else
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_multiply (item, other.item, Result.item)
		end

	quotient alias "/" alias "÷" (other: like Current): like Current
			-- Multiply by `other'
		require else
			valid_item: item /= default_pointer
		do
			create Result.make
			ccom_decimal_divide (item, other.item, Result.item)
		end

	identity alias "+": like Current
			-- Unary plus
		require else
			valid_item: item /= default_pointer
		do
		end

	power alias "^" (other: like Current): like Current
			-- Current objects to the power 'other'
		require else
			valid_item: item /= default_pointer
		do
		end

feature {NONE} -- Externals

	ccom_decimal_to_double (a_ptr: POINTER): DOUBLE
		external
			"C (DECIMAL *):EIF_DOUBLE|%"E_Decimal.h%""
		end

	ccom_decimal_from_double (dbl_value: DOUBLE; a_ptr: POINTER)
		external
			"C [macro <oleauto.h>](EIF_DOUBLE, DECIMAL *)"
		alias
			"VarDecFromR8"
		end

	ccom_decimal_scale (a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_Decimal.h%"] (DECIMAL *): EIF_INTEGER"
		end

	ccom_decimal_value_zero (a_ptr: POINTER)
		external
			"C (DECIMAL *)|%"E_Decimal.h%""
		end

	ccom_decimal_value_one (a_ptr: POINTER)
		external
			"C (DECIMAL *)|%"E_Decimal.h%""
		end

	ccom_decimal_divide (a_ptr, b_ptr, c_ptr: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_round (a_ptr: POINTER; a_value: INTEGER; b_ptr:POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, EIF_INTEGER, DECIMAL *)"
		end

	ccom_decimal_negative (a_ptr, b_ptr: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_integer (a_ptr, b_ptr: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_fix (a_ptr, b_ptr: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_absolute (a_ptr, b_ptr: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *)"
		end

	c_size_of_decimal: INTEGER
		external
			"C [macro <wtypes.h>]"
		alias
			"sizeof(DECIMAL)"
		end

	ccom_decimal_add (ptr_1, ptr_2, ptr_3: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_multiply (ptr_1, ptr_2, ptr_3: POINTER)
		external
			"C [macro %"E_Decimal.h%"](DECIMAL *, DECIMAL *, DECIMAL *)"
		end

	ccom_decimal_subtract (ptr_1, ptr_2, ptr_3: POINTER)
		external
			"C [macro %"E_Decimal.h%"] (DECIMAL *, DECIMAL *, DECIMAL *)"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
