indexing 
	description: "Tester of Curve Spline Approximator classes"; 
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class 

	CURVE_SPLINE_APPROXIMATOR_TEST 

inherit

	EIFFELMATH_TESTING_FRAMEWORK
 
create 
 
	make 
 
 
feature -- Initialization 

	make is
			-- Test curve spline approximator routines
		do
			create form.make (13, 4);
			create x.make_real_from_array ( 
				<<0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 
				4.5, 5.0, 5.5, 6.0, 7.0, 7.5, 8.0>>); 
			create f.make_real_from_array ( 
				<<-1.1, -0.372, 0.431, 1.69, 2.11, 3.1, 4.23, 
				4.35, 4.81, 4.61, 4.79, 5.23, 6.35, 7.19, 7.97>>); 
			create w.make_real_from_array ( 
				<<1.0, 2.0, 1.5, 1.0, 3.0, 1.0, 0.5, 1.0, 2.0, 
				2.5, 1.0, 3.0, 1.0, 2.0, 1.0>>);
			test_curve_spline_approximator;
			test_knotted_curve_spline_approximator (1.0);
			test_knotted_curve_spline_approximator (0.5);
		end;

	test_curve_spline_approximator is 
			-- Test of CURVE_SPLINE_APPROXIMATOR
		local		 
			x1: BASIC_VECTOR;
			s: ARRAY [DOUBLE]; 
			eval: BASIC_MATRIX; 
			a, smooth: DOUBLE; 
			i, j: INTEGER;
		do 
			print_nl ("Testing CURVE_SPLINE_APPROXIMATOR - NAG e02bec"); 
			s := <<1.0, 0.5, 0.1, 0.0 >>; 
			create x1.make_real ((x.count) * 2 - 1); 
			from 
				i := 1 
			until 
				i = x.count 
			loop 
				x1.put_real (x.real_item(i), 2 * i - 1); 
				x1.put_real ((x.real_item (i) + x.real_item (i + 1))/2, 2 * i); 
				i := i + 1; 
			end; 
			x1.put_real (x.real_item (x.count), x1.count); 
			create eval.make_real (4, x1.count); 
			from 
				j := 1 
			until 
				j > 4 
			loop 
				smooth := s.item (j)
				if j = 1 then
					create approximator.make (x, f, w, smooth, 54);
				else
					approximator.set_smoothness (smooth);
				end; 
				printv ("For smoothness = ", approximator.smoothness);
				printv ("Coefficients", approximator.coefficients);
				printv ("Closeness", approximator.closeness);
				printv ("Knots", approximator.knots);
				from 
					i := 1 
				until 
					i > x1.count 
				loop 
					a := x1.real_item(i); 
					eval.put_grid_real (approximator.value (a), j, i); 
					i := i + 1; 
				end;
				j := j + 1; 
			end; 
 
			print_nl ("--------------------------------------------------"); 
			print_nl ("Comparing the results of evaluation 'value' (e02bbc)"); 
			print_nl ("for smoothnesses: 1.0, 0.5, 0.1, 0.0"); 
			print_nl (
			"Refer to results of NAG test e02bec - shown as three plots there."); 
		 
			from 
				i := 1; 
			until 
				i > x1.count 
			loop 
				print ("x = "); 
				print (form.formatted (x1.real_item (i))); 
				print (" -> "); 
				from j := 1 until j > 4 loop 
					print ("  "); 
					print (form.formatted (eval.real_grid_item (j, i))); 
					j := j + 1; 
				end; 
				print_nl (""); 
				i := i + 1; 
			end;
 
			print_nl ("End of tests for CURVE_SPLINE_APPROXIMATOR class.");			 
		end; 

	test_knotted_curve_spline_approximator (s: DOUBLE) is 
			-- Test of KNOTTED_CURVE_SPLINE_APPROXIMATOR,
			-- comparing against test of smoothness `s' using CURVE_SPLINE_APPROXIMATOR
		local		 
			kold, knew: BASIC_VECTOR;
			knotted_approximator: KNOTTED_CURVE_SPLINE_APPROXIMATOR;
			i, n: INTEGER;
		do 
			-- Use the (interior) knots from the other approximator.
			create approximator.make (x, f, w, s, 54);
			kold := approximator.knots;
			n := kold.count - 8;
			create knew.make_real (n);
			from i := 1 until i > n loop
				knew.put_real (kold.real_item (4 + i), i)
				i := i + 1;
			end;
			print_nl ("Making object KNOTTED_CURVE_SPLINE_APPROXIMATOR - NAG e02bac");
			printv ("Knots input", knew)

			create knotted_approximator.make (x, f, w, knew);

			printv ("Coefficients", knotted_approximator.coefficients)
			printv ("Knots used", knotted_approximator.knots)
			printv ("Closeness", knotted_approximator.closeness)
			printv ("Coefficients from CURVE_SPLINE_APPROXIMATOR, same knots",
				approximator.coefficients)
		end;

feature -- Access 
 
	approximator: CURVE_SPLINE_APPROXIMATOR; 
			-- Object to be tested 
 
	form: FORMAT_SCIENTIFIC 
			-- Formatter of printouts 
 
 	x: BASIC_VECTOR;
 			-- The x values

 	f: BASIC_VECTOR;
 			-- The y values

 	w: BASIC_VECTOR;
 			-- The weights
		 
end -- class CURVE_SPLINE_APPROXIMATOR_TEST 
 
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

