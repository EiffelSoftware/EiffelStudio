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
--| EiffelMath: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

