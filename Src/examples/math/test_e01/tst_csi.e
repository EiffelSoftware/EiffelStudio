indexing
	description: "Tester of Curve Spline Interpolator class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	CURVE_SPLINE_INTERPOLATOR_TEST

inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make 


feature -- Initialization

	make is
			-- Test of CURVE_SPLINE_INTERPOLATOR		
		local		
			x, f, x1, d: BASIC_VECTOR;
			a: DOUBLE;
			i: INTEGER;		
		do
			create form.make(13, 4);
			create x.make_real_from_array (
				<<0.0, 0.2, 0.4, 0.6, 0.75, 0.9, 1.0>>);
			create f.make_real_from_array (
				<<1.0, 1.2214028, 1.4918247, 1.8221188, 2.1170, 2.4596031, 2.718218>>);
			print_nl ("Test of CURVE_SPLINE_INTERPOLATOR (eo1bac)")
			printv ("x", x)
			printv ("y", f)
			create interpolator.make (x, f);
			create x1.make_real_from_array (
			<<0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.675, 0.75, 0.825, 0.9, 0.95, 1.0>>);

			from
				i := 1;
			until
				i > x1.count
			loop
				a := x1.real_item(i);
				print ("At x = ")
				print (form.formatted (a));
				print (" value = ");
				print_nl (form.formatted (interpolator.value (a)));
				i := i + 1;
			end;
			print_nl ("Test of value_with_derivatives") 
			from
				i := 1;
			until
				i > x1.count
			loop
				a := x1.real_item(i);
				d := interpolator.value_with_derivatives (a);
				printv ("At x ", a);
				printv ("[y, y', y'', y''']", d);
				i := i + 1;
			end; 

			printv ("Integral (should be e -1.)", interpolator.integral);
			print_nl ("End of tests for CURVE_SPLINE_INTERPOLATOR class");
		end;

feature -- Access

	interpolator: CURVE_SPLINE_INTERPOLATOR;
			-- Object to test

	form: FORMAT_SCIENTIFIC
			-- Formatter of printouts

		
end -- class CURVE_SPLINE_INTERPOLATOR_TEST

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

