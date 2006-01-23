indexing
	description:
		"Result columns in test input data tables"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
			Result := s /= Void and then expected_result (s) /= Void
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




end -- class RESULT_COLUMN

