note
	description: "References to objects containing an integer value coded on 8 bits"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_8_REF
	
inherit
	NUMERIC
		rename
			quotient as integer_quotient alias "//"			
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

	item: INTEGER_8
			-- Integer value

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item.to_integer.hash_code
		end

	sign: INTEGER_8
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

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result
			Result.set_item (1)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result
			Result.set_item (0)
		end

	ascii_char: CHARACTER
			-- Returns corresponding ASCII character to `item' value.
		obsolete
			"Use to_character instead"
		require
			valid_character_code: is_valid_character_code
		do
			Result := item.to_character
		end

	Min_value: INTEGER_8 = -128
	Max_value: INTEGER_8 = 127
			-- Minimum and Maximum value hold in `item'.

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current integer less than `other'?
		do
			Result := item < other.item
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

feature -- Element change

	set_item (i: INTEGER_8)
			-- Make `i' the `item' value.
		do
			item := i
		ensure
			item_set: item = i
		end

feature -- Status report

	divisible (other: INTEGER_8_REF): BOOLEAN
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0
		ensure then
			value: Result = (other.item /= 0)
		end

	exponentiable (other: NUMERIC): BOOLEAN
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

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0
		end

	is_valid_character_code: BOOLEAN
			-- Does current object represent a character?
		do
			Result := item >= {CHARACTER}.Min_value and item <= {CHARACTER}.Max_value
		end

feature -- Basic operations

	abs: INTEGER_8
			-- Absolute value
		do
			Result := abs_ref.item
		ensure
			non_negative: Result >= 0
			same_absolute_value: (Result = item) or (Result = -item)
		end

	plus alias "+" (other: like Current): like Current
			-- Sum with `other'
		do
			create Result
			Result.set_item (item + other.item)
		end

	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other'
		do
			create Result
			Result.set_item (item - other.item)
		end

	product alias "*" (other: like Current): like Current
			-- Product by `other'
		do
			create Result
			Result.set_item (item * other.item)
		end

	quotient alias "/" (other: like Current): DOUBLE
			-- Division by `other'
		require
			other_exists: other /= Void
			good_divisor: divisible (other)
		do
			Result := item / other.item
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result
			Result.set_item (+ item)
		end

	opposite alias "-": like Current
			-- Unary minus
		do
			create Result
			Result.set_item (- item)
		end

	integer_quotient alias "//" (other: like Current): like Current
			-- Integer division of Current by `other'
		do
			create Result
			Result.set_item (item // other.item)
		end

	integer_remainder alias "\\" (other: like Current): like Current
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

	power alias "^" (other: DOUBLE): DOUBLE
			-- Integer power of Current by `other'
		do
			Result := item ^ other
		end

	interval alias "|..|" (other: INTEGER): INTEGER_INTERVAL
			-- Interval from current element to `other'
			-- (empty if `other' less than current integer)
		do
			create Result.make (item, other)
		end

feature {NONE} -- Conversion

	make_from_reference (v: INTEGER_8_REF)
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: INTEGER_8_REF
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	frozen to_boolean: BOOLEAN
			-- True if not `zero'.
		do
			Result := item /= 0
		end

	frozen to_natural_8: NATURAL_8
			-- Convert `item' into an NATURAL_8 value.
		require
			item_non_negative: item >= 0
		do
			Result := item.to_natural_8
		end

	frozen to_natural_16: NATURAL_16
			-- Convert `item' into an NATURAL_16 value.
		require
			item_non_negative: item >= 0
		do
			Result := item.to_natural_16
		end

	frozen to_natural_32: NATURAL_32
			-- Convert `item' into an NATURAL_32 value.
		require
			item_non_negative: item >= 0
		do
			Result := item.to_natural_32
		end
	
	frozen to_natural_64: NATURAL_64
			-- Convert `item' into an NATURAL_64 value.
		require
			item_non_negative: item >= 0
		do
			Result := item.to_natural_64
		end

	frozen to_integer_8: INTEGER_8
			-- Return `item'.
		do
			Result := item
		end
		
	frozen to_integer_16: INTEGER_16
			-- Convert `item' into an INTEGER_16 value.
		do
			Result := item.to_integer_16
		end

	frozen to_integer, frozen to_integer_32: INTEGER
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := item.to_integer
		end

	frozen to_integer_64: INTEGER_64
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := item.to_integer_64
		end

	frozen to_real: REAL
			-- Convert `item' into a REAL
		do
			Result := item.to_real
		end

	frozen to_double: DOUBLE
			-- Convert `item' into a DOUBLE
		do
			Result := item.to_double
		end

	to_hex_string: STRING
			-- Convert `item' into an hexadecimal string.
		local
			i, val: INTEGER
			a_digit: INTEGER
		do
			from
				i := 2
				create Result.make (i)
				Result.fill_blank
				val := item
			until
				i = 0
			loop
				a_digit := (val & 15)
				Result.put (a_digit.to_hex_character, i)
				val := val |>> 4
				i := i - 1
			end
		ensure
			result_not_void: Result /= Void
			result_valid_count: Result.count = 2
		end

	to_hex_character: CHARACTER
			-- Convert `item' into an hexadecimal character.
		require
			in_bounds: 0 <= item and item <= 15
		local
			tmp: INTEGER
		do
			tmp := item
			Result := tmp.to_hex_character
		ensure
			valid_character: ("0123456789ABCDEF").has (Result)
		end

	frozen to_character: CHARACTER
			-- Returns corresponding ASCII character to `item' value.
		require
			valid_character: is_valid_character_code
		do
			Result := item.to_character 
		end

feature -- Bit operations

	frozen bit_and alias "&" (i: like Current): like Current
			-- Bitwise and between Current' and `i'.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.set_item (item & i.item)
		ensure
			bitwise_and_not_void: Result /= Void
		end

	frozen bit_or alias "|" (i: like Current): like Current
			-- Bitwise or between Current' and `i'.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.set_item (item | i.item)
		ensure
			bitwise_or_not_void: Result /= Void
		end

	frozen bit_xor (i: like Current): like Current
			-- Bitwise xor between Current' and `i'.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.set_item (item.bit_xor (i.item))
		ensure
			bitwise_xor_not_void: Result /= Void
		end

	frozen bit_not: like Current
			-- One's complement of Current.
		do
			create Result
			Result.set_item (item.bit_not)
		ensure
			bit_not_not_void: Result /= Void
		end

	frozen bit_shift (n: INTEGER): INTEGER_8
			-- Shift Current from `n' position to right if `n' positive,
			-- to left otherwise.
		require
			n_less_or_equal_to_8: n <= 8
			n_greater_or_equal_to_minus_8: n >= -8
		do
			if n > 0 then
				Result := bit_shift_right (n)
			else
				Result := bit_shift_left (- n)
			end	
		end

	frozen bit_shift_left alias "|<<" (n: INTEGER): like Current
			-- Shift Current from `n' position to left.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_8: n <= 8
		do
			create Result
			Result.set_item (item |<< n)
		ensure
			bit_shift_left_not_void: Result /= Void
		end

	frozen bit_shift_right alias "|>>" (n: INTEGER): like Current
			-- Shift Current from `n' position to right.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_8: n <= 8
		do
			create Result
			Result.set_item (item |>> n)
		ensure
			bit_shift_right_not_void: Result /= Void
		end

	frozen bit_test (n: INTEGER): BOOLEAN
			-- Test `n'-th position of Current.
		require
			n_nonnegative: n >= 0
			n_less_than_8: n < 8
		do
			Result := item & ((1).to_integer_8 |<< n) /= 0
		end

	frozen set_bit (b: BOOLEAN; n: INTEGER): INTEGER_8
			-- Copy of current with `n'-th position
			-- set to 1 if `b', 0 otherwise.
		require
			n_nonnegative: n >= 0
			n_less_than_8: n < 8
		do
			if b then
				Result := item | ((1).to_integer_8 |<< n)
			else
				Result := item & ((1).to_integer_8 |<< n).bit_not
			end
		end

	frozen set_bit_with_mask (b: BOOLEAN; m: INTEGER_8): INTEGER_8
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

	out: STRING
			-- Printable representation of integer value
		do
			Result := item.out
		end

feature {NONE} -- Implementation

	abs_ref: INTEGER_8_REF
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

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class INTEGER_8_REF



