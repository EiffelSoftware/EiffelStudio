note

	description:
		"References to objects containing a boolean value"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class BOOLEAN_REF inherit

	HASHABLE
		redefine
			is_hashable, out
		end

feature -- Access

	item: BOOLEAN
			-- Boolean value

	hash_code: INTEGER
			-- Hash code value
		do
			Result := 1
		end

feature -- Status report

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item
		end

feature {NONE} -- Initialization

	make_from_reference (v: BOOLEAN_REF)
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: BOOLEAN_REF
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	to_integer: INTEGER
			-- 1 if `True'
			-- 0 if `False'
		do
			if item then
				Result := 1
			end
		ensure
			zero_or_one: Result = 0 or Result = 1
			item_implies_one: item implies Result = 1
		end

feature -- Element change

	set_item (b: BOOLEAN)
			-- Make `b' the `item' value.
		do
			item := b
		end

feature -- Basic operations

	conjuncted alias "and" (other: like Current): BOOLEAN
			-- Boolean conjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item and other.item
		ensure
			de_morgan: Result = not (not Current or not other)
			commutative: Result = (other and Current)
			consistent_with_semi_strict: Result implies (Current and then other)
		end

	conjuncted_semistrict alias "and then" (other: like Current): BOOLEAN
			-- Boolean semi-strict conjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item and then other.item
		ensure
			de_morgan: Result = not (not Current or else not other)
		end

	implication alias "implies" (other: like Current): BOOLEAN
			-- Boolean implication of `other'
			-- (semi-strict)
		require
			other_exists: other /= Void
		do
			Result := item implies other.item
		ensure
			definition: Result = (not Current or else other)
		end

	negated alias "not": like Current
			-- Negation
		do
			create Result
			Result.set_item (not item)
		end

	disjuncted alias "or" (other: like Current): BOOLEAN
			-- Boolean disjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item or other.item
		ensure
			de_morgan: Result = not (not Current and not other)
			commutative: Result = (other or Current)
			consistent_with_semi_strict: Result implies (Current or else other)
		end

	disjuncted_semistrict alias "or else" (other: like Current): BOOLEAN
			-- Boolean semi-strict disjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item or else other.item
		ensure
			de_morgan: Result = not (not Current and then not other)
		end

	disjuncted_exclusive alias "xor" (other: like Current): BOOLEAN
			-- Boolean exclusive or with `other'
		require
			other_exists: other /= Void
		do
			Result := item xor other.item
		ensure
			definition: Result = ((Current or other) and not (Current and other))
		end

feature -- Output

	out: STRING
			-- Printable representation of boolean
		do
			if item then
				Result := "True"
			else
				Result := "False"
			end
		end

invariant

	involutive_negation: is_equal (not (not Current))
	non_contradiction: not (Current and (not Current))
	completeness: Current or else (not Current)

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

end -- class BOOLEAN_REF



