indexing
	description:
		"Result columns in test input data tables"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class RESULT_COLUMN inherit

	TEST_DATA_COLUMN
		redefine
			input_accepted
		end

	RUN_RESULT_FACTORY
		export
			{NONE} all
		end
		
feature -- Status report

	input_accepted (s: STRING): BOOLEAN is
			-- Is `s' acceptable input for this column?
		do
			Result := expected_result (s) /= Void
		end

feature {NONE} -- Implementation

	inject_data (s: STRING) is
			-- Inject data `s' into `test case'?
		local
			res: TEST_RUN_RESULT
		do
				check
					non_void_result: expected_result (s) /= Void
						-- Because unacceptable results are rejected by the
						-- precondition
				end
			res := expected_result (s)
			test_case.set_expected_result (res)
		ensure then
			expected_result_set: test_case.has_expected_result
		end
			
	expected_result (s: STRING): TEST_RUN_RESULT is
			-- Expected result encoded in `s'
		local
			res: STRING
		do
			res := clone (s)
			res.to_upper
			if run_result_factory.has_product (s) then
				run_result_factory.select_product (s)
				Result := run_result_factory.product
			end
		end
		
end -- class RESULT_COLUMN

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
