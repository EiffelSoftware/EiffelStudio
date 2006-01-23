indexing
	description: "Test routines for c02"
	legal: "See notice at end of class."
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


end -- class TEST_POLY_ROOT

