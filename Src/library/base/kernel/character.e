indexing

	description:
		"Characters, with comparison operations and an ASCII code";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

expanded class CHARACTER inherit

	CHARACTER_REF
		redefine
			infix "<",
			code,
			upper, lower,
			is_lower, is_upper, is_digit, is_alpha
		end

feature -- Access

	code: INTEGER is
			-- Associated integer value
		do
			-- Built-in
		end;


feature -- Comparison

	infix "<" (other: CHARACTER): BOOLEAN is
			-- Is `other' greater than current character?
		do
			-- Built-in
		end;

feature -- Conversion

	upper: CHARACTER is
			-- Uppercase value of `Current'
			-- Returns `Current' if not `is_lower'
		do
			Result := chupper (Current)
		end;

	lower: CHARACTER is
			-- Lowercase value of `Current'
			-- Returns `Current' if not `is_upper'
		do
			Result := chlower (Current)
		end;

feature -- Status report

	is_lower: BOOLEAN is
			-- Is `Current' lowercase?
		do
			Result := chis_lower (Current)
		end;

	is_upper: BOOLEAN is
			-- Is `Current' uppercase?
		do
			Result := chis_upper (Current)
		end;

	is_digit: BOOLEAN is
			-- Is `Current' a digit?
			-- A digit is one of 0123456789
		do
			Result := chis_digit (Current)
		end;

	is_alpha: BOOLEAN is
			-- Is `Current' alphabetic?
			-- Alphabetic is `is_upper' or `is_lower'
		do
			Result := chis_alpha (Current)
		end;

end -- class CHARACTER


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
