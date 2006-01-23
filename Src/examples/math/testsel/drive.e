indexing
	description: " Test selected data class, matrix printing"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 

	TEST_SELECTABLE_DATA

inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make

feature -- Initialization

	tested: SELECTABLE_DATA;
			-- data set for testing

	number_of_variables: INTEGER is 8;
			-- number of columns in the matrix

	number_of_observations: INTEGER is 10;
			-- number of rows in the matrix

	make is
			-- Test of SELECTABLE_DATA
		local
			i, j: INTEGER
			c: BASIC_MATRIX;
		do
			create tested.make(number_of_observations, number_of_variables);
			from i := 1 until i > number_of_observations loop
				from j := 1 until j > number_of_variables loop
					tested.put (i + j/100., i, j);
					j := j + 1
				end;
				i := i + 1
			end;
			print_nl ("Entire set:");
			print_nl (tested);
			tested.deselect_observation (1);
			tested.deselect_observation (3);
			tested.deselect_observation (5);
			tested.select_observation (3);
			tested.deselect_observation (number_of_observations);
			tested.deselect_variable (3);
			tested.deselect_variable (4);
			tested.deselect_variable (4);
			tested.select_variable (3);
			tested.select_variable (3);
			tested.deselect_variable (number_of_variables);
			print_nl ("Set 1:");
			print_nl (tested);
			tested.deselect_variable (1);
			print_nl ("Set 2:");
			print_nl (tested);

			tested.set_weight (2.2, 3);
			print_nl (tested);

			print_nl ("Test printing as matrix...");
			print_nl (tested.data)
			print_nl ("Test complex relative...");
			create c.make_dual_complex (number_of_observations, number_of_variables);
			from i := 1 until i > number_of_observations loop
				from j := 1 until j > number_of_variables loop
					c.put_grid_real (i + j/100., i, j);
					c.put_grid_imaginary (-(i + j/100.), i, j);
					j := j + 1
				end;
				i := i + 1
			end;

			print_nl (c);
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


end -- class TEST_SELECTABLE_DATA

