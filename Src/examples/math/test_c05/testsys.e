indexing
	description: " Test transformationmultiple regression suite.";
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

end -- class TEST_SYSTEM	

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

