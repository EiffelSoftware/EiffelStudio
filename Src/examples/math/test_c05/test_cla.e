-- a class containing some features to be integrated via C.
indexing
	description: "Pretend this is your application class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TEST_CLASS

feature -- Access

	f1 (x: DOUBLE): DOUBLE is
			-- A function with a zero at 1.5.
			-- but makes the answer f1(x) = x so we know the answer.	
		do
			Result := (1.5 - x) * (x + 1.);
		end;	 

end -- class TEST_CLASS

--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for numerical
--| computation ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

