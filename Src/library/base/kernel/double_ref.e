indexing

	description:
		"References to objects containing a double-precision real number";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DOUBLE_REF inherit

	NUMERIC
		redefine
			out
		end;

	COMPARABLE
		redefine
			out
		end

feature -- Access

	item: DOUBLE;
			-- Numeric double value


feature -- Comparison

	infix "<" (other: DOUBLE_REF): BOOLEAN is
			-- Is current double less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item
		end;

feature -- Element change

	set_item (d: DOUBLE) is
			-- Make `d' the `item' value.
		do
			item := d
		end;

feature -- Basic operations 

	infix "+" (other: DOUBLE_REF): DOUBLE_REF is
			-- Sum with `other'
		do
			!! Result;
			Result.set_item (item + other.item)
		end;

	infix "-" (other: DOUBLE_REF): DOUBLE_REF is
			-- Result of subtracting `other'
		do
			!! Result;
			Result.set_item (item - other.item)
		end;

	infix "*" (other: DOUBLE_REF): DOUBLE_REF is
			-- Product with `other'
		do
			!! Result;
			Result.set_item (item * other.item)
		end;

	infix "/" (other: DOUBLE_REF): DOUBLE_REF is
			-- Division by `other'
		require else
			good_divisor: other.item /= 0.0
		do
			!! Result;
			Result.set_item (item / other.item)
		end;

	infix "^" (other: DOUBLE_REF): DOUBLE_REF is
			-- Current double to the power `other'
		do
			!! Result;
			Result.set_item (item ^ other.item)
		end;

	prefix "+": DOUBLE_REF is
			-- Unary plus
		do
			!! Result;
			Result.set_item (+ item)
		end;

	prefix "-": DOUBLE_REF is
			-- Unary minus
		do
			!! Result;
			Result.set_item (- item)
		end;

feature -- Output

	out: STRING is
			-- Printable representation.
		do
			Result := c_outd ($item)
		end;

feature {NONE} -- Implementation

	c_outd (d: DOUBLE): STRING is
			-- Printable representation
		external
			"C"
		end;

end -- class DOUBLE_REF


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
