indexing

	description:
		"Integer values";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

expanded class INTEGER inherit

	INTEGER_REF
		redefine
			infix "/",
			infix "^"
		end

feature -- Basic operations

	infix "/" (other: like Current): DOUBLE is
			-- Division by `other'
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

