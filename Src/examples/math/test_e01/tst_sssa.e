indexing
	description: "Tester of Surface Spline Interpolator class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	SCATTERED_SURFACE_SPLINE_APPROXIMATOR_TEST

inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make 


feature -- Initialization

	make is
			-- Test of  SCATTERED_SURFACE_SPLINE_APPROXIMATOR		
		local
			x, y, x1, y1, f, w: BASIC_VECTOR;
			i, j, m: INTEGER;
			input: PLAIN_TEXT_FILE;
			title: STRING;
			s: DOUBLE;
		do
			create input.make_open_read("e02ddce.d")
			input.readline;
			title := deep_clone(input.last_string)
			input.read_integer;
			m := input.last_integer;
			create x.make_real (m);
			create y.make_real (m);
			create f.make_real (m);
			create w.make_real (m);
			from i := 1 until i > m loop
				input.read_real
				x.put_real (input.last_real, i);
				input.read_real
				y.put_real (input.last_real, i);
				input.read_real
				f.put_real (input.last_real, i);
				input.read_real
				w.put_real (input.last_real, i);
				i := i + 1
			end;
			input.read_real;
			s := input.last_real;
			input.close;
			print_nl (title);
			printv ("x", x);
			printv ("y", y);
			printv ("f", f);
			printv ("w", w);
			printv ("s", s);

			create x1.make_real_from_array (
				<<3.0, 6.0, 9.0, 12.0, 15.0, 18.0, 21.0>>);
			create y1.make_real_from_array (
				<<2.0, 5.0, 8.0, 11.0, 14.0, 17.0>>);
		
			create approximator.make (x, y, f, w, s, 14, 14);
			printv ("rank", approximator.rank);
			printv ("closeness", approximator.closeness)
			printv ("values_on_grid", approximator.values_on_grid(x1, y1));

			approximator.set_smoothness (.90 * approximator.smoothness);
			printv ("rank", approximator.rank);
			printv ("closeness", approximator.closeness)
			printv("values_on_grid", approximator.values_on_grid(x1, y1));

			print_nl ("End of tests for SCATTERED_SURFACE_SPLINE_APPROXIMATOR class");

	end;

feature -- Access

	approximator: SCATTERED_SURFACE_SPLINE_APPROXIMATOR;
			-- Object tested
			
end -- class SCATTERED_SURFACE_APPROXIMATOR_TEST

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
