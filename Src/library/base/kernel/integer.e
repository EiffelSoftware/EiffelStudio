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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

