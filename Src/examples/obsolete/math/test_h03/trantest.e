indexing
	description: "Test for TRANSPORTATION_PROBLEM_SOLVER (h03abc)"
	legal: "See notice at end of class.";	
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEST_TRANSPORTATION_PROBLEM_SOLVER

