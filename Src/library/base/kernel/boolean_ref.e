indexing

	description:
		"References to objects containing a boolean value";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BOOLEAN_REF inherit

	ANY
		redefine
			out
		end

feature -- Access

	item: BOOLEAN;
			-- Boolean value



feature -- Element change

	set_item (b: BOOLEAN) is
			-- Make `b' the `item' value.
		do
			item := b;
		end;


feature -- Basic operations

	infix "and" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean conjunction with `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item and other.item)
		end;

	infix "and then" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean semi-strict conjunction with `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item and then other.item)
		end;

	infix "implies" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean implication of `other'
			-- (semi-strict)
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item implies other.item)
		end;

	prefix "not" : BOOLEAN_REF is
			-- Negation
		do
			!! Result;
			Result.set_item (not item)
		end;

	infix "or" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean disjunction with `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item or other.item)
		end;

	infix "or else" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean semi-strict disjunction with `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item or else other.item)
		end;

	infix "xor" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean exclusive or with `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item xor other.item)
		end;

feature -- Output

	out: STRING is
			-- Printable representation of boolean.
		do
			Result := c_outb ($item)
		end;

feature {NONE} -- Implementation

	c_outb (b: BOOLEAN): STRING is
			-- Printable representation of boolean.
		external
			"C"
		end;

end -- class BOOLEAN_REF


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
