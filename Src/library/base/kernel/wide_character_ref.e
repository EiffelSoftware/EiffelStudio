indexing
	description: "References to objects containing a unicode character value"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class WIDE_CHARACTER_REF inherit

	COMPARABLE
		redefine
			three_way_comparison, is_equal
		end

	HASHABLE
		redefine
			is_hashable, is_equal
		end

feature -- Access

	item: WIDE_CHARACTER
			-- Unicde character value

	hash_code, code: INTEGER is
			-- Associated integer value and hash code value
		do
			Result := chcode (item)
		end

feature -- Status report

	is_hashable: BOOLEAN is True
			-- May current object be hashed?

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current character?
		do
			Result := item < other.item
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

	three_way_comparison (other: WIDE_CHARACTER_REF): INTEGER is
			-- If current object equal to `other', 0;
			-- if smaller, -1; if greater, 1
		do
			if item < other.item then
				Result := -1
			elseif other.item < item then
				Result := 1
			end
		end

feature -- Element change

	set_item (c: WIDE_CHARACTER) is
			-- Make `c' the `item' value.
		do
			item := c
		end

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER is
			-- Associated integer value
		external
			"C [macro %"eif_misc.h%"]"
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

end -- class WIDE_CHARACTER_REF


