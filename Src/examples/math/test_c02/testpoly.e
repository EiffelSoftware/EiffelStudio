indexing
	description: "Test routines for c02"
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TEST_POLY_ROOT 

inherit

	EIFFELMATH_TESTING_FRAMEWORK

create
	make

feature -- The main program

	make (args: ARRAY [STRING]) is
			-- test of various routines from d01
		local
			zz: POLYNOMIAL_ROOT_FINDER;
			v: BASIC_VECTOR
		do
			create v.make_complex_from_array ( <<
				5., 6., 
				30., 20., 
				-0.2, -6.0,
				50.0, 100000.0,
				-2.0, 40.,
				10., 1.0 
				>>);
			create zz.make (v);
			print(zz.roots);
			print ("Compare to c02afc example.%N");	

			create v.make_real_from_array (<<1., 2., 3., 4., 5., 6>>);
			create zz.make (v);
			print(zz.roots);
			print ("Compare to c02agc example.%N");	
		end;

end -- class TEST_POLY_ROOT

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

