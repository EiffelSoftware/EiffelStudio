indexing
	description: " Test routines for d02";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TEST_ODE_SOLVERS

inherit
	EIFFELMATH_TESTING_FRAMEWORK
		
	MATHEMATICIAN
		undefine
			print
		end

create

	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
			-- Test of various routines from d02.
		do
			print ("Machine precision is ");
			print (machine_precision);
			print_nl ("");
			--test_rhs;
			test_adams;
			test_stiff1;
			test_stiff2;
			test_rk_range;
			test_rk_one_step;
		end;

feature -- Access

	y1: ARRAY [DOUBLE];
			-- Initial value of dependent variable in ODE.

feature -- Basic operations

	test_rhs is
			-- Test the functions. 
		local
			d2: DOUBLE;
			y2: ARRAY [DOUBLE];
			j2: BASIC_MATRIX;
			testf: EXAMPLE_PLAIN_ODE;
			tests: EXAMPLE_STIFF_ODE;
		do
			print ("For EXAMPLE_PLAIN_ODE...%N");
			create testf;
			y1 := <<0.5, 0.5, Pi / 5.0>>;
			print ("Result of normal call to rhs: %N");
			y2 := testf.rhs (0.0, y1);
			print (y2.tagged_out);	

			print ("Result of normal call to root: %N");
			d2 := testf.g (0.0, y1);
			print (d2); 
			print_nl ("");
	
			print ("Result of normal call to output: %N");
			testf.output (0.0, y1);
			print (d2); 
			print_nl ("");

			print ("For EXAMPLE_STIFF_ODE...%N");
			create tests;
			y1 := <<1.0, 0.001, 0.0001>>;
			print ("Result of normal call to rhs: %N");
			y2 := tests.rhs (0.0, y1);
			print (y2.tagged_out);	

			print ("Result of normal call to root: %N");
			d2 := tests.g (0.0, y1);
			print (d2); 
			print_nl ("");

			print ("Result of normal call to Jacobian: %N");
			j2 := tests.jacobian(0.0, y1);
			print (j2.tagged_out);
	
			print ("Result of normal call to output: %N");
			tests.output (0.0, y1);
			print (d2); 
			print_nl ("");
		end;

	test_adams is
			-- Check out ODE Solver.
			-- See example in section 8.3 of NAG Manual d02cjc.
		local
			g: STANDARD_ADAMS_ODE_SOLVER;
			testf: EXAMPLE_PLAIN_ODE;
		do
			print("Beginning Adams solver root test.%N");
			create testf;
			y1 := <<0.5, 0.5, Pi / 5.0>>;
			create g.make (0.0, 10.0, y1);
			g.set_target (testf);
			g.set_tolerance (0.0001);
			g.set_output_times (<<0., 2., 4., 6., 8.>>);
			g.find_root;
			g.proceed (g.xfinal);
			g.output (g.x, g.y);
			print("Should have found a root near 7.288%N");
			print_nl ("");

			print("Beginning Adams solver no root test.%N");
			y1 := <<0.5, 0.5, Pi / 5.0>>;
			create g.make (0.0, 10.0, y1);
			g.set_target (testf);
			g.set_tolerance (0.0001);
			g.set_output_times (<<0., 2., 4., 6., 8.>>);
			g.ignore_root;
			g.proceed (g.xfinal);
			g.output (g.x, g.y);
			print("Should have proceeded to 10.0%N");
			print_nl ("");
		end;

	test_stiff1 is
			-- Check out Stiff ODE Solver.
			-- See example in section 8.3 of NAG Manual d02cjc.
		local
			g: STANDARD_STIFF_ODE_SOLVER;
			testf: EXAMPLE_PLAIN_ODE;
		do
			print("Beginning stiff solver non-stiff system test.%N");
			create testf;
			y1 := <<0.5, 0.5, Pi / 5.0>>;
			create g.make (0.0, 10., y1);
			g.set_target (testf);
			g.set_tolerance (0.0001);
			g.set_output_times (<<0., 2., 4., 6., 8.>>);
			g.find_root;
			g.do_not_use_jacobian;
			g.proceed (g.xfinal);
			g.output (g.x, g.y);
			print("Should have found a root near 7.288%N");
			print_nl ("");

			print("Beginning no root stiff solver non-stiff system test.%N");
			y1 := <<0.5, 0.5, Pi / 5.0>>;
			create g.make (0.0, 10.0, y1);
			g.set_target (testf);
			g.set_tolerance (0.0001);
			g.set_output_times (<<0., 2., 4., 6., 8.>>);
			g.ignore_root;
			g.do_not_use_jacobian;
			g.proceed (g.xfinal);
			g.output (g.x, g.y);
			print("Should have proceeded to 10.0%N");
			print_nl ("");
		end;

	test_stiff2 is
			-- Check out Stiff ODE Solver on a stiff problem.
			-- See example in NAG Manual d02ejc.
		local
			g: STANDARD_STIFF_ODE_SOLVER;
			stiff: EXAMPLE_STIFF_ODE;
		do
			print("Beginning stiff solver stiff system test.%N");
			create stiff;
			y1 := <<1.0, 0.0, 0.0>>;
			create g.make (0.0, 10.0, y1);
			g.set_target (stiff);
			g.set_tolerance (0.0001);
			g.relative_tolerance;
			g.set_output_times (<<0., 1., 2., 3., 4., 6., 8.>>);
			g.find_root;
			g.do_not_use_jacobian;
			g.proceed (g.xfinal);
			g.output (g.x, g.y);
			print("Should have found y(1)=0.9 near 4.377%N");
			print_nl ("");

			print("...and with jacobian...%N");
			create stiff;
			y1 := <<1.0, 0.0, 0.0>>;
			create g.make (0.0, 10.0, y1);
			g.set_target (stiff);
			g.set_tolerance (0.0001);
			g.relative_tolerance;
			g.set_output_times (<<0., 1., 2., 3., 4., 6., 8.>>);
			g.find_root;
			g.use_jacobian;
			g.proceed (g.xfinal);
			g.output (g.x, g.y);
			print("Should have found y(1)=0.9 near 4.377%N");
			print_nl ("");
		end;

	test_rk_range is
			-- Check out Range_RK_ODE Solver.
			-- See example in section 8.3 of NAG Manual d02cjc.
		local
			g: STANDARD_RANGE_RUNGE_KUTTA_ODE_SOLVER;
			testf: EXAMPLE_RK_ODE;
			i: INTEGER;
			xout: DOUBLE;
		do
			print("Beginning RK range test.%N");
			create testf;
			y1 := <<0.0, 1.0>>;
			create g.make (0.0, 2.0 * Pi, y1);
			g.set_target (testf);
			g.set_tolerance (0.0001);
			g.set_all_thresholds (1.0e-8);
			g.set_method_order (3);
			g.output(g.x, g.y);
			from i := 1 until i > 8 loop
				xout := g.xfinal - (8 - i)*(Pi/4.0);
				g.proceed(xout);
				g.output(g.x, g.y);
				i := i + 1
			end;
			print("Last should be 6.283 0.0 1.0%N");
			print_nl ("");
		end;

	test_rk_one_step is
			-- Check out Range_RK_ODE Solver.
			-- See example in section 8.3 of NAG Manual d02cjc.
		local
			g: STANDARD_ONE_STEP_RUNGE_KUTTA_ODE_SOLVER;
			testf: EXAMPLE_RK_ODE;
			y8: ARRAY [DOUBLE];
			y8p: ARRAY [DOUBLE];
			y8c: ARRAY [DOUBLE];
			i: INTEGER;
		do
			print("Beginning RK one_step test.%N");
			create testf;
			y1 := <<0.0, 1.0>>;
			create g.make (0.0, 2.0*Pi, y1);
			g.set_target (testf);
			g.set_tolerance (0.0001);
			g.set_all_thresholds (1.0e-8);
			g.set_method_order (5);
			g.proceed (Pi);
			g.output(g.x, g.y);
			print("Should have gone to Pi so far.%N");
			from
			until
				g.x >= g.xfinal
			loop
				g.proceed_one_step;
				g.output(g.x, g.y)
			end;
			y8 := g.interp_y(2.0*pi, 2);
			y8p := g.interp_dydx(2.0*pi, 2);
			y8c := testf.rhs(2.0*pi, y8);
			from i := 1 until i > 2 loop
				print(" At 2pi y(");print(i);print(") = ");
				print(y8 @ i); print(", yp "); 
				print(y8p @ i); print(" should resemble ");
				print(y8c @ i); print("%N");
				i := i + 1
			end;
			print_nl ("");
		end;

end -- class TEST_ODE_SOLVERS

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

