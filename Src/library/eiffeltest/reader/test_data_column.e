indexing
	description:
		"Columns in a table representing test input data"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_DATA_COLUMN inherit

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Status report

	input_accepted (s: STRING): BOOLEAN is
			-- Is `s' acceptable input for this column?
		do
			Result := True
		end

feature -- Basic operations

	frozen inject (t: TEST_CASE; s: STRING) is
			-- Inject data `s' into test case `t'.
		require
			test_case_exists: t /= Void
			accepted_input: input_accepted (s)
		do
			test_case ?= t
			if test_case = Void then
				raise ("Passed test case is of wrong type")
			end
			inject_data (s)
		end
	 
feature {NONE} -- Implementation

	test_case: TEST_CASE
			-- Test case to be injected
			-- (To be redefined.)
			
	inject_data (s: STRING) is
			-- Inject `s' into `test_case'.
		require
			test_case_set: test_case /= Void
		deferred
		end
	 
end -- class TEST_DATA_COLUMN

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
