note
	description: "[
		Stateless object containing information about the current test evaluation.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EVALUATION_INFO

feature -- Access

	test_name: READABLE_STRING_8
			-- Name of test currently being executed
		do
			if attached test_name_cell.item as l_name then
				Result := l_name
			else
				Result := default_test_name
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	test_name_cell: CELL [detachable READABLE_STRING_8]
			-- Cell contining name of test currently being tested
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

	default_test_name: STRING = ""
			-- Default value for `test_name'

feature {EQA_TEST_EVALUATOR} -- Element change

	set_test_name (a_name: like test_name)
			-- Set `test_name' to given name.
			--
			-- `a_name': Name for test next test to be executed.
		require
			a_name_attached: a_name /= Void
		do
			test_name_cell.put (a_name)
		ensure
			test_name_set: test_name = a_name
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
