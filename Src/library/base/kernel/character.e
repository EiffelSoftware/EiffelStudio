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
			code
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
