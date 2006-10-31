indexing
	description: "Test class for G05"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class

	TEST_MEDIAN_STATISTICS
inherit

	EIFFELMATH_TESTING_FRAMEWORK

create

	make

feature
	make is
			-- Test g07
		local
			ms: MEDIAN_STATISTICS;
			x: ARRAY [DOUBLE];
		do
			x := <<
			13., 11., 16., 5., 3.,
			18., 9., 8., 6., 27.,
			7.0
			>>;
			create ms.make (x);
			print("Expecting 9.0, 4.0, 5.930%N");
			print(ms);
			print(ms.tagged_out);
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


end -- class TEST_MEDIAN_STATISTICS
			
			







