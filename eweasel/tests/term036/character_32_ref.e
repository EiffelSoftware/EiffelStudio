note
	description: "References to objects containing a unicode character value"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_32_REF

inherit
	COMPARABLE
		redefine
			three_way_comparison, is_equal, out
		end

	HASHABLE
		redefine
			is_hashable, is_equal, out
		end

feature -- Access

	item: WIDE_CHARACTER
			-- Unicde character value

	hash_code, code: INTEGER
			-- Associated integer value and hash code value
		do
			Result := chcode (item)
		end

feature -- Status report

	is_hashable: BOOLEAN = True
			-- May current object be hashed?

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is `other' greater than current character?
		do
			Result := item < other.item
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

feature -- Element change

	set_item (c: WIDE_CHARACTER)
			-- Make `c' the `item' value.
		do
			item := c
		end

feature -- Output

	out: STRING
			-- Printable representation of wide character
		do
			create Result.make (6)
			Result.extend ('U')
			Result.extend ('+')
			Result.append (chcode (item).to_hex_string)
		end

feature {NONE} -- Initialization

	make_from_reference (v: WIDE_CHARACTER_REF)
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: WIDE_CHARACTER_REF
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER
			-- Associated integer value
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
