indexing
	description: " Test quick sortmultiple regression suite."
	legal: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEST_QUICKSORT

