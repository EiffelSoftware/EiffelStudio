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

	test_name: IMMUTABLE_STRING_8
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

	test_directory: IMMUTABLE_STRING_8
			-- Name of directory in which tests are executed
		do
			if attached test_directory_cell.item as l_directory then
				Result := l_directory
			else
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
		end

feature {NONE} -- Access

	test_name_cell: CELL [detachable IMMUTABLE_STRING_8]
			-- Cell contining name of test currently being tested
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

	test_directory_cell: CELL [detachable IMMUTABLE_STRING_8]
			-- Cell containing name of directory in which tests are executed
			--
			-- Note: directory must be writable.
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

	default_test_name: STRING = ""
			-- Default value for `test_name'

feature {EQA_TEST_EVALUATOR} -- Element change

	set_test_name (a_name: READABLE_STRING_8)
			-- Set `test_name' to given name.
			--
			-- `a_name': Name for test next test to be executed.
		require
			a_name_attached: a_name /= Void
		local
			l_name: like test_name
		do
			create l_name.make_from_string (a_name)
			test_name_cell.put (l_name)
		ensure
			test_name_set: test_name.same_string (a_name)
		end

	set_test_directory (a_name: READABLE_STRING_8)
			-- Set `test_directory' to given directory name.
			--
			-- `a_name': Directory name in which tests are be executed.
		require
			a_name_attached: a_name /= Void
		local
			l_name: like test_directory
		do
			create l_name.make_from_string (a_name)
			test_directory_cell.put (l_name)
		ensure
			test_directory_set: test_directory.same_string (a_name)
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
