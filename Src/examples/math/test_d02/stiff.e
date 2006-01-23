indexing
	description: "Stiff system, d02ejc example"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EXAMPLE_STIFF_ODE inherit

	STANDARD_ODE
		undefine
			print
		end
	MATHEMATICIAN
		undefine
			print
		end
	EIFFELMATH_TESTING_FRAMEWORK

feature -- Status report

	c1: DOUBLE is 10000.0;

	c2: DOUBLE is 3.0e7;

feature -- Basic operations

	rhs (x: DOUBLE; y: ARRAY [DOUBLE]): ARRAY [DOUBLE] is
		local
			y1, y2, y3: DOUBLE;
		do
			y1 := y @ 1;
			y2 := y @ 2;
			y3 := y @ 3;
			create Result.make (1, 3);
			Result.put (-0.04 * y1 + c1 * y2 * y3, 1);
			Result.put (
				0.04 * y1 - c1 * y2 * y3 - c2 * y2 * y2,
				2);
			Result.put (c2 * y2 * y2, 3);
		end;	

	g (x: DOUBLE; y: ARRAY [DOUBLE]): DOUBLE is
		do
			Result := (y @ 1) - 0.9
		end;

	jacobian (x: DOUBLE; y: ARRAY [DOUBLE]): BASIC_MATRIX is
		local
			y1, y2, y3: DOUBLE;
		do
			y1 := y @ 1;
			y2 := y @ 2;
			y3 := y @ 3;
			create Result.make_real (3,3);
			Result.put_grid_real (-0.04,1,1);
			Result.put_grid_real (y3 * c1,1,2);
			Result.put_grid_real (y2 * c1,1,3);
			Result.put_grid_real (0.04,2,1);
			Result.put_grid_real (y3 * (-c1) - y2 * 2.0 * c2,2,2);
			Result.put_grid_real (y2 * (-c1),2,3);
			Result.put_grid_real (0.0,3,1);
			Result.put_grid_real (y2 * 2.0 * c2,3,2);
			Result.put_grid_real (0.0,3,3);
		end;

	output (x: DOUBLE; y: ARRAY [DOUBLE]) is
		do
			print (x);
			print ('%T');
			print (y @ 1);
			print ('%T');
			print (y @ 2);
			print ('%T');
			print (y @ 3);
			print ('%N');
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


end -- class EXAMPLE_STIFF_ODE

