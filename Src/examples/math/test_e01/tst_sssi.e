indexing
	description: "Tester of Surface Spline Interpolator class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	SCATTERED_SURFACE_INTERPOLATOR_TEST

inherit

	EIFFELMATH_TESTING_FRAMEWORK

creation

	make 


feature -- Initialization

	make is
			-- Test of  SCATTERED_SURFACE_INTERPOLATOR.	
		local
			x, y, x1, y1, f: BASIC_VECTOR;
			i, j, m: INTEGER;
			method: NAG_SCATTERED_SURFACE_INTERPOLATION_METHOD
			input: PLAIN_TEXT_FILE;
			title: STRING;
		do
			!! input.make_open_read("e01sace.d")
			input.readline;
			title := deep_clone(input.last_string)
			input.read_integer;
			m := input.last_integer;
			!! x.make_real (m);
			!! y.make_real (m);
			!! f.make_real (m);
			from i := 1 until i > m loop
				input.read_real
				x.put_real (input.last_real, i);
				input.read_real
				y.put_real (input.last_real, i);
				input.read_real
				f.put_real (input.last_real, i);
				i := i + 1
			end;
			input.close;
			print_nl (title);
			printv ("x", x);
			printv ("y", y);
			printv ("f", f);
			!! method;
			!! x1.make_real_from_array (
				<<3.0, 6.0, 9.0, 12.0, 15.0, 18.0, 21.0>>);
			!! y1.make_real_from_array (
				<<2.0, 5.0, 8.0, 11.0, 14.0, 17.0>>);
		
			print_nl (method.method_name);
			!! interpolator.make (x, y, f, method);
			printv("values_on_grid", interpolator.values_on_grid(x1, y1));
	
			method.set_radii_estimators (12, 24);
			interpolator.make (x, y, f, method);
			printv ("rnw_used", interpolator.rnw_used);
			printv ("rnq_used", interpolator.rnq_used);
			printv ("minnq", interpolator.minnq);
			printv("values_on_grid", interpolator.values_on_grid(x1, y1));

			print_nl ("End of tests for SCATTERED_SURFACE_INTERPOLATOR class");
	end;


feature -- Access

	interpolator: SCATTERED_SURFACE_INTERPOLATOR;
			-- Object tested
			
end -- class SCATTERED_SURFACE_INTERPOLATOR_TEST

--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for numerical
--| computation ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
