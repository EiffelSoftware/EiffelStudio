indexing
	description: "Tester of FOURIER_TRANSFORMER class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	FOURIER_TRANSFORMER_TEST

inherit
	EIFFELMATH_TESTING_FRAMEWORK

create
	make


feature -- Initialization

	make is
			-- Test Fourier Transformer class
		local
			test_nr: INTEGER;
			i, j, k: INTEGER;
		do
			test_nr := 0;
			print ("TESTING FOURIER_TRANSFORMER%N");
			print ("Compare with tests in NAG section C06%N");

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06eac - fft of real bra vector to packed complex %N");
	
			create vector.make_real_from_array (
				<<0.34907, 0.54890, 0.74776, 0.94459, 1.13850, 1.32850, 1.51370>>);		
			print ("Vector to be transformed %N%N");
			print (vector);

			print ("After transformation - packed complex vector %N%N");
			create fft.make (vector);
			fft.transform_using_standard_fft (True);
			print (vector);

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing 'as_dual_complex' - see data in test c06eac %N%N");
			vector_copy := deep_clone (vector);
			vector_copy.as_dual_complex;
			print (vector_copy);

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06ebc - from packed complex vector back to original real %N%N");
			fft.transform_using_standard_fft (False);
			print (vector);

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06ecc - fft of complex dual vector to dual complex %N");

			create vector.make_complex_from_arrays (
				<<0.34907, 0.54890, 0.74776, 0.94459, 1.13850, 1.32850, 1.51370>>,
				<<-0.37168, -0.35669, -0.31175, -0.23702, -0.13274, 0.00074, 0.16298>>);		
			print ("Vector to be transformed %N%N");
			print (vector);

			print ("Vector after transformation - dual complex %N%N");
			create fft.make (vector);
			fft.transform_using_standard_fft (True);
			print (vector);

			print ("Inverse transformation - should be the original vector %N%N");
			fft.transform_using_standard_fft (False);
			print (vector);


			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06fpc - fft of real matrix to packed complex %N");
			print ("Each row of matrix is treated as independent row vector %N");

			create matrix.make_real_from_array (
				<<0.3854, 0.6772, 0.1138, 0.6751, 0.6362, 0.1424,
				  0.5417, 0.2983, 0.1181, 0.7255, 0.8638, 0.8723,
				  0.9172, 0.0644, 0.6037, 0.6430, 0.0428, 0.4815 >>, 3, 6);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after transformation - packed complex %N%N");
			create fft.make (matrix);
			fft.transform_using_standard_fft (True);
			print (matrix);

			print ("Converting the results to dual complex form %N%N");
			matrix_copy := deep_clone (matrix);
			matrix_copy.as_dual_complex;
			print (matrix_copy);

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06fqc - fft of packed comlex matrix to real matrix %N");
			print ("Should restore the original matrix %N%N");
			fft.transform_using_standard_fft (False);
			print (matrix);

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06frc - fft of complex dual matrix to dual complex %N");
			print ("Each row of matrix is treated as independent row vector %N");

			create matrix.make_complex_from_arrays (
				<<0.3854, 0.6772, 0.1138, 0.6751, 0.6362, 0.1424,				 
				  0.9172, 0.0644, 0.6037, 0.6430, 0.0428, 0.4815,
				  0.1156, 0.0685, 0.2060, 0.8630, 0.6967, 0.2792 >>,
				<<0.5417, 0.2983, 0.1181, 0.7255, 0.8638, 0.8723,
				  0.9089, 0.3118, 0.3465, 0.6198, 0.2668, 0.1614,
				  0.6214, 0.8681, 0.7060, 0.8652, 0.9190, 0.3355>>,
 				3, 6);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after transformation - dual complex %N%N");
			create fft.make (matrix);
			fft.transform_using_standard_fft (True);
			print (matrix);

			print ("Inverse transformation - restoring original data %N%N");
			fft.transform_using_standard_fft (False);
			print (matrix);

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06fuc - 2-d fft of complex dual matrix to dual complex %N");
			print ("Matrix represents a rectangular grid of data points %N");

			create matrix.make_complex_from_arrays (
				<<1.0000, 0.9990, 0.9870, 0.9360, 0.8020,
				  0.9940, 0.9890, 0.9630, 0.8910, 0.7310,
				  0.9030, 0.8850, 0.8230, 0.6940, 0.4670 >>,
				<<0.0000,-0.0400,-0.1590,-0.3520,-0.5970,
				 -0.1110,-0.1510,-0.2680,-0.4540,-0.6820,
				 -0.4300,-0.4660,-0.5680,-0.7200,-0.8840 >>,
 				3, 5);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after 2-dim transformation - dual complex %N%N");
			create fft.make (matrix);
			fft.transform_using_two_dimensional_fft (True);
			print (matrix);

			print ("Inverse 2-dim transformation - restoring original data %N%N");
			fft.transform_using_two_dimensional_fft (False);
			print (matrix);	

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06hac - sine fft of real matrix to real %N");
			print ("Matrix represents three rows of independent real data %N");

			create matrix.make_real_from_array (
				<<0.6772, 0.1138, 0.6751, 0.6362, 0.1424,
				  0.2983, 0.1181, 0.7255, 0.8638, 0.8723,
				  0.0644, 0.6037, 0.6430, 0.0428, 0.4815 >>,
 				3, 5);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after sine transformation %N%N");
			create fft.make (matrix);
			fft.transform_using_sine_fft (True);
			print (matrix);

			print ("Inverse transformation - restoring original data %N%N");
			fft.transform_using_sine_fft (False);
			print (matrix);	

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06hbc - cosine fft of real matrix to real %N");
			print ("Matrix represents three rows of independent real data %N");

			create matrix.make_real_from_array (
				<<0.3854, 0.6772, 0.1138, 0.6751, 0.6362, 0.1424, 0.9562,
				  0.5417, 0.2983, 0.1181, 0.7255, 0.8638, 0.8723, 0.4936,
				  0.9172, 0.0644, 0.6037, 0.6430, 0.0428, 0.4815, 0.2057 >>,
 				3, 7);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after cosine transformation %N%N");
			create fft.make (matrix);
			fft.transform_using_cosine_fft (True);
			print (matrix);

			print ("Inverse transformation - restoring original data %N%N");
			fft.transform_using_cosine_fft (False);
			print (matrix);	

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06hcc - quarter-sine fft of real matrix to real %N");
			print ("MY COPY OF NAG MANUAL MISSES SOME PAGES HERE - USING MADE UP DATA %N");
			print ("Matrix represents three rows of independent real data %N");

			create matrix.make_real_from_array (
				<<0.6772, 0.1138, 0.6751, 0.6362, 0.1424,
				  0.2983, 0.1181, 0.7255, 0.8638, 0.8723,
				  0.0644, 0.6037, 0.6430, 0.0428, 0.4815 >>,
 				3, 5);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after quarter-sine transformation %N%N");
			create fft.make (matrix);
			fft.transform_using_quarter_sine_fft (True);
			print (matrix);

			print ("Inverse transformation - restoring original data %N%N");
			fft.transform_using_quarter_sine_fft (False);
			print (matrix);	

			test_nr := test_nr + 1; print ("TEST "); print (test_nr); 
			print ("%N========%N"); 
			print ("Testing c06hdc - quarted-cosine fft of real matrix to real %N");
			print ("Matrix represents three rows of independent real data %N");

			create matrix.make_real_from_array (
				<<0.3854, 0.6772, 0.1138, 0.6751, 0.6362, 0.1424,
				  0.5417, 0.2983, 0.1181, 0.7255, 0.8638, 0.8723,
				  0.9172, 0.0644, 0.6037, 0.6430, 0.0428, 0.4815 >>,
 				3, 6);
			print ("Matrix to be transformed %N%N");
			print (matrix);

			print ("Matrix after quarter-cosine transformation %N%N");
			create fft.make (matrix);
			fft.transform_using_quarter_cosine_fft (True);
			print (matrix);

			print ("Inverse transformation - restoring original data %N%N");
			fft.transform_using_quarter_cosine_fft (False);
			print (matrix);	

			print ("%NEnd of FOURIER_TRANSFORMER tests %N");
		end;


feature -- Access

	fft: FOURIER_TRANSFORMER;
			-- Fourier transformer to test

	matrix: BASIC_MATRIX;
			-- Matrix to be transformed

	matrix_copy: BASIC_MATRIX;
			-- auxilliary matrix

	vector: BASIC_VECTOR;
			-- vector to be transformed

	vector_copy: BASIC_VECTOR;
			-- auxiliary vector

end -- class FOURIER_TRANSFORMER_TEST

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

