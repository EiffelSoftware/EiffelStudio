indexing
	description: "Test class for G05"

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

end -- class TEST_MEDIAN_STATISTICS
			
			







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

