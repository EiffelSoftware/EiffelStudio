note

	description:
		"References to objects containing a character value"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CHARACTER_8_REF inherit

	COMPARABLE
		redefine
			out, three_way_comparison, is_equal
		end

	HASHABLE
		redefine
			is_hashable, out, is_equal
		end

feature -- Access

	item: CHARACTER
			-- Character value

	code: INTEGER
			-- Associated integer value
		do
			Result := chcode (item)
		end

	hash_code: INTEGER
			-- Hash code value
		do
			Result := code
		end

	Min_value: INTEGER = 0
	Max_value: INTEGER = 255
			-- Bounds for integer representation of characters (ASCII)

feature -- Status report

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= '%U'
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is `other' greater than current character?
		do
			Result := item < other.item
		ensure then
			definition: Result = (code < other.code)
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

	three_way_comparison (other: like Current): INTEGER
			-- If current object equal to `other', 0;
			-- if smaller, -1; if greater, 1
		do
			if item < other.item then
				Result := -1
			elseif other.item < item then
				Result := 1
			end
		end

feature -- Basic routines

	plus alias "+" (incr: INTEGER): CHARACTER
			-- Add `incr' to the code of `item'
		require
			valid_increment: (item.code + incr).is_valid_character_code
		do
			Result := chconv (chcode (item) + incr)
		ensure
			valid_result: Result |-| item = incr
		end

	minus alias "-" (decr: INTEGER): CHARACTER
			-- Subtract `decr' to the code of `item'
		require
			valid_decrement: (item.code - decr).is_valid_character_code
		do
			Result := chconv (chcode (item) - decr)
		ensure
			valid_result: item |-| Result = decr
		end

	difference alias "|-|" (other: CHARACTER): INTEGER
			-- Difference between the codes of `item' and `other'
		do
			Result := chcode (item) - chcode (other)
		ensure
			valid_result: other + Result = item
		end

	next: CHARACTER
			-- Next character
		require
			valid_character: (item.code + 1).is_valid_character_code
		do
			Result := item + 1
		ensure
			valid_result: Result |-| item = 1
		end

	previous: CHARACTER
			-- Previous character
		require
			valid_character: (item.code - 1).is_valid_character_code
		do
			Result := item - 1
		ensure
			valid_result: Result |-| item = -1
		end

feature -- Element change

	set_item (c: CHARACTER)
			-- Make `c' the `item' value.
		do
			item := c
		end

feature -- Output

	out: STRING
			-- Printable representation of character
		do
			Result := c_outc (item)
		end

feature {NONE} -- Initialization

	make_from_reference (v: CHARACTER_REF)
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: CHARACTER_REF
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	as_upper, upper: CHARACTER
			-- Uppercase value of `item'
			-- Returns `item' if not `is_lower'
		do
			Result := chupper (item)
		end

	as_lower, lower: CHARACTER
			-- Lowercase value of `item'
			-- Returns `item' if not `is_upper'
		do
			Result := chlower (item)
		end

feature -- Status report

	is_lower: BOOLEAN
			-- Is `item' lowercase?
		do
			Result := chis_lower (item)
		end

	is_upper: BOOLEAN
			-- Is `item' uppercase?
		do
			Result := chis_upper (item)
		end

	is_digit: BOOLEAN
			-- Is `item' a digit?
			-- A digit is one of 0123456789
		do
			Result := chis_digit (item)
		end

	is_alpha: BOOLEAN
			-- Is `item' alphabetic?
			-- Alphabetic is `is_upper' or `is_lower'
		do
			Result := chis_alpha (item)
		end

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER
			-- Associated integer value
		external
			"C [macro %"eif_misc.h%"]"
		end

	chconv (i: INTEGER): CHARACTER
			-- Character associated with integer value `i'
		external
			"C [macro %"eif_misc.h%"]"
		end

	c_outc (c: CHARACTER): STRING
			-- Printable representation of character
		external
			"C | %"eif_out.h%""
		end

	chupper (c: CHARACTER): CHARACTER
		external
			"C [macro %"eif_misc.h%"]"
		end

	chlower (c: CHARACTER): CHARACTER
		external
			"C [macro %"eif_misc.h%"]"
		end

	chis_lower (c: CHARACTER): BOOLEAN
		external
			"C [macro %"eif_misc.h%"]"
		end

	chis_upper (c: CHARACTER): BOOLEAN
		external
			"C [macro %"eif_misc.h%"]"
		end

	chis_digit (c: CHARACTER): BOOLEAN
		external
			"C [macro %"eif_misc.h%"]"
		end

	chis_alpha (c: CHARACTER): BOOLEAN
		external
			"C [macro %"eif_misc.h%"]"
		end

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

end
