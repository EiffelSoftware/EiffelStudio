indexing

	description:
		"References to objects containing a real value";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class REAL_REF inherit

	NUMERIC
		redefine
			out
		end;

	COMPARABLE
		redefine
			out
		end

feature -- Access

	item: REAL;
			-- Numeric real value

feature -- Comparison

	infix "<" (other: REAL_REF): BOOLEAN is
			-- Is current real less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item
		end; -- "<"

feature -- Element change

	set_item (r: REAL) is
			-- Make `r' the value of `item'.
		do
			item := r
		end;

feature -- Basic operations

	infix "+" (other: REAL_REF): REAL_REF is
			-- Sum with `other'
		do
			!! Result;
			Result.set_item (item + other.item)
		end; -- infix "+"

	infix "-" (other: REAL_REF): REAL_REF is
			-- Result of subtracting `other'
		do
			!! Result;
			Result.set_item (item - other.item)
		end; -- infix "-"

	infix "*" (other: REAL_REF): REAL_REF is
			-- Product by `other'
		do
			!! Result;
			Result.set_item (item * other.item)
		end; -- infix "*"

	infix "/" (other: REAL_REF): REAL_REF is
			-- Division by `other'
		require else
			good_divisor: other.item /= 0.0
		do
			!! Result;
			Result.set_item (item / other.item)
		end; -- infix "/"

	infix "^" (other: REAL_REF): REAL_REF is
			-- Current real to the power `other'
		do
			!! Result;
			Result.set_item (item ^ other.item)
		end; -- infix "^"

	prefix "+": REAL_REF is
			-- Unary plus
		do
			!! Result;
			Result.set_item (+ item)
		end; -- prefix "+"

	prefix "-": REAL_REF is
			-- Unary minus
		do
			!! Result;
			Result.set_item (- item)
		end; -- prefix "-"


feature -- Output


	out: STRING is
			-- Printable representation of real value.
		do
			Result := c_outr ($item)
		end; -- out

feature {NONE} -- Implementation

	c_outr (r: REAL): STRING is
			-- Printable representation of real value.
		external
			"C"
		end; -- c_outr

end -- class REAL_REF


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
