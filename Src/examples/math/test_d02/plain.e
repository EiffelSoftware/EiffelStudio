indexing
	description: "A non-stiff set of ODEs (d02cjc example)";	
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EXAMPLE_PLAIN_ODE

inherit
	EIFFELMATH_TESTING_FRAMEWORK
	STANDARD_ODE
		undefine
			print
		end
	MATHEMATICIAN
		undefine
			print
		end

feature -- Basic operations

	rhs (x: DOUBLE; y: ARRAY [DOUBLE]): ARRAY [DOUBLE] is
		do
			create Result.make(1, 3);
			Result.put (tangent (y @ 3), 
				1);
			Result.put (
				-0.032 * tangent (y @ 3) / (y @ 2) - 
					0.02 * (y @ 2) / cosine(y @ 3),
				2);
			Result.put (-0.032 / (y @ 2)^2,
				 3);
		end;	

	g (x: DOUBLE; y: ARRAY [DOUBLE]): DOUBLE is
		do
			Result := y @ 1
		end;

	jacobian (x: DOUBLE; y: ARRAY [DOUBLE]): BASIC_MATRIX is
			-- None available.
		do
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

end -- class EXAMPLE_ODE

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


