indexing

	description:
		"References to objects containing a character value";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CHARACTER_REF inherit

	COMPARABLE
		redefine
			out
		end

feature -- Access

	item: CHARACTER;
			-- Character value

	code: INTEGER is
			-- Associated integer value
		do
			Result := chcode ($item);		
		end;

feature -- Comparison

	infix "<" (other: CHARACTER_REF): BOOLEAN is
			-- Is current character less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item;
		end;

feature -- Element change

	set_item (c: CHARACTER) is
			-- Make `c' the `item' value.
		do
			item := c
		end

feature -- Output

	out: STRING is
			-- Printable representation of character.
		do
			Result := c_outc ($item)
		end;


feature -- Conversion

	upper: CHARACTER is
			-- Uppercase value of `item'
			-- Returns `item' if not `is_lower'
		do
			Result := chupper (item)
		end;

	lower: CHARACTER is
			-- Lowercase value of `item'
			-- Returns `item' if not `is_upper'
		do
			Result := chlower (item)
		end;

feature -- Status report

	is_lower: BOOLEAN is
			-- Is `item' lowercase?
		do
			Result := chis_lower (item)
		end;

	is_upper: BOOLEAN is
			-- Is `item' uppercase?
		do
			Result := chis_upper (item)
		end;

	is_digit: BOOLEAN is
			-- Is `item' a digit?
			-- A digit is one of 0123456789
		do
			Result := chis_digit (item)
		end;

	is_alpha: BOOLEAN is
			-- Is `item' alphabetic?
			-- Alphabetic is `is_upper' or `is_lower'
		do
			Result := chis_alpha (item)
		end;

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER is
			-- Associated integer value.
		external
			"C"
		end;

	c_outc (c: CHARACTER): STRING is
			-- Printable representation of character.
		external
			"C"
		end;

	chupper (c: CHARACTER): CHARACTER is
		external
			"C"
		end;

	chlower (c: CHARACTER): CHARACTER is
		external
			"C"
		end;

	chis_lower (c: CHARACTER): BOOLEAN is
		external
			"C"
		end;

	chis_upper (c: CHARACTER): BOOLEAN is
		external
			"C"
		end;

	chis_digit (c: CHARACTER): BOOLEAN is
		external
			"C"
		end;

	chis_alpha (c: CHARACTER): BOOLEAN is
		external
			"C"
		end;

end -- class CHARACTER_REF


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
