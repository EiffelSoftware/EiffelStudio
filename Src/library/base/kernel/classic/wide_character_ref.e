indexing
	description: "References to objects containing a unicode character value"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIDE_CHARACTER_REF

inherit
	COMPARABLE
		redefine
			is_equal, out
		end

	HASHABLE
		redefine
			is_hashable, is_equal, out
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

feature -- Element change

	set_item (c: WIDE_CHARACTER) is
			-- Make `c' the `item' value.
		do
			item := c
		end

feature -- Output

	out: STRING is
			-- Printable representation of wide character
		do
			create Result.make (6)
			Result.extend ('U')
			Result.extend ('+')
			Result.append (chcode (item).to_hex_string)
		end

feature {NONE} -- Initialization

	make_from_reference (v: WIDE_CHARACTER_REF) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: WIDE_CHARACTER_REF is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
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


