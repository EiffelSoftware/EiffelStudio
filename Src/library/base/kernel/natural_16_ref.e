indexing
	description: "References to objects containing an integer value coded on 16 bits"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_16_REF
	
inherit
	NUMERIC
		rename
			infix "/" as infix "//",
			prefix "-" as unapplicable_minus_prefix
		redefine
			out, is_equal
		end

	COMPARABLE
		redefine
			out, is_equal
		end

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: NATURAL_16
			-- Integer value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := item
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
			Result.set_item (1)
		end

	zero: like Current is
			-- Neutral element for "+" and "-"
		do
			create Result
			Result.set_item (0)
		end

	ascii_char: CHARACTER is
			-- Returns corresponding ASCII character to `item' value.
		obsolete
			"Use to_character instead"
		require
			valid_character_code: is_valid_character_code
		do
			Result := item.to_character
		end

	Min_value: NATURAL_16 is {NATURAL_16} 0
	Max_value: NATURAL_16 is {NATURAL_16} 65535
			-- Minimum and Maximum value hold in `item'.

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

feature -- Element change

	set_item (i: NATURAL_16) is
			-- Make `i' the `item' value.
		do
			item := i
		ensure
			item_set: item = i
		end

feature -- Status report

	divisible (other: NATURAL_16_REF): BOOLEAN is
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
		do
			Result := item >= {CHARACTER}.Min_value.to_natural_16 and 
				item <= {CHARACTER}.Max_value.to_natural_16
		end

feature -- Basic operations

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

	unapplicable_minus_prefix: like Current is
			-- Unary minus
		do
		ensure then
			not_applicable: False
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

	infix "^" (other: DOUBLE): DOUBLE is
			-- Integer power of Current by `other'
		do
			Result := item ^ other
		end

	infix "|..|" (other: INTEGER): INTEGER_INTERVAL is
			-- Interval from current element to `other'
			-- (empty if `other' less than current integer)
		do
			create Result.make (item, other)
		end

feature {NONE} -- Conversion

	make_from_reference (v: NATURAL_16_REF) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: NATURAL_16_REF is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	frozen to_boolean: BOOLEAN is
			-- True if not `zero'.
		do
			Result := item /= 0
		end

	frozen as_natural_8: NATURAL_8 is
			-- Convert `item' into an NATURAL_8 value.
		do
			Result := item.as_natural_8
		end

	frozen as_natural_16: NATURAL_16 is
			-- Convert `item' into an NATURAL_16 value.
		do
			Result := item.as_natural_16
		end

	frozen as_natural_32: NATURAL_32 is
			-- Convert `item' into an NATURAL_32 value.
		do
			Result := item.as_natural_32
		end
	
	frozen as_natural_64: NATURAL_64 is
			-- Convert `item' into an NATURAL_64 value.
		do
			Result := item.as_natural_64
		end

	frozen as_integer_8: INTEGER_8 is
			-- Convert `item' into an INTEGER_8 value.
		do
			Result := item.as_integer_8
		end
		
	frozen as_integer_16: INTEGER_16 is
			-- Convert `item' into an INTEGER_16 value.
		do
			Result := item.as_integer_16
		end

	frozen as_integer_32: INTEGER is
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := item.as_integer_32
		end

	frozen as_integer_64: INTEGER_64 is
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := item.as_integer_64
		end

	frozen to_natural_8: NATURAL_8 is
			-- Convert `item' into an INTEGER_8 value.
		require
			not_too_big: item <= {NATURAL_8}.Max_value
		do
			Result := item.to_natural_8
		end

	frozen to_natural_16: NATURAL_16 is
			-- Convert `item' into an NATURAL_16 value.
		do
			Result := item
		end

	frozen to_natural_32: NATURAL_32 is
			-- Convert `item' into an NATURAL_32 value.
		do
			Result := item.to_natural_32
		end

	frozen to_natural_64: NATURAL_64 is
			-- Convert `item' into an NATURAL_64 value.
		do
			Result := item.to_natural_64
		end

	frozen to_integer_8: INTEGER_8 is
			-- Convert `item' into an INTEGER_8 value.
		require
			not_too_big: item <= {INTEGER_8}.Max_value.to_natural_16
		do
			Result := item.to_integer_8
		end

	frozen to_integer_16: INTEGER_16 is
			-- Convert `item' into an INTEGER_16 value.
		require
			not_too_big: item <= {INTEGER_16}.Max_value.to_natural_16
		do
			Result := item.to_integer_16
		end

	frozen to_integer_32: INTEGER is
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := item.to_integer_32
		end

	frozen to_integer_64: INTEGER_64 is
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := item.to_integer_64
		end

	frozen to_real_32: REAL is
			-- Convert `item' into a REAL
		do
			Result := item.to_real_32
		end

	frozen to_real_64: DOUBLE is
			-- Convert `item' into a DOUBLE
		do
			Result := item.to_real_64
		end

	to_hex_string: STRING is
			-- Convert `item' into an hexadecimal string.
		local
			i, val: INTEGER
			a_digit: INTEGER
		do
			from
				i := (create {PLATFORM}).Integer_16_bits // 4
				create Result.make (i)
				Result.fill_blank
				val := item
			until
				i = 0
			loop
				a_digit := (val & 0xF)
				Result.put (a_digit.to_hex_character, i)
				val := val |>> 4 
				i := i - 1
			end
		ensure
			Result_not_void: Result /= Void
			Result_valid_count: Result.count = (create {PLATFORM}).Integer_16_bits // 4
		end

	to_hex_character: CHARACTER is
			-- Convert `item' into an hexadecimal character.
		require
			in_bounds: 0 <= item and item <= 15
		local
			tmp: INTEGER
		do
			tmp := item.to_integer_32
			if tmp <= 9 then
				Result := (tmp + ('0').code).to_character
			else
				Result := (('A').code + (tmp - 10)).to_character
			end
		ensure
			valid_character: ("0123456789ABCDEF").has (Result)
		end

	frozen to_character: CHARACTER is
			-- Returns corresponding ASCII character to `item' value.
		require
			valid_character: is_valid_character_code
		do
			Result := item.to_character
		end

feature -- Bit operations

	frozen infix "&", frozen bit_and (i: like Current): like Current is
			-- Bitwise and between Current' and `i'.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.set_item (item & i.item)
		ensure
			bitwise_and_not_void: Result /= Void
		end

	frozen infix "|", frozen bit_or (i: like Current): like Current is
			-- Bitwise or between Current' and `i'.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.set_item (item | i.item)
		ensure
			bitwise_or_not_void: Result /= Void
		end

	frozen bit_xor (i: like Current): like Current is
			-- Bitwise xor between Current' and `i'.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.set_item (item.bit_xor (i.item))
		ensure
			bitwise_xor_not_void: Result /= Void
		end

	frozen bit_not: like Current is
			-- One's complement of Current.
		do
			create Result
			Result.set_item (item.bit_not)
		ensure
			bit_not_not_void: Result /= Void
		end

	frozen bit_shift (n: INTEGER): NATURAL_16 is
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

	frozen infix "|<<", frozen bit_shift_left (n: INTEGER): like Current is
			-- Shift Current from `n' position to left.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_16: n <= 16
		do
			create Result
			Result.set_item (item |<< n)
		ensure
			bit_shift_left_not_void: Result /= Void
		end

	frozen infix "|>>", frozen bit_shift_right (n: INTEGER): like Current is
			-- Shift Current from `n' position to right.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_16: n <= 16
		do
			create Result
			Result.set_item (item |>> n)
		ensure
			bit_shift_right_not_void: Result /= Void
		end

	frozen bit_test (n: INTEGER): BOOLEAN is
			-- Test `n'-th position of Current.
		require
			n_nonnegative: n >= 0
			n_less_than_16: n < 16
		do
			Result := item & ((1).to_natural_16 |<< n) /= 0
		end

	frozen set_bit (b: BOOLEAN; n: INTEGER): NATURAL_16 is
			-- Copy of current with `n'-th position
			-- set to 1 if `b', 0 otherwise.
		require
			n_nonnegative: n >= 0
			n_less_than_16: n < 16
		do
			if b then
				Result := item | ((1).to_natural_16 |<< n)
			else
				Result := item & ((1).to_natural_16 |<< n).bit_not
			end
		end

	frozen set_bit_with_mask (b: BOOLEAN; m: NATURAL_16): NATURAL_16 is
			-- Copy of current with all 1 bits of m set to 1
			-- if `b', 0 otherwise.
		do
			if b then
				Result := item | m
			else
				Result := item & m.bit_not
			end
		end

feature -- Output

	out: STRING is
			-- Printable representation of integer value
		do
			Result := item.out
		end

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

end -- class NATURAL_16_REF



