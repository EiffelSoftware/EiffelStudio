indexing
	description: "Tester of Orthogonal Transformer Minimizer class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	ORTHOGONAL_TRANSFORMER_MINIMIZER_TEST
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create
	make

	
feature -- Initialization

	make is
			-- test case real and complex
		local
			i: INTEGER;
			running: BOOLEAN;
		do
			print ("%N ********************************%N");
			print ("ORTHOGONAL_TRANSFORMER_MINIMIZER tests %N");
			print ("	select one %N");
			print ("1 - Complex syetem matrix %N");
			print ("2 - Real system matrix %N");
			print ("%N *******************************%N");
			
			print ("%N ******************************** %N");
			print ("Testing Complex system %N");
			print ("%N ******************************** %N %N");
			test_complex;

			print ("%N ******************************** %N");
			print ("Testing Real system %N");
			print ("%N ******************************** %N %N");
			test_real;
		end;		


feature -- Basic operations

	test_real is
		do
			create system.make_real_from_array (
				<<2.0, 2.5, 2.5,
				  2.0, 2.5, 2.5,
				  1.6,-0.4, 2.8,
				  2.0,-0.5, 0.5,
				  1.2,-0.3,-2.9>>, 5, 3);

			create orth.make (system);

			print ("%N ---------------- %N");
			print ("%N NAG tests f01qcc - see Nag manual%N");
						
			print ("%N System matrix before QR factorization %N");
			print (system);

			print ("%N Details of QR factorization %N");
			print (orth.factors);

			print ("%N Auxiliary vector zeta %N");
			print (orth.zeta);
		
			print ("%N ---------------- %N");
			print ("%N NAG tests f01qec - see Nag manual%N");
			print ("%N Explicit form of the transformer matrix Q %N");
			print (orth.orthogonal_transformer);
	
			print ("%N ---------------- %N");
			print ("%N NAG tests f01qdc %N");

			create extra.make_real_from_array (
				<<1.1, 0.0,
				  0.9, 0.0,
				  0.6, 1.32,
				  0.0, 1.1,
				 -0.8, -0.26>>, 5, 2);

			extra1 := deep_clone (extra);

			print ("%N Matrix B to be transformed %N");
			print (extra);

			print ("%N  B = (Q transposed) * B %N");
			orth.transform (extra, True);
			print (extra);

			print ("%N   B = Q * B %N");
			orth.transform (extra1, False);
			print (extra1);

			print ("%N Testing feature 'solution' - made up data..%N");
			create vector.make_real_from_array (
				<<1.0, 0.0, 1.0>>);
			vector.transpose;
			vector := system | vector;
			print ("Assuming solution  <x| = {1, 0, 1}%N");
			print ("Vector |b> = A |x> %N");
			print (vector);
			print ("Now seeking |x> which minimizes |b> - A|x> %N");
			print ("Should be close to {1, 0, 1) %N%N");

			
			vector := orth.solution (vector);
	
			print (vector);
			print ("%N height, width: %N");
			print (vector.height);
			print_nl ("");
			print (vector.width);
			

		end;
	
	test_complex is
			-- case of complex system
		do
			create system.make_complex_from_array (
				<<0.0, 0.5,-0.5, 1.5,-1.0, 1.0, 
				  0.4, 0.3, 0.9, 1.3, 0.2, 1.4,
				  0.4, 0.0,-0.4, 0.4, 1.8, 0.0,
				  0.3,-0.4, 0.1, 0.7, 0.0, 0.0,
				  0.0,-0.3, 0.3, 0.3, 0.0, 2.4>>, 5, 3);

			create orth.make (system);

			print ("%N ---------------- %N");
			print ("%N NAG tests f01rcc %N");
						
			print ("%N System matrix before QR factorization %N");
			print (system);

			print ("%N Details of QR factorization %N");
			print (orth.factors);

			print ("%N Auxiliary vector zeta %N");
			print (orth.zeta);
		
			print ("%N ---------------- %N");
			print ("%N NAG tests f01rec %N");
			print ("%N Explicit form of the transformer matrix Q %N");
			print (orth.orthogonal_transformer);
	
			print ("%N ---------------- %N");
			print ("%N NAG tests f01rdc %N");

			create extra.make_complex_from_array (
				<<-0.55, 1.05, 0.45, 1.05,
				   0.49, 0.93, 1.09, 0.13,
				   0.56,-0.16, 0.64, 0.16,
				   0.39, 0.23,-0.39,-0.23,
				   1.13, 0.83,-1.13, 0.77>>, 5, 2);

			extra1 := deep_clone (extra);
			print ("%N Matrix B to be transformed %N");
			print (extra);

			print ("%N B = (Q conjugated transposed) * B %N");
			orth.transform (extra, True);
			print (extra);

			print ("%N Matrix B after transformation:  B = Q * B %N");
			orth.transform (extra1, False);
			print (extra1);

			print ("%N Testing feature 'solution' - made up data..%N");
			create vector.make_complex_from_array (
				<<1.0, 0.0, 0.0, 0.0, 1.0, 0.0>>);
			vector.transpose;
			vector := system | vector;
			vector.as_blended_complex;

			print ("Assuming complex solution  <x| = {1+i0,0 +i0, 1+i0}%N");
			print ("Vector |b> = A |x> %N");
			print (vector);
			print ("Now seeking |x> which minimizes |b> - A|x> %N");
			print ("Should be close to {1+i0, 0+i0, 1+i0) %N%N");
			print (orth.solution(vector));
		end;


feature -- Access

	orth: ORTHOGONAL_TRANSFORMER_MINIMIZER;
			-- test object

	system: BASIC_MATRIX;
			-- system matrix

	extra: BASIC_MATRIX;
			-- matrix to be transformed

	extra1: BASIC_MATRIX;

	vector: BASIC_VECTOR
			-- Right hand side of A|x>= |vector>
			-- (Seeking |x>)

end -- class ORTHOGONAL_TRANSFORMER_MINIMIZER_TEST

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

