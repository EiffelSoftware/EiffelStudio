indexing
	description: "Tester of Surface Spline Approximator class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	SURFACE_SPLINE_APPROXIMATOR_TEST
	
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make 


feature -- Initialization

	make is
			-- Test of SURFACE_SPLINE_APPROXIMATOR		
		local
		
			x, y,  x1, y1: BASIC_VECTOR;
			f, f1: BASIC_MATRIX;
			i, j: INTEGER;
		
		do
			create form.make(12, 3);
			print_nl ("Test of SURFACE_SPLINE_APPROXIMATOR");
			create x.make_real_from_array (
				<<0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0>>);
			create y.make_real_from_array (
				<<0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0>>);
			
			create f.make_real_from_array (
				<<   1.0000E+00,  8.8758E-01,  5.4030E-01,  7.0737E-02, 	
					-4.1515E-01, -8.0114E-01, -9.7999E-01, -9.3446E-01, -6.5664E-01,
					 1.5000E+00,  1.3564E+00,  8.2045E-01,  1.0611E-01, 
					-6.2422E-01, -1.2317E+00, -1.4850E+00, -1.3047E+00, -9.8547E-01, 
					 2.0600E+00,  1.7552E+00,  1.0806E+00,  1.5147E-01, 
					-8.3229E-01, -1.6023E+00, -1.9700E+00, -1.8729E+00, -1.4073E+00, 
					 2.5700E+00,  2.1240E+00,  1.3508E+00,  1.7684E-01, 
					-1.0404E+00, -2.0029E+00, -2.4750E+00, -2.3511E+00, -1.6741E+00,  
					 3.0000E+00,  2.6427E+00,  1.6309E+00,  2.1221E-01, 
					-1.2484E+00, -2.2034E+00, -2.9700E+00, -2.8094E+00, -1.9809E+00,
					 3.5000E+00,  3.1715E+00,  1.8611E+00,  2.4458E-01, 
					-1.4565E+00, -2.8640E+00, -3.2650E+00, -3.2776E+00, -2.2878E+00,
					 4.0400E+00,  3.5103E+00,  2.0612E+00,  2.8595E-01, 
					-1.6946E+00, -3.2046E+00, -3.9600E+00, -3.7958E+00, -2.6146E+00, 
					 4.5000E+00,  3.9391E+00,  2.4314E+00,  3.1632E-01, 
					-1.8627E+00, -3.6351E+00, -4.4550E+00, -4.2141E+00, -2.9314E+00, 
					 5.0400E+00,  4.3879E+00,  2.7515E+00,  3.5369E-01, 
					-2.0707E+00, -4.0057E+00, -4.9700E+00, -4.6823E+00, -3.2382E+00, 
					 5.5050E+00,  4.8367E+00,  2.9717E+00,  3.8505E-01, 
					-2.2888E+00, -4.4033E+00, -5.4450E+00, -5.1405E+00, -3.5950E+00,
					 6.0000E+00,  5.2755E+00,  3.2418E+00,  4.2442E-01, 
					-2.4769E+00, -4.8169E+00, -5.9300E+00, -5.6387E+00, -3.9319E+00>>, 
				11, 9); 

		
			print_nl ("Making object SURFACE_SPLINE_APPROXIMATOR - NAG e02dcc ");
			print_nl ("with assumed smoothness = 0.1 ");
			create approximator.make (x, y, f, 0.1, 15, 13);
			printv (" Closeness (sum of squared residuals) = ", approximator.closeness);

			print_nl ("Distinct knots_x - see e02dcc test results");
			j := approximator.knots_x.count - 3;
			from i := 4 until i > j loop
				print( form.formatted (approximator.knots_x.real_item (i)));
				i := i + 1;
			end;
			print_nl ("");

			print_nl (" Distinct knots_y - see e02dcc test results %N");
			j := approximator.knots_y.count - 3;
			from i := 4 until i > j loop
				print( form.formatted (approximator.knots_y.real_item (i)));
				i := i + 1;
			end;
			print_nl ("")

			printv (" B-spline coefficients - see e02dcc test results",
					approximator.coefficients);

			create x1.make_real_from_array (
				<<0.0, 1.0, 2.0, 3.0, 4.0, 5.0>>);
			create y1.make_real_from_array (
				<<0.0, 1.0, 2.0, 3.0, 4.0>>);
			printv ("Values on grid (e01dcc)", approximator.values_on_grid(x1, y1));
			print_nl (" End of tests for SURFACE_SPLINE_APPROXIMATOR class ");
	end;

feature -- Access

	approximator: SURFACE_SPLINE_APPROXIMATOR;
			-- Object tested

	form: FORMAT_SCIENTIFIC
			-- Formatter of printouts

	
end -- class SURFACE_SPLINE_APPROXIMATOR_TEST

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

