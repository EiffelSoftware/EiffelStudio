indexing
	description: "Tester of Inverter class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	INVERTER_TEST 
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create
	make 


feature -- Initialization

	make is
			-- tests 			
		do
			print ("%N ***************************************** %N");
			print ("INVERTER tests - select one of the listed cases: %N");
			print ("1 - REAL GENERAL system matrix %N");
			print ("2 - REAL SYMMETRIC system matrix %N");
			print ("3 - COMPLEX GENERAL system matrix %N");
			print ("4 - COMPLEX SYMMETRIC system (hermitian) matrix %N");
			print ("%N ***************************************** %N");
		
			print ("%N ***************************************%N");
			print ("Testing REAL GENERAL system matrix %N");
			print ("%N *************************************** %N%N");
			test_real_general;
		
			print ("%N *************************************** %N");
			print ("Testing REAL SYMMETRIC system matrix %N");
			print ("%N *************************************** %N%N");
			test_real_symmetric;

			print ("%N *************************************** %N");
			print ("Testing COMPLEX GENERAL system matrix %N");
			print ("%N *************************************** %N%N");
			test_complex_general;	

			print ("%N *************************************** %N");
			print ("Testing COMPLEX SYMMETRIC system matrix %N");
			print ("%N ******************************** ****** %N%N");
			test_complex_symmetric;	

		end;

feature -- Basic operations
		
	test_real_general is
			-- NAG tests f03afc and f04ajc
		do
			create matrix.make_real_from_array (
				<< 33.0, 16.0, 72.0,
				  -24.0,-10.0,-57.0,
				   -8.0, -4.0,-17.0>>, 3, 3);

			create right_hand.make_real_from_array (
				<<-359.0, 281.0, 85.0>>, 3, 1);
		
			create inverter.make (matrix);
 			print ("%N ---------------- %N");
			print ("%N NAG tests f03afc %N");
			
			print ("%N System matrix before LU factorization %N");
			print (matrix);

			print ("%N System matrix after LU factorization %N");
			print ("(Unit diagonal elements of U are not stored) %N");
			print (inverter.factors);

			print ("%N Array of pivots %N");
			print (inverter.pivots);

			print ("%N Determinant = (");
			print (inverter.scale_det);
			print (") * 2 ^ ");
			print (inverter.power_det);
			print_nl ("");
			
			print ("%N ---------------- %N");
			print ("NAG test f04ajc %N");
			print ("%N Solve for: %N");
			print (right_hand); 
		
			print ("%N Solution: %N");
			print (inverter.solution (right_hand));
	
			print ("%N Inverse of system matrix %N");
			print (inverter.inverse);

			print ("%NProduct of system matrix with its inverse. %N");
			print ("Should be unit matrix %N");
			print (matrix * inverter.inverse);
		end;

	test_real_symmetric is
			--f04aec
		do
			create matrix.make_real_from_array (
				<< 6.0, 7.0, 6.0, 5.0,
				   7.0,11.0, 8.0, 7.0,
				   6.0, 8.0,11.0, 9.0,
				   5.0, 7.0, 9.0,11.0>>, 4, 4);
			matrix.set_symmetricity (True);
			create inverter.make (matrix);
 			print ("%N ---------------- %N");
			print ("%N NAG tests f03aec %N");
			
			print ("%N System matrix before Cholesky's factorization %N");
			print (matrix);

			print ("%N System matrix after Cholesky's factorization %N");
			print (inverter.factors);

			print ("%N Reciprocals of diagonal elements %N");
			print (inverter.reciprocals);

			print ("%N Determinant = (");
			print (inverter.scale_det);
			print (") * 2 ^ ");
			print (inverter.power_det);
			print_nl ("");

			create matrix.make_real_from_array (
				<<5.0,  7.0,  6.0,  5.0,
				  7.0, 10.0,  8.0,  7.0,
				  6.0,  8.0, 10.0,  9.0,
				  5.0,  7.0,  9.0, 10.0>>, 4, 4);

			create inverter.make (matrix);

			create right_hand.make_real_from_array (
				<<23.0, 32.0, 33.0, 31.0>>, 4, 1);
		
			print ("%N ---------------- %N");
			print ("Another NAG test f03aec %N");
			print ("Data as in NAG test f04agc %N");
			
			print ("%N System matrix before Cholesky's factorization %N");
			print (matrix);

			print ("%N System matrix after Cholesky's factorization %N");
			print (inverter.factors);

			print ("%N Reciprocals of diagonal elements %N");
			print (inverter.reciprocals);

			print ("%N Determinant = (");
			print (inverter.scale_det);
			print (") * 2 ^ ");
			print (inverter.power_det);

			print ("%N ---------------- %N");
			print ("NAG test f04agc %N");
			print ("%N Solve for: %N");
			print (right_hand); 
		
			print ("%N Solution: %N");
			print (inverter.solution (right_hand));
	
			print ("%N Inverse of system matrix %N");
			print (inverter.inverse);

			print ("%NProduct of system matrix with its inverse. %N");
			print ("Should be unit matrix %N");
			print (matrix * inverter.inverse);		
		end;

	test_complex_general is
			-- f03ahc, f04akc
		do
		
 			print ("%N ---------------- %N");
			print ("%N NAG tests f03ahc %N");

			create matrix.make_complex_from_arrays ( 
				<<2.0, 1.0, 2.0, 1.0, 1.0, -5.0, 1.0, 0.0, -7.0>>,
				<<0.0, 2.0, 10.0, 1.0, 3.0, 14.0, 1.0, 5.0, 20.0>>,
				3, 3);
			matrix.as_blended_complex;	
		
			create inverter.make (matrix);

			print ("%N System matrix before LU factorization %N");
			print (matrix);

			print ("%N System matrix after LU factorization %N");
			print ("(Unit diagonal elements of U are not stored) - %N");
			print (inverter.factors);

			print ("%N Array of pivots %N");
			print (inverter.pivots);

			print ("%N Determinant = (");
			print (inverter.scale_det);
			print (") * 2 ^ ");
			print (inverter.power_det);
		
			print ("%N ---------------- %N");
			print ("NAG test f04akc (with f03ahc extra) %N");

			create matrix.make_complex_from_arrays (
				<<1.0, 1.0, 2.0, 1.0, 0.0, -5.0, 1.0, 0.0, -8.0>>,
				<<0.0, 2.0, 10.0,1.0, 3.0, 14.0, 1.0, 5.0, 20.0>>,
				3,3);
			matrix.as_blended_complex;

			create right_hand.make_real_from_array (
				<<1.0, 0.0, 0.0>>, 3, 1);
			right_hand.as_blended_complex;
		
			create inverter.make (matrix);

			print ("%N System matrix before LU factorization %N");
			print (matrix);

			print ("%N System matrix after LU factorization %N");
			print ("(Unit diagonal elements of U are not stored) %N");
			print (inverter.factors);

			print ("%N Array of pivots %N");
			print (inverter.pivots);

			print ("%N Determinant = (");
			print (inverter.scale_det);
			print (") * 2 ^ ");
			print (inverter.power_det);
			print ("%N Solve for: %N");
			print (right_hand); 
		
			print ("%N Solution: %N");
			print (inverter.solution (right_hand));
	
			print ("%N Inverse of system matrix %N");
			print (inverter.inverse);

			print ("%NProduct of system matrix with its inverse. %N");
			print ("Should be unit matrix %N");
			print (matrix * inverter.inverse);	
		end;

	test_complex_symmetric is
			--  NAG tests f01bnc and f04awc 
		do	
 			print ("%N ---------------- %N");
			print ("%N NAG test f01bnc %N");

			create matrix.make_complex_from_arrays (
				<< 15.0,  1.0,  2.0, -4.0, 
					1.0, 20.0, -2.0,  3.0,
					2.0, -2.0, 18.0, -1.0,
				   -4.0,  3.0, -1.0, 26.0>>,
				<<  0.0, -2.0,  0.0,  3.0,
					2.0,  0.0,  1.0, -3.0,
					0.0, -1.0,  0.0,  2.0,
				   -3.0,  3.0, -2.0,  0.0>>, 4, 4);
			matrix.as_blended_complex;
			matrix.set_symmetricity (True);

			create inverter.make (matrix);

			print ("%N System matrix before U (H) * U factorization %N");
			print (matrix);

			print ("%N System matrix after U(H)*U factorization %N");
			print ("(Reciprocals of diag elements of U are in 'reciprocals') %N");
			print ("Above diagonal elements are valid components of U %N");

			print (inverter.factors);

			print ("%N Array of reciprocals of %N");
			print (inverter.reciprocals);

		
			print ("%N ---------------- %N");
			print ("NAG test f04awc %N");

			create right_hand.make_complex_from_arrays (
				<< 25.0, 21.0, 12.0, 21.0>>,
				<< 34.0, 19.0,-21.0,-27.0>>, 4, 1);
			right_hand.as_blended_complex;

			print ("%N System matrix before LU factorization %N");
			print (matrix);
		
			print ("%N Solution: %N");
			print (inverter.solution (right_hand));
	
			print ("%N Inverse of system matrix %N");
			print (inverter.inverse);

			print ("%NProduct of system matrix with its inverse. %N");
			print ("Should be unit matrix %N");
			print (matrix * inverter.inverse);			
		end;

feature -- Access

	inverter: INVERTER;
			-- Inverter object tested
	
	matrix: BASIC_MATRIX;
			-- matrix supplied to inverter
			-- to be its system matrix

	right_hand: BASIC_MATRIX;
			-- right-hand side vector or matrix

end -- class INVERTER_TEST

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

