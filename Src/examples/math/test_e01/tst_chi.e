indexing
	description: "Tester of Curve Hermite Interpolator class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	CURVE_HERMITE_INTERPOLATOR_TEST
	
inherit

	EIFFELMATH_TESTING_FRAMEWORK

creation

	make 


feature -- Initialization

	make is
			-- Test of CURVE_HERMITE_INTERPLATOR		
		local		
			x, f, d, a, b: BASIC_VECTOR;
			i: INTEGER;		
		do
			!! form.make(13, 4);
			!! x.make_real_from_array(
				<<7.99, 8.09, 8.19, 8.70, 9.20, 10.0, 12.0, 15.0, 20.0>>);
			!! f.make_real_from_array(
				<<0.0, 0.27643e-4, 0.43750e-1, 0.16918,
					0.46943, 0.94374, 0.99864, 0.99992, 0.99999>>);

			print_nl ("Testing CURVE_HERMITE_INTERPOLATOR ");
			!! hermite.make (x, f);
			print_nl ("Here are stored abscissas, ordinates and computed derivatives: ");
			print_nl ("(Compare with derivatives given as input in NAG test e01bgc) ");
			printv ("Derivatives",hermite.derivatives);
			printv ("Abscissas", hermite.abscissas);
			printv ("Ordinates",hermite.ordinates);

			print_nl (" Testing 'integral' for four limits <a, b> - see NAG e01bhc ");
			!! a.make_real_from_array (<<7.99, 10.0, 12.0, 15.0>>);
			!! b.make_real_from_array (<<20.0, 12.0, 10.0, 15.0>>);
			from 
				i := 1
			until
				i > 4
			loop
				print ("a =");
				print (form.formatted (a.real_item(i)));
				print (" b =");
				print (form.formatted (b.real_item(i)));
				print ("-->integral = ");
				print_nl (form.formatted (hermite.integral (
					a.real_item (i), b.real_item (i))));
				i := i + 1;
			end;
			!! a.make_real_from_array (<<7.99, 9.191, 10.392, 11.593, 12.794, 13.995, 
					15.196, 16.397, 17.598, 18.799, 20.0>>);
			hermite.set_interposed_abscissas (a); 
				
			print_nl ("Interposed abscissas, ordinates and derivatives ");
			print_nl ("(Compare with output in NAG test e01bgc) ");
			printv ("interposed_abscissas", hermite.interposed_abscissas);
			printv ("interposed_derivatives", hermite.interposed_derivatives);
			printv ("interposed_ordinates", hermite.interposed_ordinates);
			print_nl ("End of tests for CURVE_HERMITE_INTERPOLATOR class ");
		end;

feature -- Access

	hermite: CURVE_HERMITE_INTERPOLATOR;
			-- Object to be tested

	form: FORMAT_SCIENTIFIC;
			-- Formatter of printouts

end -- class CURVE_HERMITE_INTERPOLATOR_TEST

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
