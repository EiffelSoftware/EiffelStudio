indexing
	description: "A small test for Special Functions";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TEST_S
inherit
	EIFFELMATH_TESTING_FRAMEWORK
	SPECIAL_FUNCTIONS
		undefine
			print
		end

create
	make

feature
	make is
			-- See if things compile, anyway.
		local
			a, x, p, q: DOUBLE;
		do
			print(tanh(0.5));
			print( "<-- tanh(0.5) should be 0.46212%N");

			print(p_incomplete_gamma(2., 3., 0.));
			print( "<-- p(2.,3.) should be 0.8009%N");
			print(p_incomplete_gamma(2., 3., 0.));
			print( "<-- p(2.,3.) should be 0.8009%N");
			print(q_incomplete_gamma(2., 3., 0.));
			print( "<-- q(2.,3.) should be 0.1991%N");
			print(p_incomplete_gamma(7., 1., 0.));
			print( "<-- p(7.,1.) should be 0.0001%N");
			print(q_incomplete_gamma(20., 21., 0.));
			print( "<-- q(20.,21.) should be 0.3843%N");
			print(q_incomplete_gamma(2., 3., 0.));
			print( "<-- q(2.,3.) should be 0.1991%N");
		end;

end -- class TEST_S
			
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

