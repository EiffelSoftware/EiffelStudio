indexing

	description:
		"References to objects containing an integer value";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_REF inherit

	NUMERIC
		redefine
			out
		end;

	COMPARABLE
		redefine
			out
		end;

	HASHABLE
		undefine
			out
		end

feature -- Access

	item: INTEGER;
			-- Numeric double value

	hash_code: INTEGER is
			-- Hash code value
		do
			if item > 0 then
				Result := item
			else
				Result := -item + 1
			end
		end;

feature -- Comparison

	infix "<" (other: INTEGER_REF): BOOLEAN is
			-- Is current integer less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item
		end;

feature -- Element change


	set_item (i: INTEGER) is
			-- Assign `i' to `item'.
		do
			item := i
		end;

feature -- Basic operations

	infix "+" (other: INTEGER_REF): INTEGER_REF is
			-- Sum with `other'
		do
			!! Result;
			Result.set_item (item + other.item)
		end;

	infix "-" (other: INTEGER_REF): INTEGER_REF is
			-- Result of subtracting `other'
		do
			!! Result;
			Result.set_item (item - other.item)
		end;

	infix "*" (other: INTEGER_REF): INTEGER_REF is
			-- Product by `other'
		do
			!! Result;
			Result.set_item (item * other.item)
		end;

	infix "/" (other: INTEGER_REF): REAL_REF is
			-- Division by `other'
		require else
			good_divisor: other.item /= 0.0
		do
			!! Result;
			Result.set_item (item / other.item)
		end;

	prefix "+": INTEGER_REF is
			-- Unary plus
		do
			!! Result;
			Result.set_item (+ item)
		end;

	prefix "-": INTEGER_REF is
			-- Unary minus
		do
			!! Result;
			Result.set_item (- item)
		end;


	infix "//" (other: INTEGER_REF): INTEGER_REF is
			-- Integer division of Current by `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item // other.item)
		end;

	infix "\\" (other: INTEGER_REF): INTEGER_REF is
			-- Remainder of the integer division of Current by `other'
		require
			other_exists: other /= Void
		do
			!! Result;
			Result.set_item (item \\ other.item)
		end;

	infix "^" (other: INTEGER_REF): INTEGER_REF is
			-- Current integer to the power `other'
		do
			!! Result;
			Result.set_item (item ^ other.item)
		end;

feature -- Output

	out: STRING is
			-- Printable representation of current object.
		do
			Result := c_outi ($item)
		end;


feature {NONE} -- Implementation

	c_outi (i: INTEGER): STRING is
			-- Printable representation of current object.
		external
			"C"
		end;

end -- class INTEGER_REF


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
