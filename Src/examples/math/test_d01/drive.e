indexing
	description: " Test routines for d01"
class
	TEST_INTEGRATORS
	
inherit
	EIFFELMATH_TESTING_FRAMEWORK
	MATHEMATICIAN
		undefine
			print
		end
	NAG_EXCEPTIONS
		undefine
			print
		end

	NAG_ERROR_NUMBERS
		undefine
			print
		end


create
	make

feature -- Status report

	testf: EXAMPLE_INTEGRANDS;

	goof: INTEGER;

	verbose: BOOLEAN is True;
		-- Make this False for a quieter test.

	epsilon: DOUBLE is .01;

	r (name: STRING; d1, d2: DOUBLE) is
			-- test results
		require
			d1 /= 0.
		do
			if dabs((d1-d2)/d2) > epsilon then
				print(name);
				print(" ");
				print(d1);
				print(" <- should be ");
				print_nl(d2);
				goof := goof + 1
			end;
		end;

feature -- Initialization

	make is
			-- test of various routines from d01
		do
			create testf;
	 
	 		test_gl;
	 		test_gm;
	 		test_gg;
	 		test_gr;
	 		test_gh;

 			test_ajc;
 			test_akc;
 			test_alc;
 			test_amc;
 			test_amc2;
 			test_asc;
 			test_anc;
 			test_apc;
 			test_aqc;
 			test_fcc;
			test_gbc;
			test_gbc_continuation;
	 		test_poly;
	 		test_gen;
			print(goof); 
			print (" errors. Tests completed.%N")
		end;

feature -- Basic operations

	test_gl is
			-- test for Gauss Legendre Integrator
		local
			gl_integrator: FINITE_FIXED_INTEGRATOR;
			ef_testf: EIFFEL_FUNCTION;
		do
			-- The harder interface:
	 		-- create an EIFFEL_FUNCTION for passing to the integrator.
			create ef_testf;
			ef_testf.set_target (testf) ;
			ef_testf.set_by_name ("EXAMPLE_INTEGRANDS", "f2") ;

			create gl_integrator.make;
			gl_integrator.set_abscissae_count(7);
			gl_integrator.set_integration_limits (0., 1);
			gl_integrator.set_integrand (ef_testf);
			gl_integrator.integrate;

			r ("testgl/f2 #1", gl_integrator.integral, 1./3.);

			create gl_integrator.make;
			gl_integrator.make_integrand(testf, "f2");
			gl_integrator.set_abscissae_count(7);
			gl_integrator.set_integration_limits (0., 1);
			gl_integrator.integrate;
			r ("testgl/f2 #1", gl_integrator.integral, 1./3.);
			
			if verbose then print ("testgl done.%N") end;
		end;

	test_gm is
			-- test of discrete integration
		local
			i: INTEGER;
			d, d2: DOUBLE;
			gm_integrator: GENERAL_DISCRETE_INTEGRATOR;
			-- An integrator for a function defined by arrays of points.

			x_in, y_in: ARRAY [DOUBLE]
			-- The arrays of points to define a function.
		do
			create x_in.make (1, 10);
			create y_in.make (1, 10);
			from i :=1 until i > 10 loop
				d := (i-1.)/9.;
				d2 := d * d;
				x_in.put (d, i);
				y_in.put (d2, i);
				i := i + 1
			end;
			create gm_integrator.make (x_in, y_in);

			gm_integrator.integrate;
			r ("test_gm", gm_integrator.integral, 1./3.);
			if verbose then print ("testgm done.%N") end;
		end;


	test_gg is
			-- test for Gauss Laguerre Integrator
		local			
			gg_integrator: SEMI_INFINITE_FIXED_INTEGRATOR;
			-- An integrator for a function over a semi-infinite interval.
		do
			create gg_integrator.make;
			gg_integrator.set_abscissae_count (7);
			gg_integrator.set_integration_limit (2.);
			gg_integrator.set_decay_rate (1.);
			gg_integrator.make_integrand (testf, "fun3");
			gg_integrator.integrate;
			r ("test_gg", gg_integrator.integral, 0.0489);
			if verbose then print ("test_gg done.%N") end;
		end;

	test_gr is
			-- test for Gauss Rational Integrator
		local
			gr_integrator: RATIONAL_SEMI_INFINITE_FIXED_INTEGRATOR;
			-- An integrator for a rational function on a semi-infinite interval
		do
			create gr_integrator.make;
			gr_integrator.set_abscissae_count (7);
			gr_integrator.set_integration_limit (2.);
			gr_integrator.set_decay_rate (0.);
			gr_integrator.make_integrand(testf, "fun2");
			gr_integrator.integrate;

			r ("test_gr", gr_integrator.integral, 0.3786);
			if verbose then print ("test_gr done.%N") end;
		end;

	test_gh is
			-- test for Gauss HERMITE Integrator
		local
			gh_integrator: INFINITE_FIXED_INTEGRATOR;
			-- Integrator for functions on (-Infinity, Infinity).
		do
			create gh_integrator.make;
			gh_integrator.set_abscissae_count(7);
			gh_integrator.make_integrand (testf, "fun4");
			gh_integrator.set_decay_rate(3.);
			gh_integrator.set_center_point(-1.);

			gh_integrator.integrate;

			r ("test_gh", gh_integrator.integral, 1.4283);
			if verbose then print ("test_gh done.%N") end
		end;

	test_ajc is
			-- test for adaptive integrator on a finite interval.
		local
		 	ajc_integrator: FINITE_ADAPTIVE_INTEGRATOR;
		do
			create ajc_integrator.make;
			ajc_integrator.make_integrand (testf, "f2");
			ajc_integrator.set_integration_limits (0., 1.);
			ajc_integrator.integrate;

			r ("test_ajc", ajc_integrator.integral, 1./3.);
			if verbose then
				print("test_ajc optional output...%N");
				print ("Integral: ") ;
				print (ajc_integrator.integral);
				print_nl ("");
				print ("Function calls: ");
				print (ajc_integrator.evaluation_count);
				print_nl ("");
				print ("Number of intervals used: ");
				print (ajc_integrator.intervals_used);
				print_nl ("");
				print ("Estimate of error: ");
				print (ajc_integrator.absolute_error);
				print_nl ("");
				print ("End of first interval: ");
				print (ajc_integrator.diagnostics.sub_int_end_pts (1));
				print_nl ("");
				print ("Result on first interval: ");
				print (ajc_integrator.diagnostics.interval_result (1));
				print_nl ("");
			end;
			if verbose then print("test_ajc done.%N") end
		end;

	test_akc is
			-- test for oscillating integrator on a finite interval.
		local
		 	akc_integrator: FINITE_ADAPTIVE_INTEGRATOR;
		do
			create akc_integrator.make;
			akc_integrator.make_integrand (testf, "oscillator");
			akc_integrator.set_integration_limits (0.0, 2.0 * Pi);
			akc_integrator.set_absolute_tolerance(0.0);
			akc_integrator.set_relative_tolerance(1.0e-3);

			akc_integrator.integrate_oscillating;
			r ("test_akc", akc_integrator.integral, -0.20967)
			if verbose then print("test_akc done.%N") end
		end;

	test_alc is
			-- test for breakpoints integrator on a finite interval.
		local
		 	alc_integrator: FINITE_ADAPTIVE_INTEGRATOR;
		do
			create alc_integrator.make;
			alc_integrator.make_integrand (testf, "difficult_at_one_seventh");
			alc_integrator.set_integration_limits (0.0, 1.0);
			alc_integrator.set_absolute_tolerance(0.0);
			alc_integrator.set_relative_tolerance(1.0e-3);

			alc_integrator.integrate_with_breakpoints (<<1.0/7.0>>);
			r ("test_alc", alc_integrator.integral, 2.60757);
			if verbose then print("test_akc done.%N") end
		end;

	test_amc is
			-- test for SEMI_INFINITE adaptive Integrator
		local
		 	amc_integrator: SEMI_INFINITE_ADAPTIVE_INTEGRATOR;
		do
			create amc_integrator.make;
			amc_integrator.make_integrand (testf, "fun5");
			amc_integrator.set_integration_limit (.0001);

			amc_integrator.upper_semi_infinite
			amc_integrator.integrate;

			r("test_amc", amc_integrator.integral, Pi);
			if verbose then
				print("test_amc optional output...%N")
				print("Integral: ");
				print(amc_integrator.integral);
				print_nl ("");
				print ("Function calls: ");
				print (amc_integrator.evaluation_count);
				print_nl ("");
				print ("Number of intervals used: ");
				print (amc_integrator.intervals_used);
				print_nl ("");
				print ("Estimate of error: ");
				print (amc_integrator.absolute_error);
				print_nl ("");
				print ("End of first interval: ");
				print (amc_integrator.diagnostics.sub_int_end_pts (1));
				print_nl ("");
				print ("Result on first interval: ");
				print (amc_integrator.diagnostics.interval_result (1));
				print_nl ("");
			end;
			if verbose then print("test_amc done.%N") end;
		end;


	test_amc2 is
			-- Test for adaptive integration on infinite region.
		local		
			amc2_integrator: INFINITE_ADAPTIVE_INTEGRATOR;
		do
			create amc2_integrator.make;
			amc2_integrator.make_integrand (testf, "fun4");
			amc2_integrator.integrate;
			
			r("test_amc2", amc2_integrator.integral, 1.4283);
			if verbose then
				print ("test_amc2 optional output...%N");
				print ("Integral: ") ;
				print (amc2_integrator.integral);
				print_nl ("");
				print ("Function calls: ");
				print (amc2_integrator.evaluation_count);
				print_nl ("");
				print ("Number of intervals used: ");
				print (amc2_integrator.intervals_used);
				print_nl ("");
				print ("Estimate of error: ");
				print (amc2_integrator.absolute_error);
				print_nl ("");
				print ("End of first interval: ");
				print (amc2_integrator.diagnostics.sub_int_end_pts (1));
				print_nl ("");
				print ("Result on first interval: ");
				print (amc2_integrator.diagnostics.interval_result (1));
				print_nl ("");
			end
			if verbose then print("test_amc2 done.%N") end;
		end;

	test_asc is
			-- test for SEMI_INFINITE adaptive trig-weighted Integrator
		local
		 	asc_integrator: TRIG_WEIGHTED_SEMI_INFINITE_ADAPTIVE_INTEGRATOR;
		do
			create asc_integrator.make;
			asc_integrator.make_integrand (testf, "one_over_sqrt_x");
			asc_integrator.set_integration_limit (0.);
			asc_integrator.set_absolute_tolerance (.001);
			asc_integrator.set_maximum_intervals (50);
			asc_integrator.set_maximum_subintervals (500);

			asc_integrator.use_cosine_weighting (Pi/2.0);
			asc_integrator.integrate;
			r ("test_asc", asc_integrator.integral, 1.0);
			if verbose then
				print ("test_asc optional output...%N");
				print ("Integral: ");
				print (asc_integrator.integral);
				print_nl ("");
				print ("Function calls: ");
				print (asc_integrator.evaluation_count);
				print_nl ("");
				print ("Number of intervals used: ");
				print (asc_integrator.intervals_used);
				print_nl ("");
				print ("Estimate of error: ");
				print (asc_integrator.absolute_error);
				print_nl ("");
				print ("Result on first interval: ");
				print (asc_integrator.diagnostics.interval_result (1));
				print_nl ("");
				print ("Error on first interval: ");
				print (asc_integrator.diagnostics.interval_error (1));
				print_nl ("");
				print ("Error flag on first interval: ");
				print (asc_integrator.diagnostics.interval_flag (1));
				print_nl ("");
				print ("End of first interval: ");
				print (asc_integrator.diagnostics.sub_int_end_pts (1));
				print_nl ("");
			end;
			if verbose then print("test_asc done.%N") end;
		end;

	test_anc is
			-- test for trig weighted integrator on a finite interval.
		local
		 	anc_integrator: FINITE_ADAPTIVE_INTEGRATOR;
		do
			create anc_integrator.make;
			anc_integrator.make_integrand (testf, "careful_log");
			anc_integrator.set_integration_limits (0.0, 1.0);
			anc_integrator.set_absolute_tolerance(0.0);
			anc_integrator.set_relative_tolerance(1.0e-4);

			anc_integrator.integrate_sine_weighted (10.0 * Pi);
			r ("test_anc", anc_integrator.integral, -0.12814);
			if verbose then print("test_anc done.%N") end;
		end;

	test_apc is
			-- test for algebraic-weighted integrator on a finite interval.
		local
		 	apc_integrator: FINITE_ADAPTIVE_INTEGRATOR;
		do
			create apc_integrator.make;
			apc_integrator.make_integrand (testf, "f_cos");
			apc_integrator.set_integration_limits (0.0, 1.0);
			apc_integrator.set_absolute_tolerance(0.0);
			apc_integrator.set_relative_tolerance(1.0e-4);

			apc_integrator.integrate_alg_weighted (0.0, 0.0, 2);
			r ("test_apc(1)", apc_integrator.integral, -0.04899);

			apc_integrator.make_integrand (testf, "f_sin");
			apc_integrator.set_integration_limits (0.0, 1.0);
			apc_integrator.set_absolute_tolerance(0.0);
			apc_integrator.set_relative_tolerance(1.0e-4);

			apc_integrator.integrate_alg_weighted (-0.5, -0.5, 1);
			r ("test_apc(2)", apc_integrator.integral, 0.53502);
			if verbose then print("test_apc done.%N") end;
		end;

	test_aqc is
			-- test for Cauchy-weighted integrator on a finite interval.
		local
		 	aqc_integrator: FINITE_ADAPTIVE_INTEGRATOR;
		do
			create aqc_integrator.make;
			aqc_integrator.make_integrand (testf, "g");
			aqc_integrator.set_integration_limits (-1.0, 1.0);
			aqc_integrator.set_absolute_tolerance(0.0);
			aqc_integrator.set_relative_tolerance(1.0e-4);

			aqc_integrator.integrate_cauchy_weighted (0.5);
			r("test_aqc", aqc_integrator.integral, -628.46);
			if verbose then print("test_aqc done.%N") end;
		end;

 	test_fcc is
			-- test for d01ffc adaptive multi-integrator.
		local
			a, b: ARRAY [DOUBLE]; -- integration limits.
			j: INTEGER;
		 	fcc_integrator: GENERAL_ADAPTIVE_FUNCTIONAL_INTEGRATOR;
		do
			create a.make(1,4);
			create b.make(1,4);
			from j := 1 until j > 4 loop
				a.put(0.0, j);
				b.put(1.0, j);
				j := j + 1
			end;

			create fcc_integrator.make;
			fcc_integrator.make_integrand (testf, "functional1");

			fcc_integrator.set_integration_limits (a, b);
			fcc_integrator.set_relative_tolerance (.0001);
			fcc_integrator.set_minimum_evaluations (0);
			fcc_integrator.set_maximum_evaluations (b.count *1000);
			fcc_integrator.integrate;

			r("test_fcc", fcc_integrator.integral, 0.575364);
			if verbose then
				print ("test_fcc optional output...%N");
				print ("Estimate of error: ");
				print (fcc_integrator.absolute_error);
				print_nl ("");
			end;
			if verbose then print("test_fcc done.%N") end;
		end;

	test_gbc is
			-- test for d01gbc adaptive multi-integrator.
		local
			a, b: ARRAY [DOUBLE]; -- integration limits.
			j: INTEGER;
		 	gbc_integrator: MONTE_CARLO_FUNCTIONAL_INTEGRATOR;
		do
			create a.make(1,4);
			create b.make(1,4);
			from j := 1 until j > 4 loop
				a.put(0.0, j);
				b.put(1.0, j);
				j := j + 1
			end;

			create gbc_integrator.make_non_repeatable;
			gbc_integrator.make_integrand (testf, "functional1");

			gbc_integrator.set_integration_limits (a, b);
			gbc_integrator.set_relative_tolerance (.01);
			gbc_integrator.set_minimum_evaluations (1000);
			gbc_integrator.set_maximum_evaluations (20000);
			gbc_integrator.integrate;

			r ("test_gbc", gbc_integrator.integral, 0.575364);
			if verbose then
				print ("test_gbc optional output...%N");
				print ("Number of evaluations: ");
				print (gbc_integrator.evaluation_count);
				print_nl ("");
				print ("Estimate of error: ");
				print (gbc_integrator.absolute_error);
				print_nl ("");
			end;
		end;

	test_gbc_continuation is
			-- Test of hot start monte carlo
		local
			a, b: ARRAY [DOUBLE]; -- integration limits.
			j, total_calls: INTEGER;
		 	gbc_integrator: MONTE_CARLO_FUNCTIONAL_INTEGRATOR;
			iters: INTEGER;
		do
			create a.make(1,4);
			create b.make(1,4);
			from j := 1 until j > 4 loop
				a.put(0.0, j);
				b.put(1.0, j);
				j := j + 1
			end;

			create gbc_integrator.make_repeatable (0);
			gbc_integrator.make_integrand (testf, "functional1");

			gbc_integrator.set_integration_limits (a, b);
			gbc_integrator.set_relative_tolerance (.01);
			gbc_integrator.set_minimum_evaluations (1000);
			gbc_integrator.set_maximum_evaluations (3000);
			from
				iters := 1
				nag_ignore_errors;
				nag_enable_error_printing;
				gbc_integrator.integrate
			until 
				iters > 10 
			loop
				total_calls := total_calls + 
					gbc_integrator.evaluation_count
				print ("Estimate: ");
				print (gbc_integrator.integral);
				print_nl ("");
				print ("Number of evaluations: ");
				print (gbc_integrator.evaluation_count);
				print_nl ("");
				print ("Estimate of error: ");
				print (gbc_integrator.absolute_error);
				print_nl ("");
				if nag_failed and iters < 10 then
					gbc_integrator.integrate
				else
					iters := 10
				end;
				iters := iters + 1
			end;
			r ("test_gbc_continuation", gbc_integrator.integral, 0.575364);
			print ("Total number of evaluations: ");
			print (total_calls);
			print_nl ("");
			
			nag_do_not_ignore_errors;
			nag_disable_error_printing
		end;

	test_poly is
			-- polymorphism test
		local
			gl_integrator: FINITE_FIXED_INTEGRATOR;
			p1: EXAMPLE_INTEGRAND_POLY;
			p2: EXAMPLE_INTEGRAND_MOLY;
			p3: EXAMPLE_INTEGRAND_FOLY;
		do
			create p1.make;
			create p2;
			create p3;
			create gl_integrator.make;

			gl_integrator.make_integrand(p1, "f1");
			gl_integrator.set_target(p2);
			gl_integrator.set_abscissae_count(7);
			gl_integrator.set_integration_limits (0., 1.);
			gl_integrator.integrate;
			r ("test_poly(POLY)", gl_integrator.integral, 1.0);
 
			p1 := p2
			gl_integrator.make_integrand(p1, "f1");
			gl_integrator.integrate;
			r ("test_poly(MOLY)", gl_integrator.integral, 1.5);

			gl_integrator.make_integrand_by_key("f1");
			gl_integrator.set_target(p3);
			gl_integrator.integrate;
			r ("test_poly(FOLY)", gl_integrator.integral, 2.0);
			if verbose then print("test_poly done.%N") end;
		end;

	test_gen is
			-- test for adaptive integrator on a finite interval.
		local
		 	gen_integrator: GENERAL_ADAPTIVE_INTEGRATOR;
		do
			create gen_integrator.make;
			gen_integrator.make_integrand (testf, "f2");
			gen_integrator.set_integration_limits (0., 1.);
			gen_integrator.integrate;

			r ("test_gen(1)", gen_integrator.integral, 1./3.);
			if verbose then
				print("test_gen optional output...%N");
				print ("Integral: ") ;
				print (gen_integrator.integral);
				print_nl ("");
				print ("Function calls: ");
				print (gen_integrator.evaluation_count);
				print_nl ("");
				print ("Number of intervals used: ");
				print (gen_integrator.intervals_used);
				print_nl ("");
				print ("Estimate of error: ");
				print (gen_integrator.absolute_error);
				print_nl ("");
				print ("Result on first interval: ");
				print (gen_integrator.diagnostics.interval_result (1));
				print_nl ("");
				print ("Error on first interval: ");
				print (gen_integrator.diagnostics.interval_error (1));
				print_nl ("");
			end;
			gen_integrator.make_integrand (testf, "fun5");
			gen_integrator.set_integration_limits (Infinity, .0001);
			gen_integrator.integrate;
			r("test_gen(2)", gen_integrator.integral, -Pi);

			gen_integrator.make_integrand (testf, "fun4");
			gen_integrator.set_integration_limits (-Infinity, Infinity);
			gen_integrator.integrate;
			r("test_gen(3)", gen_integrator.integral, 1.4283);

			if verbose then print("test_gen done.%N") end
		end;

end -- class TEST_INTEGRATORS

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

