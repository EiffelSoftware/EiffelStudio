indexing

	description:
		"References to objects containing a character value"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CHARACTER_REF

inherit
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

	code: INTEGER is
			-- Associated integer value
		do
			Result := chcode (item)
		end

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := code
		end

	Min_value: INTEGER is 0
	Max_value: INTEGER is 65535
			-- Bounds for integer representation of character (Unicode).

feature -- Status report

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= '%U'
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current character?
		do
			Result := item < other.item
		ensure then
			definition: Result = (code < other.code)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

	three_way_comparison (other: CHARACTER_REF): INTEGER is
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

	infix "+" (incr: INTEGER): CHARACTER is
			-- Add `incr' to the code of `item'
		require
			valid_increment: (item.code + incr).is_valid_character_code
		do
			Result := (chcode (item) + incr).to_character
		ensure
			valid_result: Result |-| item = incr
		end

	infix "-" (decr: INTEGER): CHARACTER is
			-- Subtract `decr' to the code of `item'
		require
			valid_decrement: (item.code - decr).is_valid_character_code
		do
			Result := (chcode (item) - decr).to_character
		ensure
			valid_result: item |-| Result = decr
		end

	infix "|-|" (other: CHARACTER): INTEGER is
			-- Difference between the codes of `item' and `other'
		do
			Result := chcode (item) - chcode (other)
		ensure
			valid_result: other + Result = item
		end

	next: CHARACTER is
			-- Next character
		require
			valid_character: (item.code + 1).is_valid_character_code
		do
			Result := item + 1
		ensure
			valid_result: Result |-| item = 1
		end

	previous: CHARACTER is
			-- Previous character
		require
			valid_character: (item.code - 1).is_valid_character_code
		do
			Result := item - 1
		ensure
			valid_result: Result |-| item = -1
		end

feature -- Element change

	frozen set_item (c: CHARACTER) is
			-- Make `c' the `item' value.
		do
			item := c
		end

feature -- Output

	out: STRING is
			-- Printable representation of character
		do
			create Result.make (2)
			Result.append_character (item)
		end

feature {NONE} -- Initialization

	make_from_reference (v: CHARACTER_REF) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: CHARACTER_REF is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	as_upper, upper: CHARACTER is
			-- Uppercase value of `item'
			-- Returns `item' if not `is_lower'
		do
			Result := {DOTNET_CHARACTER}.to_upper (item)
		end

	as_lower, lower: CHARACTER is
			-- Lowercase value of `item'
			-- Returns `item' if not `is_upper'
		do
			Result := {DOTNET_CHARACTER}.to_lower (item)
		end

feature -- Status report

	is_lower: BOOLEAN is
			-- Is `item' lowercase?
		do
			Result := {DOTNET_CHARACTER}.is_lower (item)
		end

	is_upper: BOOLEAN is
			-- Is `item' uppercase?
		do
			Result := {DOTNET_CHARACTER}.is_upper (item)
		end

	is_digit: BOOLEAN is
			-- Is `item' a digit?
			-- A digit is one of 0123456789
		do
			Result := {DOTNET_CHARACTER}.is_digit (item)
		end

	is_alpha: BOOLEAN is
			-- Is `item' alphabetic?
			-- Alphabetic is `is_upper' or `is_lower'
		do
			Result := {DOTNET_CHARACTER}.is_letter (item)
		end

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER is
			-- Associated integer value
		do
			Result := {SYSTEM_CONVERT}.to_int_32_character (c)
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

end -- class CHARACTER_REF



