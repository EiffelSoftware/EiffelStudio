indexing
	description: "Tester of Surface Spline Interpolator class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	SURFACE_SPLINE_INTERPOLATOR_TEST

inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make 


feature -- Initialization

	make is
			-- Test of SURFACE_SPLINE_INTERPOLATOR		
		local
					x, y, x1, y1, x2, y2, g: BASIC_VECTOR;
			f, f1: BASIC_MATRIX;
			i, j: INTEGER;		
		do
			print_nl ("Testing SURFACE_SPLINE_INTERPOLATOR (e01dac)");
			create x.make_real_from_array (
				<<1.00, 1.10, 1.30, 1.50, 1.60, 1.80, 2.00>>);
			create y.make_real_from_array (
				<<0.00, 0.10, 0.40, 0.70, 0.90, 1.00>>);

			-- transposed data
			create f.make_real_from_array (
				<<  1.00, 1.10, 1.40, 1.70, 1.90, 2.00,
					1.21, 1.31, 1.61, 1.91, 2.11, 2.21,
					1.69, 1.79, 2.09, 2.39, 2.59, 2.69,
					2.25, 2.35, 2.65, 2.95, 3.15, 3.25,
					2.56, 2.66, 2.96, 3.26, 3.46, 3.56,
					3.24, 3.34, 3.64, 3.94, 4.14, 4.24,
					4.00, 4.10, 4.40, 4.70, 4.90, 5.00 >>, 7, 6);

			create interpolator.make (x, y, f);
			printv ("Knots_x", interpolator.knots_x);
			printv ("Knots_y", interpolator.knots_y);
			printv ("B-spline coefficients", interpolator.coefficients);
			
			create x1.make_real_from_array (
				<<1.0, 1.2, 1.4, 1.6, 1.8, 2.0>>);
			create y1.make_real_from_array (
				<<0.0, 0.2, 0.4, 0.6, 0.8, 1.0>>);
		
			print_nl ("Computing 'values_on_grid' on test grid");
			printv("values_on_grid", interpolator.values_on_grid(x1, y1));
	
			create x1.make_real_from_array (<<1.0, 1.2, 1.4, 1.6, 1.8, 2.0>>);
			create y1.make_real_from_array (<<0.0, 0.2, 0.4, 0.6, 0.8, 1.0>>);
			printv("x1", x1);
			printv("y1", y1);
			printv("values_at_points(x1, y1)", interpolator.values_at_points (x1, y1));
			print_nl ("End of tests for SURFACE_SPLINE_INTERPOLATOR class");
	end;

feature -- Access

	interpolator: SURFACE_SPLINE_INTERPOLATOR;
			-- Object tested
			
end -- class SURFACE_SPLINE_INTERPOLATOR_TEST

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

