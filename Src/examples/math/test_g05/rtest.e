indexing
	description: "Test class for G05"

class
	TEST_RANDOM

inherit

	EIFFELMATH_TESTING_FRAMEWORK

	STATISTICIAN
		undefine
			print
		end

create

	make

feature

	size: INTEGER;
			-- an integer for setting with command args.

	expect (predicted, actual: DOUBLE) is
			-- Print a value with it's expected value.
		do
			print(predicted);
			print(": "); 
			print(actual); 
			print_nl ("");
		end;

	make (args: ARRAY [STRING]) is
			-- Test g05
		do
			size := 1000;
			if args.valid_index(1) then
				size := (args @ 1).to_integer
			end;
			test_statistician;
			test_distributions;
			test_simple_generators;
			test_normal;
			test_students_t;
			test_chi_squared;
			test_gamma;
			test_vector_generators;
			test_dealer;
			test_shuffler;
			test_arma;
		end;

	test_statistician is
			-- Test the functions in STATISTICIAN
		do
			print(statistics(<<1., 2. ,3., 3.1, 3.25, 4., 5.>>));
			print(weighted_statistics(<<1., 2., 3., 3.1, 3.25, 4., 5.>>,
				<<0., .25 ,.3 ,.1, .1, .25, 0.>>));
			expect(0.5, standard_normal_lower_tail_probability(0.));
			expect(1.6449, standard_normal_lower_tail_deviate(.95));
			expect(.7973, students_t_lower_tail_probability(.85, 20.));
			expect(.2027, students_t_upper_tail_probability(.85, 20.));
			expect(.4054, students_t_two_tail_significance_probability(.85, 20.));
			expect(.5946, students_t_two_tail_confidence_probability(.85, 20.));
			expect(-2.943, students_t_lower_tail_deviate(.01, 7.5));
			expect(-2.943, students_t_upper_tail_deviate(.99, 7.5));
			expect(2.690, students_t_two_tail_confidence_deviate(.99, 45.));
			expect(2.845, students_t_two_tail_significance_deviate(.01, 20.));
			expect(.4279, chi_squared_lower_tail_probability(6.2, 7.5));
			expect(1.0-.4279, chi_squared_upper_tail_probability(6.2, 7.5));
			expect(6.2, chi_squared_lower_tail_deviate(0.428, 7.5));
			expect(.9837, f_lower_tail_probability(5.5, 1.5, 25.5));
			expect(1.0 - .9837, f_upper_tail_probability(5.5, 1.5, 25.5));
			expect(2.5, f_lower_tail_deviate(0.534, 20.25, 1.));
			expect(.9499, gamma_lower_tail_probability(15.5, 4.0, 2.0));
			expect(1.0-.9499, gamma_upper_tail_probability(15.5, 4.0, 2.0));
			expect(.670, gamma_lower_tail_deviate(0.428, 7.5, .1, 0.0));
		end;

	test_gamma is
			-- Compare distribution with generator
		local
			nd: GAMMA_DISTRIBUTION;
			ng: GAMMA_GENERATOR;
			i, hit: INTEGER;
			d, d1: DOUBLE;
		do
			print("Gamma tail/generator comparison. Please wait.%N");
			create nd.make(4.0, 2.0);
			d1 := nd.lower_tail_deviate(.20);
			create ng.make_non_repeatable(4.0, 2.0);
			from 
				i := 1
			until 
				i > size
			loop
				d := ng.item; ng.forth;
				if d <= d1 then
					hit := hit + 1
				end;
				i := i + 1
			end;
			print("Expect .20 +/- error: ");
			d := (hit * 1.)/size;
			print(d);
			print("%N");
		end;

	test_chi_squared is
			-- Compare distribution with generator
		local
			nd: CHI_SQUARED_DISTRIBUTION;
			ng: CHI_SQUARED_GENERATOR;
			i, hit: INTEGER;
			d, d1: DOUBLE;
		do
			print("Chi-squared tail/generator comparison. Please wait.%N");
			create nd.make(7.5);
			d1 := nd.lower_tail_deviate(.20);
			create ng.make_non_repeatable(7.5);
			from 
				i := 1
			until 
				i > size
			loop
				d := ng.item; ng.forth;
				if d <= d1 then
					hit := hit + 1
				end;
				i := i + 1
			end;
			print("Expect .20 +/- error: ");
			d := (hit * 1.)/size;
			print(d);
			print("%N");
		end;

	test_students_t is
			-- Compare distribution with generator
		local
			nd: STUDENTS_T_DISTRIBUTION;
			ng: STUDENTS_T_GENERATOR;
			i, hit: INTEGER;
			d, d1: DOUBLE;
		do
			print("Student's t tail/generator comparison. Please wait.%N");
			create nd.make(7.5);
			d1 := nd.lower_tail_deviate(.20);
			create ng.make_non_repeatable(7.5);
			from 
				i := 1
			until 
				i > size
			loop
				d := ng.item; ng.forth;
				if d <= d1 then
					hit := hit + 1
				end;
				i := i + 1
			end;
			print("Expect .20 +/- error: ");
			d := (hit * 1.)/size;
			print(d);
			print("%N");
		end;

	test_normal is
			-- Compare distribution with generator
		local
			nd: NORMAL_DISTRIBUTION;
			ng: NORMAL_GENERATOR;
			i, hit: INTEGER;
			d, d1: DOUBLE;
		do
			print("Normal tail/generator comparison. Please wait.%N");
			create nd.make(2., 1.);
			d1 := nd.lower_tail_deviate(.20);
			create ng.make_non_repeatable(2., 1.);
			from 
				i := 1
			until 
				i > size
			loop
				d := ng.item; ng.forth;
				if d <= d1 then
					hit := hit + 1
				end;
				i := i + 1
			end;
			print("Expect .20 +/- error: ");
			d := (hit * 1.)/size;
			print(d);
			print("%N");
		end;

	test_distributions is
			-- Test the distribution functions.
		local
			t: STUDENTS_T_DISTRIBUTION;
			n: NORMAL_DISTRIBUTION;
			g: GAMMA_DISTRIBUTION;
			f: F_DISTRIBUTION;
			c: CHI_SQUARED_DISTRIBUTION;
			b: BETA_DISTRIBUTION;
			v: BIVARIATE_NORMAL_DISTRIBUTION;
		do
			print("Testing Student's T Distribution nu=20.%N");

			create t.make (20.0);

			print("Expect .7973 .4054 .5946 .2027%N");
			print(t.lower_tail_probability(0.85)); print(" ");
			print(t.two_tail_significance_probability(0.85)); print(" ");
			print(t.two_tail_confidence_probability(0.85)); print(" ");
			print(t.upper_tail_probability(0.85)); print("%N");

			print("Expect 2.845: ");
			print(t.two_tail_significance_deviate(0.01)); print("%N");
			print("Expect 0.85: ");
			print(t.lower_tail_deviate(.7973)); print(" ");
			print(t.two_tail_significance_deviate(0.4054)); print(" ");
			print(t.two_tail_confidence_deviate(0.5946)); print(" ");
			print(t.upper_tail_deviate(0.2027)); print("%N");

			print("Testing normal distribution (3., 2.)%N");
			create n.make(3., 2.);
			print ("Standard deviate at x=.95:");
			print (standard_normal_lower_tail_deviate (.95));
			print_nl ("");
			print ("Deviate at x=.95:");
			print (n.lower_tail_deviate (.95));
			print_nl ("");

			print("Testing chi-squared distribution (7.5)%N");
			create c.make(7.5);
			print ("Expect .4279: ");
			print (c.lower_tail_probability (6.2));
			print_nl ("");
			print ("Expect 6.2: ");
			print (c.lower_tail_deviate (.4279));
			print_nl ("");


			print("Testing F distribution (10.0, 25.5)%N");
			create f.make(10.0, 25.5);
			print ("Expect .984: ");
			print (f.lower_tail_probability (2.837));
			print_nl ("");
			print ("Expect 2.837: ");
			print (f.lower_tail_deviate (.984));
			print_nl ("");

			print("Testing Beta distribution (1., 2.)%N");
			create b.make(1., 2.);
			print ("Expect .4375: ");
			print (b.lower_tail_probability (0.25));
			print_nl ("");
			print ("Expect 0.25: ");
			print (b.lower_tail_deviate (.4375));
			print_nl ("");

			print("Testing Gamma distribution (7.5, .1)%N");
			create g.make(7.5, .1);
			print ("Expect .428: ");
			print (g.lower_tail_probability (.670));
			print_nl ("");
			print ("Expect 0.670: ");
			print (g.lower_tail_deviate (.428));
			print_nl ("");

			print("Testing Bivariate Normal distribution (.540)%N");
			create v.make(.540);
			print ("Expect .9995: ");
			print (v.lower_tail_probability (3.3, 11.1));
			print_nl ("");

		end;
		
	test_simple_generators is
			-- Test the random number generators.
		local
			x1, x2: DOUBLE;
			d1: CONTINUOUS_UNIFORM_GENERATOR;
			d2: CONTINUOUS_UNIFORM_GENERATOR_AB;
			d3: EXPONENTIAL_GENERATOR;
			d4: BETA_GENERATOR;
			d5, d6: NORMAL_GENERATOR;
			d7: GAMMA_GENERATOR;
			d8: CHI_SQUARED_GENERATOR;
			d9: STUDENTS_T_GENERATOR;
			d10: DISCRETE_UNIFORM_GENERATOR;
			d11: POISSON_GENERATOR;
			d12: BINOMIAL_GENERATOR;
		do
			print ("From a CUD%N");
			create d1.make_non_repeatable;
			d1.set_next_sample_size (4);
			d1.get_sample;
			next(d1);
			next(d1);
			next(d1);
			next(d1);
			next(d1);
			next(d1);

			print ("From a CUD_AB (2, 5)%N");
			create d2.make_repeatable (2., 5., 0);
			d2.set_next_sample_size (4);
			d2.get_sample;
			next(d2);
			next(d2);
			next(d2);
			next(d2);
			next(d2);
			next(d2);
			
			print ("From an EXPONENTIAL (2.0)%N");
			create d3.make_repeatable (2., 0);
			d3.set_next_sample_size (4);
			d3.get_sample;
			next(d3);
			next(d3);
			next(d3);
			next(d3);
			next(d3);
			next(d3);
			
			print ("From a Beta (2.0, 2.0)%N");
			create d4.make_repeatable (2., 2., 0);
			d4.set_next_sample_size (4);
			d4.get_sample;
			next(d4);
			next(d4);
			next(d4);
			next(d4);
			next(d4);
			next(d4);
			
			print ("From a normal distribution mean 3., sigma 2.%N");
			create d5.make_repeatable(3., 2., -1);
			d5.set_next_sample_size (4);
			d5.get_sample;
			next(d5);
			next(d5);
			next(d5);
			next(d5);
			next(d5);
			next(d5);
			print ("The next sample only is from normal(0.,1.)%N");
			create d6.make_non_repeatable(0., 1.);
			next(d6);
			next(d5);

			print ("From a GAMMA (5.0, 1.0)%N");
			create d7.make_repeatable (5., 1., 0);
			d7.set_next_sample_size (4);
			d7.get_sample;
			next(d7);
			next(d7);
			next(d7);
			next(d7);
			next(d7);
			next(d7);
	
			print ("From a Chi-square (4.0)%N");
			create d8.make_repeatable (4.0, 0);
			d8.set_next_sample_size (4);
			d8.get_sample;
			next(d8);
			next(d8);
			next(d8);
			next(d8);
			next(d8);
			next(d8);
	
			print ("From a Student's t (4.0)%N");
			create d9.make_repeatable (4.0, 0);
			d9.set_next_sample_size (4);
			d9.get_sample;
			next(d9);
			next(d9);
			next(d9);
			next(d9);
			next(d9);
			next(d9);
	
			print ("From a Discrete (2, 6)%N");
			create d10.make_repeatable (2, 6, 0);
			d10.set_next_sample_size (4);
			d10.get_sample;
			nexti(d10);
			nexti(d10);
			nexti(d10);
			nexti(d10);
			nexti(d10);
			nexti(d10);

			print ("From a Poisson (2.7)%N");
			create d11.make_repeatable (2.7, 0);
			d11.set_next_sample_size (2);
			d11.get_sample;
			nexti(d11);
			nexti(d11);
			nexti(d11);
			nexti(d11);
			nexti(d11);
			nexti(d11);

			print ("From a Binomial (100, 0.5)%N");
			create d12.make_repeatable (100, 0.5, 0);
			d12.set_next_sample_size (2);
			d12.get_sample;
			nexti(d12);
			nexti(d12);
			nexti(d12);
			nexti(d12);
			nexti(d12);
			nexti(d12);
		end;

	next (d: NAG_RANDOM_NUMBER_GENERATOR[DOUBLE]) is
		do
			print(d.item)
			print_nl ("");
			d.forth
		end;
		
	nexti (d: NAG_RANDOM_NUMBER_GENERATOR[INTEGER]) is
		do
			print(d.item)
			print_nl ("");
			d.forth
		end;
		
	nextv (d: NAG_RANDOM_NUMBER_GENERATOR[ARRAY [DOUBLE]]) is
		do
			print(d.item.tagged_out)
			print_nl ("");
			d.forth
		end;
		
	test_vector_generators is
			-- Test example from g05ezc
		local
			x: ARRAY [DOUBLE];
			y: BASIC_MATRIX;
			z: VECTOR_NORMAL_GENERATOR;
		do
			create x.make (1, 2);
			x.put (1., 1);
			x.put (2., 2);
			create y.make_real_from_array ( <<
				2.0, 1.0,
				1.0, 3.0
				>>, 2, 2);
			y.set_symmetricity (True);
			print("Testing vector normal generator.%N");
			create z.make_repeatable (x, y, .01, 0);
			nextv (z);
			nextv (z);
			nextv (z);
			nextv (z);
			nextv (z);
		end;

	test_dealer is
		local
			d: DEALER;
			j: ARRAY [INTEGER];
		do
			print("Testing deal of subsets from 2, 4, 6, 8, 9%N");
			j := <<2, 4, 6, 8, 9>>;
			create d.make_repeatable(j, 3, 193);
			print(d.tagged_out);
			d.deal (3);
			print(d.dealt.tagged_out);
			d.deal (2);
			print(d.dealt.tagged_out);
			print("Should repeat the same experience now...%N");
			create d.make_repeatable(j, 3, 193);
			print(d.tagged_out);
			d.deal (3);
			print(d.dealt.tagged_out);
			d.deal (2);
			print(d.dealt.tagged_out);
		end;

	test_shuffler is
		local
			d: SHUFFLER;
			j: ARRAY [INTEGER];
		do
			print("Testing permuting 1, ..., 5%N");
			j := <<1, 2, 3, 4, 5>>;
			create d.make_non_repeatable(j);
			print(d.permuted.tagged_out);
			d.permute;
			print(d.permuted.tagged_out);
		end;
			
	test_arma is
		local
			x: ARMA_TIME_SERIES_GENERATOR;
			phi, theta: ARRAY [DOUBLE];
			w: ARRAY [DOUBLE];
			i: INTEGER;
		do
			create phi.make (1, 2);
			phi.put (0.4, 1);
			phi.put (0.2, 2);

			create x.make_repeatable (	0.0, 2.0, phi, Void, 0)
			create w.make (1, 10);
			from i := 1 until i > 10 loop
				w.put (x.item, i);
				x.forth;
				i := i + 1;
			end;
			print("Testing ARMA time series #1%N")
			print(w.tagged_out);
			print("Testing ARMA time series #2%N")
			x.set_next_sample_size(5);
			x.get_sample
			print(x.sample.tagged_out);
			x.get_sample
			print(x.sample.tagged_out);
		end;

end -- class RTEST
			
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

