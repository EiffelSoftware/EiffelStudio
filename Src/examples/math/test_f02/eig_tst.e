indexing
	description: "Tester of Eigensystem class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	EIGENSYSTEM_TEST
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create
	make

feature -- Initialization

	make is
-- Run current test.
		do
			print ("%N ***************************************** %N");
			print ("Eigensystem tests - select one of the cases: %N");
			print ("1 - SYMMETRIC REAL system %N");
			print ("2 - UNSYMMETRIC REAL system %N");
			print ("3 - SYMMETRIC COMPLEX system %N");
			print ("%N ***************************************** %N");

			print ("%N ******************************** %N");
			print ("Testing REAL SYMMETRIC system %N");
			print ("%N ******************************** %N %N");
			test_real_symmetric;
			print ("%N ******************************** %N");
			print ("Testing REAL UNSYMMETRIC system %N");
			print ("%N ******************************** %N %N");
			test_real_non_symmetric;
			print ("%N ******************************** %N");
			print ("Testing COMPLEX SYMMETRIC system %N");
			print ("%N ******************************** %N %N");
			test_complex_symmetric;
		end;

feature -- Basic operations

	test_real_non_symmetric is
			--	
		do
			-- PART I: NAG tests f02afc, f02agc

			create system.make_real_from_array (
				<<  1.5, 0.1,  4.5, -1.5,
				  -22.5, 3.5, 12.5, -2.5,
				   -2.5, 0.3,  4.5, -2.5,
				   -2.5, 0.1,  4.5,  2.5>>, 4, 4);

			create eigen.make (system);
			
			values := eigen.eigenvalues;
			vectors := eigen.eigenvectors;

			print ("%N ---------------- %N");
			print ("NAG tests f02afc and f02agc %N");
			
			print ("System matrix %N");
			print (system);
			print_nl ("");

			print ("Eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Eigenvectors %N");
			print (vectors);
			print_nl ("");
		
			print ("Iterations %N");
			print (eigen.iterations);
			print_nl ("");

			-- PART II: made up tests f02bjc 

			print ("Implicit assumption: extra matrix is unit matrix %N");
			print ("since it was not defined yet. %N");
			print ("Generalized eigenvectors and eigenvalues%N");
			print ("should match the previous results %N");
			print ("These are the made up tests: f02bjc  %N");

			values := eigen.generalized_eigenvalues;
			vectors := eigen.generalized_eigenvectors;

			print ("Extra matrix - should be unit matrix %N");
			print (eigen.extra);
			print_nl ("");

			print ("Generalized eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Generalized eigenvectors %N");
			print (vectors);
			print_nl ("");

			print ("Iterations %N");
			print (eigen.iterations);
			print_nl ("");

			-- PART III: NAG tests f02bjc
			create system.make_real_from_array (
				<<  3.9,   4.3,   4.3,   4.4,
				   12.5,  21.5,  21.5,  26.0,
				  -34.5, -47.5, -43.5, -46.0,
				   -0.5,   7.5,   3.5,   6.0>>, 4, 4);
			create eigen.make (system);

			create extra.make_real_from_array (
				<< 1.0,  1.0,  1.0,  1.0,
				   2.0,  3.0,  3.0,  3.0,
				  -3.0, -5.0, -4.0, -4.0,
				   1.0,  4.0,  3.0,  4.0>>, 4, 4);

			print("NAG tests: f02bjc %N");

			eigen.set_extra_matrix (extra);
		
			vectors := eigen.generalized_eigenvectors;
			values := eigen.generalized_eigenvalues;
		
			print ("New system matrix %N");
			print (system);
			print_nl ("");

			print ("Extra matrix %N");
			print (eigen.extra);
			print_nl ("");

			print ("Generalized eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Generalized eigenvectors %N");
			print (vectors);
			print_nl ("");
	
			print ("Iterations %N");
			print (eigen.iterations);
			print_nl ("");
		end;

	test_real_symmetric is
			-- Test the real symmetric case.		
		do
			-- PART I: NAG tests f02aac, f02abc
			create system.make_real_from_array (
				<< 0.5,  0.0, 2.3,-2.6,
				   0.0,  0.5,-1.4,-0.7,
				   2.3, -1.4, 0.5, 0.0,
				  -2.6, -0.7, 0.0, 0.5>>, 4, 4);
			system.set_symmetricity (True);

			create eigen.make (system);
			
			values := eigen.eigenvalues;
			vectors := eigen.eigenvectors;

			print ("%N ---------------- %N");
			print ("NAG tests f02aac and f02abc %N");
			
			print ("System matrix %N");
			print (system);
			print_nl ("");

			print ("Eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Eigenvectors %N");
			print (vectors);
			print_nl ("");
		
			-- PART II: made up tests f02adc, f02aec

			print ("Implicit assumption: extra matrix is unit matrix %N");
			print ("since it was not defined yet. %N");
			print ("Generalized eigenvectors and eigenvalues%N");
			print ("should match the previous results %N");
			print ("These are the made up tests: f02adc and f02aec %N");

			values := eigen.generalized_eigenvalues;
			vectors := eigen.generalized_eigenvectors;

			print ("Extra matrix - should be unit matrix %N");
			print (eigen.extra);
			print_nl ("");

			print ("Generalized eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Generalized eigenvectors %N");
			print (vectors);
			print_nl ("");

			-- PART III: NAG tests f02adc, f02aec
			create system.make_real_from_array (
				<<0.5,  1.5,  6.6, 4.8,
				  1.5,  6.5, 16.2, 8.6,
				  6.6, 16.2, 37.6, 9.8,
				  4.8,  8.6,  9.8, -17.1>>, 4, 4);

			system.set_symmetricity (True);

			create extra.make_real_from_array (
				<<1.0,  3.0,  4.0, 1.0,
				  3.0, 13.0, 16.0, 11.0,
				  4.0, 16.0, 24.0, 18.0,
				  1.0, 11.0, 18.0, 27.0>>, 4, 4);

			extra.set_positivity (True);

			print("NAG tests: f02adc and f02aec %N");

			create eigen.make (system);
			eigen.set_extra_matrix (extra);
			values := eigen.generalized_eigenvalues;
			vectors := eigen.generalized_eigenvectors;

			print ("New system matrix %N");
			print (system);
			print_nl ("");

			print ("Extra matrix %N");
			print (eigen.extra);
			print_nl ("");

			print ("Generalized eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Generalized eigenvectors %N");
			print (vectors);
			print_nl ("");
		end;

	test_complex_symmetric is
			-- Test the complex symmetric case.
		do
			-- PART I: NAG tests f02awc, f02axc

			create system.make_complex_from_arrays (
				<<0.50, 0.00, 1.84, 2.08,
				  0.00, 0.50, 1.12,-0.56,
				  1.84, 1.12, 0.50, 0.00,
				  2.08,-0.56, 0.00, 0.50>>,

				<<0.00, 0.00, 1.38,-1.56,
				  0.00, 0.00, 0.84, 0.42,
				 -1.38,-0.84, 0.00, 0.00,
				  1.56,-0.42, 0.00, 0.00>>, 4, 4);
			system.as_blended_complex;
			system.set_symmetricity (True);

			create eigen.make (system);
			
			values := eigen.eigenvalues;
			vectors := eigen.eigenvectors;

			print ("%N ---------------- %N");
			print ("NAG tests f02awc and f02axc %N");
			
			print ("System matrix %N");
			print (system);
			print_nl ("");

			print ("Eigenvalues %N");
			print (values);
			print_nl ("");

			print ("Eigenvectors %N");
			print (vectors);
			print_nl ("");
		end;

feature -- Access

	eigen: EIGENSYSTEM;
			-- Main object to test

	system: BASIC_MATRIX;
			-- Copy of system matrix
			-- from object 'eigen'

	extra: BASIC_MATRIX;
			-- Copy of extra matrix
			-- from object 'eigen'

	vectors: BASIC_MATRIX;
			-- Copy of eigenvectors

	values: BASIC_VECTOR;
			-- Copy of eigenvalues

end -- class EIGENSYSTEM_TEST

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

