indexing
	description: "Test for TRANSPORTATION_PROBLEM_SOLVER (h03abc)";	
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"


class

	TEST_TRANSPORTATION_PROBLEM_SOLVER 
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create
	make

feature -- Initialization

	tested: TRANSPORTATION_PROBLEM_SOLVER;

	make is
			-- Test h03abc interface
		local
			cost: BASIC_MATRIX;
			avail: ARRAY [DOUBLE];
			req: ARRAY [DOUBLE];
			i: INTEGER;
		do
			avail := <<1.0, 5.0, 6.0>>;
			req := <<4.0, 4.0, 4.0>>;
			create cost.make_real_from_array (
				<< 8.0, 8.0, 11.0,
				   5.0, 8.0, 14.0,
				   4.0, 3.0, 10.0 >>,
				3, 3);
			create tested.make;
			tested.set_maximum_iterations (200);
			tested.set_available (avail);
			tested.set_required (req);
			tested.set_cost (cost);
			tested.solve;
			print("Transportation problem solved in ");
			print (tested.number_of_iterations);
			print (" iterations.%N%N");
			print ("From%TTo%TNumber%TUnit Cost%N");
			from i := 1 until i > tested.solution_size loop
				print (tested.source_numbers @ i);
				print ("%T");
				print (tested.destination_numbers @ i);
				print ("%T");
				print (tested.optimal_quantities @ i);
				print ("%T");
				print (tested.unit_costs @ i);
				print ("%N");
				i := i + 1
			end;
			print ("%NTotal cost is ");
			print (tested.optimal_cost);
			print ("%N");
		end;

end -- class TEST_TRANSPORTATION_PROBLEM_SOLVER

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

