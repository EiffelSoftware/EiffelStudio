indexing

	description:
		"Real values";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

expanded class REAL inherit

	REAL_REF
		redefine
			infix "<",
			infix "+",
			infix "-",
			infix "*",
			infix "/",
			infix "^",
			prefix "+",
			prefix "-"
		end

feature -- Comparison

	infix "<" (other: REAL): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			-- Built-in
		end; -- infix "<"

feature -- Basic operations

	infix "+" (other: REAL): REAL is
			-- Sum with `other'
		do
			-- Built-in
		end; -- infix "+"

	infix "-" (other: REAL): REAL is
			-- Result of subtracting `other'
		do
			-- Built-in
		end; -- infix "-"

	infix "*" (other: REAL): REAL is
			-- Product by `other'
		do
			-- Built-in
		end; -- infix "*"

	infix "/" (other: REAL): REAL is
			-- Division by `other'
		do
			-- Built-in
		end; -- infix "/"

	infix "^" (other: REAL): REAL is
			-- Current real to the power `other'
		do
			-- Built-in
		end; -- infix "^"

	prefix "+": REAL is
			-- Unary plus
		do
			-- Built-in
		end; -- prefix "+"

	prefix "-": REAL is
			-- Unary minus
		do
			-- Built-in
		end; -- prefix 

end -- class REAL


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
