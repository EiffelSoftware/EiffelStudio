indexing
	description: " Test quick sortmultiple regression suite.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	TEST_QUICKSORT

inherit

	EIFFELMATH_TESTING_FRAMEWORK
create

	make

feature -- Basic operations

	make is
			-- Test quicksort
		local
			a: ARRAY [DOUBLE]
			q: expanded ARRAY_UTILITIES
		do
			print_nl ("Test of quicksort from ARRAY_UTILITIES%N")
			a := << 1., 5., 2., 4., 3., 6., 7., 8.>>;
			q.quicksort (a, True);
			printa ("Ascending order", a)
			q.quicksort (a, False);
			printa ("Descending order", a)
		end;

end -- class TEST_QUICKSORT

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

