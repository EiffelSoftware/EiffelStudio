note
	description: "A small test for MEDIAN_SMOOTHED_ARRAY"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TEST_MEDIAN_SMOOTHED_ARRAY
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make

feature -- Initialization

	make(args: ARRAY [STRING])
			-- Test g10
		do
			test_auto_correlation
		end;

feature -- Basic operations

	expect (predicted, actual: DOUBLE)
			-- print a value with it's expected value
		do
			print(predicted);
			print(": "); 
			print(actual); 
			print_nl ("");
		end;

	test_auto_correlation
		local
			a: MEDIAN_SMOOTHED_ARRAY;
			x: ARRAY [DOUBLE];
			i: INTEGER
		do
			x := <<
			569., 416., 422., 565., 484.,
			520., 573., 518., 501., 505.,
			468., 382., 310., 334., 359.,
			372., 439., 446., 349., 395.,
			461., 511., 583., 590., 620.,
			578., 534., 631., 600., 438.,
			516., 534., 467., 457., 392., 
			467., 500., 493., 410., 412.,
			416., 403., 422., 459., 467.,
			512., 534., 552., 545.
			>>;
			create a.make (x);
			expect(426.0, a.item (1));
			expect(153.0, a.residual(1));
			print("Compare with tables at end of g10cac%N");
			print("Result of normal make.%N");
			from i := 1 until i > a.count loop
				print(i-1);
				print("%T");
				print(x @ i);
				print("%T");
				print(a @ i);
				print("%T");
				print(a.residual (i));
				print_nl ("");
				i := i + 1
			end;
			print("Result of make_for_comparison.%N");
			create a.make_for_comparison (x);
			from i := 1 until i > a.count loop
				print(i-1);
				print("%T");
				print(x @ i);
				print("%T");
				print(a @ i);
				print("%T");
				print(a.residual (i));
				print_nl ("");
				i := i + 1
			end;
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEST_MEDIAN_SMOOTHED_ARRAY

