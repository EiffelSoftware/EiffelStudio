indexing
	description: "Test routines for c02"
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TEST_POLY_ROOT 

inherit

	EIFFELMATH_TESTING_FRAMEWORK

creation
	make

feature -- The main program

	make (args: ARRAY [STRING]) is
			-- test of various routines from d01
		local
			zz: POLYNOMIAL_ROOT_FINDER;
			v: BASIC_VECTOR
		do
			!! v.make_complex_from_array ( <<
				5., 6., 
				30., 20., 
				-0.2, -6.0,
				50.0, 100000.0,
				-2.0, 40.,
				10., 1.0 
				>>);
			!! zz.make (v);
			print(zz.roots);
			print ("Compare to c02afc example.%N");	

			!! v.make_real_from_array (<<1., 2., 3., 4., 5., 6>>);
			!! zz.make (v);
			print(zz.roots);
			print ("Compare to c02agc example.%N");	
		end;

end -- class TEST_POLY_ROOT

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

