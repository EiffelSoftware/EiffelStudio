indexing

	description:
		"Integer values";

	status: "See notice at end of class";
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

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current integer?
		do
			-- Built-in
		end;

feature -- Basic operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			-- Built-in
		end;

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			-- Built-in
		end;

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			-- Built-in
		end;

	infix "/" (other: like Current): DOUBLE is
			-- Division by `other'
		do
			-- Built-in
		end;

	prefix "+": like Current is
			-- Unary plus
		do
			-- Built-in
		end;

	prefix "-": like Current is
			-- Unary minus
		do
			-- Built-in
		end;

	infix "//" (other: like Current): like Current is
			-- Integer division of Current by `other'
		do
			-- Built-in
		end;

	infix "\\" (other: like Current): like Current is
			-- Remainder of the integer division of Current by `other'
		do
			-- Built-in
		end;

	infix "^" (other: NUMERIC): DOUBLE is
			-- Integer power of Current by `other'
		do
			-- Built-in
		end;

end -- class INTEGER


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

