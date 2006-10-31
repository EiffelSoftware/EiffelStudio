indexing
	description: "A non-stiff set of ODEs (d02pcc example)"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EXAMPLE_RK_ODE

inherit

	EIFFELMATH_TESTING_FRAMEWORK
	STANDARD_ODE
		undefine
			print
		end

feature -- Basic operations

	rhs (x: DOUBLE; y: ARRAY [DOUBLE]): ARRAY [DOUBLE] is
		do
			create Result.make (1, 2);
			Result.put (y @ 2, 1);
			Result.put (- (y @ 1), 2);
		end;	

	g (x: DOUBLE; y: ARRAY [DOUBLE]): DOUBLE is
		do
			Result := y @ 1
		end;

	output(x: DOUBLE; y: ARRAY [DOUBLE]) is
		do
			print (x);
			print ('%T');
			print (y @ 1);
			print ('%T');
			print (y @ 2);
			print ('%N');
		end;

	jacobian (x: DOUBLE; y: ARRAY [DOUBLE]): BASIC_MATRIX is
			-- None available.
		do
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


end -- class EXAMPLE_RK_ODE

