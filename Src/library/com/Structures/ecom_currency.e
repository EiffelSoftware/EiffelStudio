indexing
	description: "COM Currency Structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_CURRENCY

inherit	
	ECOM_STRUCTURE

	NUMERIC

creation
	make,
	make_by_pointer

feature  -- Access

	high_bits: INTEGER is
			-- High 32 bits of currency.
		do
			Result := ccom_currency_high_bits(item)
		end 

	low_bits: INTEGER is
			-- Low 32 bits of currency.
		do
			Result := ccom_currency_low_bits(item)
		end

	one: ECOM_CURRENCY is
			-- Neutral element for `*' operation
		do
			create Result.make;
			ccom_currency_value_one (Result.item)
		end

	zero: ECOM_CURRENCY is
			-- Neutral element for `+' operation
		do
			create Result.make;
			ccom_currency_value_zero (Result.item)
		end

feature -- status report
	
	divisible (other: ECOM_CURRENCY): BOOLEAN is
			-- Is divisible by `other'?
		do
			Result := false
		end

	exponentiable (other: ECOM_CURRENCY): BOOLEAN is
			-- Is exponentiable by `other'?
		do
			Result := false
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of CY (CURRENCY) structure.
		do
			Result := c_size_of_currency 
		end

feature -- Conversion

	rounded (value: INTEGER): ECOM_CURRENCY is
			-- Round value with `value' decimal places
		require
			valid_value: value >= 0
		do
			create Result.make
			ccom_currency_round (item, value, Result.item)
		ensure
			valid_result: Result /= Void
		end

	ceiled_integer_portion: ECOM_CURRENCY is
			-- Integer portion of currency value. The first negative 
			-- integer >= to the value is returned if the value is negative.
		do
			create Result.make
			ccom_currency_fix (item, Result.item)
		ensure
			valid_result: Result /= Void
		end

	truncated_to_integer_portion: ECOM_CURRENCY is
			-- Integer portion of a currency value. The first negative integer 
			-- <= to the value is returned if the value is negative.
		do
			create Result.make
			ccom_currency_integer (item, Result.item)
		ensure
			valid_result: Result /= Void
		end

	absolute: ECOM_CURRENCY is
			-- Absolute value of currency
		do
			create Result.make
			ccom_currency_absolute (item, Result.item)
		ensure
			valid_result: Result /= Void
		end

feature -- Element Change

	set_high_bits (an_integer: INTEGER) is
			-- Set `high_bits' with `an_integer'.
		do
			ccom_currency_set_high_bits(item, an_integer)
		ensure
			high_bits_set: high_bits = an_integer
		end

	set_low_bits (an_integer: INTEGER) is 
			-- Set 'low_bits' with 'an_integer'.
		do
			ccom_currency_set_low_bits(item, an_integer)
		ensure
			low_bits_set: low_bits = an_integer
		end

feature -- Basic operations
	
	prefix "-": ECOM_CURRENCY is
			-- Negative value of currency
		do
			create Result.make
			ccom_currency_negative (item, Result.item)
		end 
	
	infix "-" (other: ECOM_CURRENCY): ECOM_CURRENCY is
			-- Subtract with `other'
		do
			create Result.make
			ccom_currency_subtract (item, other.item, Result.item)
		end

	infix "+" (other: ECOM_CURRENCY): ECOM_CURRENCY is
			-- Add with `other'
		do
			create Result.make
			ccom_currency_add (item, other.item, Result.item)
		end 

	infix "*" (other: ECOM_CURRENCY): ECOM_CURRENCY is
			-- Multiply by `other'
		do
			create Result.make
			ccom_currency_multiply (item, other.item, Result.item)
		end

	multiply_integer (an_integer: INTEGER): ECOM_CURRENCY is
			-- Multiply by `an_integer'
		do
			create Result.make
				ccom_currency_multiply_by_4bytes_integer (item, an_integer, Result.item)
		ensure
			valid_result: Result /= Void
		end
	
	infix "/" (other: ECOM_CURRENCY): ECOM_CURRENCY is
		-- Division by 'other'
		do
		end

	prefix "+": ECOM_CURRENCY is
		-- Unary plus
		do
		end

	infix "^" (other: NUMERIC):NUMERIC is
		-- Current objects to the power 'other'
		do
		end

feature {NONE} -- Externals

	ccom_currency_value_zero (a_ptr: POINTER) is
--		external
--			"C (EIF_POINTER)|%"E_Currency.h%""
		do
		end

	ccom_currency_value_one (a_ptr: POINTER) is
	--	external
	--		"C (EIF_POINTER)|%"E_Currency.h%""
		do
		end

	ccom_currency_round (a_ptr: POINTER; a_value: INTEGER; b_ptr:POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_INTEGER, EIF_POINTER)"
		do
		end
		
	ccom_currency_negative (a_ptr, b_ptr: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_POINTER)"
		do
		end

	ccom_currency_integer (a_ptr, b_ptr: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_POINTER)"
		do
		end

	ccom_currency_fix (a_ptr, b_ptr: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_POINTER)"
		do
		end

	ccom_currency_absolute (a_ptr, b_ptr: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_POINTER)"
		do
		end

	ccom_currency_set_high_bits (a_ptr:POINTER; i: INTEGER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_INTEGER)"
		do
		end

	ccom_currency_set_low_bits (a_ptr:POINTER; i: INTEGER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_INTEGER)"
		do
		end

	ccom_currency_high_bits (a_ptr:POINTER): INTEGER is
	--	external
	--		"C [macro %"E_Currency.h%"]"
		do
		end

	ccom_currency_low_bits (a_ptr:POINTER): INTEGER is
	--	external
	--		"C [macro %"E_Currency.h%"]"
		do
		end

	c_size_of_currency: INTEGER is
	--	external 
	--		"C [macro <wtypes.h>]"
	--	alias
	--		"sizeof(CY)"
		do
		end

	ccom_currency_add (ptr_1, ptr_2, ptr_3: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		do
		end

	ccom_currency_multiply (ptr_1, ptr_2, ptr_3: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		do
		end
	
	ccom_currency_multiply_by_4bytes_integer (ptr_1:POINTER; ptr_2: INTEGER; ptr_3: POINTER) is
	--	external
	--		"C [macro %"E_Currency.h%"](EIF_POINTER, EIF_INTEGER, EIF_POINTER)"
		do
		end

	ccom_currency_subtract (ptr_1, ptr_2, ptr_3: POINTER) is
	--	external
	--		"c [macro %"E_Currency.h%"] (EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		do
		end

end -- class ECOM_CURRENCY

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

