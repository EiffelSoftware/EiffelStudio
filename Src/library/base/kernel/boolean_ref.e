indexing

	description:
		"References to objects containing a boolean value";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BOOLEAN_REF inherit

	HASHABLE
		redefine
			is_hashable, out
		end

feature -- Access

	item: BOOLEAN;
			-- Boolean value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := 1
		end;

feature -- Status report

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item
		end;

feature -- Element change

	set_item (b: BOOLEAN) is
			-- Make `b' the `item' value.
		do
			item := b;
		end;

feature -- Basic operations

	infix "and" (other: like Current): BOOLEAN is
			-- Boolean conjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item and other.item
		ensure
			de_morgan: Result = not (not Current or not other);
			commutative: Result = (other and Current);
			consistent_with_semi_strict: Result implies (Current and then other)
		end;

	infix "and then" (other: like Current): BOOLEAN is
			-- Boolean semi-strict conjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item and then other.item
		ensure
			de_morgan: Result = not (not Current or else not other)
		end;

	infix "implies" (other: like Current): BOOLEAN is
			-- Boolean implication of `other'
			-- (semi-strict)
		require
			other_exists: other /= Void
		do
			Result := item implies other.item
		ensure
			definition: Result = (not Current or else other)
		end;

	prefix "not" : like Current is
			-- Negation
		do
			!! Result;
			Result.set_item (not item)
		end;

	infix "or" (other: like Current): BOOLEAN is
			-- Boolean disjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item or other.item
		ensure
			de_morgan: Result = not (not Current and not other);
			commutative: Result = (other or Current);
			consistent_with_semi_strict: Result implies (Current or else other)
		end;

	infix "or else" (other: like Current): BOOLEAN is
			-- Boolean semi-strict disjunction with `other'
		require
			other_exists: other /= Void
		do
			Result := item or else other.item
		ensure
			de_morgan: Result = not (not Current and then not other)
		end;

	infix "xor" (other: like Current): BOOLEAN is
			-- Boolean exclusive or with `other'
		require
			other_exists: other /= Void
		do
			Result := item xor other.item
		ensure
			definition: Result = ((Current or other) and not (Current and other))
		end;

feature -- Output

	out: STRING is
			-- Printable representation of boolean
		do
			Result := c_outb (item)
		end;

feature {NONE} -- Implementation

	c_outb (b: BOOLEAN): STRING is
			-- Printable representation of boolean
		external
			"C | %"eif_out.h%""
		end;

invariant

	involutive_negation: is_equal (not (not Current));
	non_contradiction: not (Current and (not Current));
	completeness: Current or else (not Current)

end -- class BOOLEAN_REF


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

