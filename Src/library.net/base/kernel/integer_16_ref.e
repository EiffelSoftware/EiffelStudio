indexing

	description: "References to objects containing an integer value coded on 16 bits"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_16_REF inherit

	NUMERIC
		rename
			infix "/" as infix "//"
		redefine
			out, is_equal
		end

	COMPARABLE
		redefine
			out, three_way_comparison, is_equal
		end

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: INTEGER_16
			-- Integer value

	hash_code: INTEGER is
			-- Hash code value
		do
			if item >= 0 then
				Result := item
			else
					-- The following instruction in case
					-- we hit the minumum negative number,
					-- which could yield a negative result
					-- when negated.
				Result := - (item + 1)
			end
		end

	sign: INTEGER is
			-- Sign value (0, -1 or 1)
		do
			if item > 0 then
				Result := 1
			elseif item < 0 then
				Result := -1
			end
		ensure
			three_way: Result = three_way_comparison (zero)
		end

	one: like Current is
			-- Neutral element for "*" and "/"
		do
			create Result
--			Result.set_item (1)
		end

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			create Result
--			Result.set_item (0)
		end

	ascii_char: CHARACTER is
			-- Returns corresponding ASCII character to `item' value.
		obsolete
			"Use to_character instead"
		do
			Result := to_character 
		end

	to_character: CHARACTER is
			-- Returns ASCII character corresponding to `item' value.
		require
			valid_character: is_valid_character_code
		local
			cv: CONVERT
		do
			Result := cv.to_char_int16 (item)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current integer less than `other'?
		do
			Result := item < other.item
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

	three_way_comparison (other: INTEGER_16_REF): INTEGER is
			-- If current object equal to `other', 0
			-- if smaller, -1; if greater, 1
		do
			if item < other.item then
				Result := -1
			elseif other.item < item then
				Result := 1
			end
		end

feature -- Element change

	frozen set_item (i: INTEGER_16) is
			-- Make `i' the `item' value.
		do
			item := i
		end

feature -- Status report

	divisible (other: INTEGER_16_REF): BOOLEAN is
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0
		ensure then
			value: Result = (other.item /= 0)
		end

	exponentiable (other: NUMERIC): BOOLEAN is
			-- May current object be elevated to the power `other'?
		local
			integer_value: INTEGER_REF
			double_value: DOUBLE_REF
			real_value: REAL_REF
		do
			integer_value ?= other
			real_value ?= other
			double_value ?= other
			if integer_value /= Void then
				Result := integer_value.item >= 0 or item /= 0
			elseif real_value /= Void then
				Result := real_value.item >= 0.0 or item /= 0
			elseif double_value /= Void then
				Result := double_value.item >= 0.0 or item /= 0
			end
		ensure then
			safe_values: ((other.conforms_to (0) and item /= 0) or
				(other.conforms_to (0.0) and item > 0)) implies Result
		end

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0
		end

	is_valid_character_code: BOOLEAN is
			-- Does current object represent a character?
		local
			ch: CHARACTER
		do
			Result := item >= ch.Min_value and item <= ch.Max_value
		end

feature -- Basic operations

	abs: INTEGER_16 is
			-- Absolute value
		do
			Result := abs_ref.item
		ensure
			non_negative: Result >= 0
			same_absolute_value: (Result = item) or (Result = -item)
		end

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			create Result
			Result.set_item (item + other.item)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			create Result
			Result.set_item (item - other.item)
		end

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			create Result
			Result.set_item (item * other.item)
		end

	infix "/" (other: like Current): DOUBLE is
			-- Division by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		do
			Result := item / other.item
		end

	prefix "+": like Current is
			-- Unary plus
		do
			create Result
			Result.set_item (+ item)
		end

	prefix "-": like Current is
			-- Unary minus
		do
			create Result
			Result.set_item (- item)
		end


	infix "//" (other: like Current): like Current is
			-- Integer division of Current by `other'
		do
			create Result
			Result.set_item (item // other.item)
		end

	infix "\\" (other: like Current): like Current is
			-- Remainder of the integer division of Current by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		do
			create Result
			Result.set_item (item \\ other.item)
		ensure
			result_exists: Result /= Void
		end

	infix "^" (other: NUMERIC): DOUBLE is
			-- Integer power of Current by `other'
		local
			integer_value: INTEGER_REF
			real_value: REAL_REF
			double_value: DOUBLE_REF
		do
			integer_value ?= other
			real_value ?= other
			double_value ?= other
			if integer_value /= Void then
				Result := item ^ integer_value.item
			elseif real_value /= Void then
				Result := item ^ real_value.item
			elseif double_value /= Void then
				Result := item ^ double_value.item
			end
		end

	infix "|..|" (other: INTEGER_16): INTEGER_INTERVAL is
			-- Interval from current element to `other'
			-- (empty if `other' less than current integer)
		do
			create Result.make (item, other)
		end

feature -- Conversion

	to_integer_8: INTEGER_8 is
			-- Convert `item' into an INTEGER_8 value.
		require
			not_too_small: item >= -128
			not_too_big: item <= 127
		do
			Result := item.to_integer_8
		end

	to_integer: INTEGER is
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := item.to_integer
		end

	to_integer_64: INTEGER_64 is
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := item.to_integer_64
		end

feature -- Bit operations

	infix "&", bit_and (i: like Current): like Current is
			-- Bitwise and between Current' and `i'.
		do
			-- Built-in.
		end

	infix "|", bit_or (i: like Current): like Current is
			-- Bitwise or between Current' and `i'.
		do
			-- Built-in.
		end

	bit_xor (i: like Current): like Current is
			-- Bitwise xor between Current' and `i'.
		do
			-- Built-in.
		end

	bit_not: like Current is
			-- One's complement of Current.
		do
			-- Built-in.
		end

	bit_shift (n: INTEGER): like Current is
			-- Shift Current from `n' position to right if `n' positive,
			-- to left otherwise.
		require
			n_less_or_equal_to_16: n <= 16
			n_greater_or_equal_to_minus_16: n >= -16
		do
			if n > 0 then
				Result := bit_shift_right (n)
			else
				Result := bit_shift_left (- n)
			end	
		end

	infix "|<<", bit_shift_left (n: INTEGER): like Current is
			-- Shift Current from `n' position to left.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_16: n <= 16
		do
			-- Built-in.
		end

	infix "|>>", bit_shift_right (n: INTEGER): like Current is
			-- Shift Current from `n' position to right.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_16: n <= 16
		do
			-- Built-in.
		end

	bit_test (n: INTEGER): BOOLEAN is
			-- Test `n'-th position of Current.
		require
			n_nonnegative: n >= 0
			n_less_than_16: n < 16
		do
			Result := item & (one.item |<< n) /= 0
		end

feature -- Output

	out: STRING is
			-- Printable representation of integer value
		local
			cv: CONVERT
		do
			create Result.make_from_cil (cv.to_string_int16 (item))
		end


feature {NONE} -- Implementation

	abs_ref: INTEGER_16_REF is
			-- Absolute value
		do
			if item >= 0 then
				Result := Current
			else
				Result := -Current
			end
		ensure
			result_exists: Result /= Void
			same_absolute_value: equal (Result, Current) or equal (Result, - Current)
		end

invariant

	sign_times_abs: sign * abs = item

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class INTEGER_16_REF



