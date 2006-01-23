indexing
	description: "A small test for Special Functions"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TEST_S
inherit
	EIFFELMATH_TESTING_FRAMEWORK
	SPECIAL_FUNCTIONS
		undefine
			print
		end

create
	make

feature
	make is
			-- See if things compile, anyway.
		do
			print(tanh(0.5));
			print( "<-- tanh(0.5) should be 0.46212%N");

			print(p_incomplete_gamma(2., 3., 0.));
			print( "<-- p(2.,3.) should be 0.8009%N");
			print(p_incomplete_gamma(2., 3., 0.));
			print( "<-- p(2.,3.) should be 0.8009%N");
			print(q_incomplete_gamma(2., 3., 0.));
			print( "<-- q(2.,3.) should be 0.1991%N");
			print(p_incomplete_gamma(7., 1., 0.));
			print( "<-- p(7.,1.) should be 0.0001%N");
			print(q_incomplete_gamma(20., 21., 0.));
			print( "<-- q(20.,21.) should be 0.3843%N");
			print(q_incomplete_gamma(2., 3., 0.));
			print( "<-- q(2.,3.) should be 0.1991%N");
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


end -- class TEST_S
			
