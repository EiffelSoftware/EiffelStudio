indexing

	description:
		"Real values, double precision";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

expanded class DOUBLE inherit

	DOUBLE_REF
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

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current double?
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
			-- Product with `other'
		do
			-- Built-in
		end;

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		do
			-- Built-in
		end;

	infix "^" (other: NUMERIC): DOUBLE is
			-- Current double to the power `other'
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

end -- class DOUBLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
