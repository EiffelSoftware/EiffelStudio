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

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
