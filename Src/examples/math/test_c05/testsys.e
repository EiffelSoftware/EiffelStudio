indexing
	description: " Test transformationmultiple regression suite."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"


class TEST_SYSTEM inherit
	TRANSFORMATION
		redefine
			n, m, has_jacobian
		end;
feature -- Access

	has_jacobian: BOOLEAN is True;
	
	n: INTEGER is 9;

	m: INTEGER is 9;

	value (x: ARRAY [DOUBLE]): ARRAY [DOUBLE] is
		local
			y: DOUBLE;
			j: INTEGER;
		do
			create Result.make(1, 9);
			y := (3. - 2. * (x @ 1)) * (x @ 1) - 2. * (x @ 2) + 1.;
			Result.put (y, 1);
			from j := 2 until j > 8 loop
				y := -(x @ (j-1)) + 
					(3. - 2. * (x @ j)) * (x @ j)
					 - 2. * (x @ (j + 1)) + 1.;
				Result.put (y, j)
				j := j + 1
			end;
			y := -(x @ 8) + (3.-2.*(x @ 9))*(x @ 9) + 1.;
			Result.put (y, 9);
		end;

	jacobian (x: ARRAY [DOUBLE]): BASIC_MATRIX is
		local
			i: INTEGER;
		do
			create Result.make_real (9,9);
			from i := 1 until i > 9 loop
				Result.put_grid_real (3.0 - (x @ i) * 4.0, i, i);
				if i > 1 then
					Result.put_grid_real (-1.0, i, i - 1)
				end;
				if i < 9 then
					Result.put_grid_real (-2.0, i, i + 1)
				end;
				i := i + 1
			end;
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


end -- class TEST_SYSTEM	

