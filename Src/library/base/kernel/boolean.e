indexing

	description:
		"Truth values, with the boolean operations";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

expanded class BOOLEAN inherit

	BOOLEAN_REF
		redefine
			infix "and",
			infix "and then",
			infix "implies",
			prefix "not",
			infix "or",
			infix "or else",
			infix "xor"
		end

feature -- Basic operations

	infix "and" (other: BOOLEAN): BOOLEAN is
			-- Boolean conjunction with `other'
		do
			-- Built-in
		end;

	infix "and then" (other: BOOLEAN): BOOLEAN is
			-- Boolean semi-strict conjunction with `other'
		do
			-- Built-in
		end;

	infix "implies" (other: BOOLEAN): BOOLEAN is
			-- Boolean implication of `other'
			-- (semi-strict)
		do
			-- Built-in
		end;

	prefix "not" : BOOLEAN is
			-- Negation.
		do
			-- Built-in
		end;

	infix "or" (other: BOOLEAN): BOOLEAN is
			-- Boolean disjunction with `other'
		do
			-- Built-in
		end;

	infix "or else" (other: BOOLEAN): BOOLEAN is
			-- Boolean semi-strict disjunction with `other'
		do
			-- Built-in
		end;

	infix "xor" (other: BOOLEAN): BOOLEAN is
			-- Boolean exclusive or with `other'
		do
			-- Built-in
		end;

end -- class BOOLEAN


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
