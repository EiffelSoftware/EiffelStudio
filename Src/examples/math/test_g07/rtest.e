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

