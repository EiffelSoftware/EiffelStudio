indexing

	description:
		"Integer values";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

expanded class INTEGER inherit

	INTEGER_REF
		redefine
			infix "<",
			infix "+",
			infix "-",
			infix "*",
			infix "/",
			infix "^",
			prefix "+",
			prefix "-",
			infix "//",
			infix "\\"
		end

feature -- Comparison

	infix "<" (other: INTEGER): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			-- Built-in
		end;

feature -- Basic operations

	infix "+" (other: INTEGER): INTEGER is
			-- Sum with `other'
		do
			-- Built-in
		end;

	infix "-" (other: INTEGER): INTEGER is
			-- Result of subtractiing `other'
		do
			-- Built-in
		end;

	infix "*" (other: INTEGER): INTEGER is
			-- Product by `other'
		do
			-- Built-in
		end;

	infix "/" (other: INTEGER): REAL is
			-- Division by `other'
		do
			-- Built-in
		end;

	prefix "+": INTEGER is
			-- Unary plus
		do
			-- Built-in
		end;

	prefix "-": INTEGER is
			-- Unary minus
		do
			-- Built-in
		end; 

	infix "//" (other: INTEGER): INTEGER is
			-- Integer division of Current by `other'
		do
			-- Built-in
		end;

	infix "\\" (other: INTEGER): INTEGER is
			-- Remainder of the integer division of Current by `other'
		do
			-- Built-in
		end;

	infix "^" (other: INTEGER): INTEGER is
			-- Integer power of Current by `other'
		do
			-- Built-in
		end;

end -- class INTEGER


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
