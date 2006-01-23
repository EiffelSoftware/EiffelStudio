indexing
	description:
		"Table column storing date strings"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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


end -- class DATE_COLUMN

