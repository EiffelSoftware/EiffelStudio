indexing
	description:
		"Table column storing date strings"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DATE_COLUMN inherit

	TEST_DATA_COLUMN
		redefine
			test_case
		end

feature {NONE} -- Implementation

	test_case: VALIDITY_TEST
			-- Test case to be injected

	inject_data (s: STRING) is
			-- Inject `s' into `test_case'
		do
			test_case.set_date_string (s)
		end

end -- class DATE_COLUMN

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
