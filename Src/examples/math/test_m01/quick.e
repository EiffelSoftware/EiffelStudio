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
