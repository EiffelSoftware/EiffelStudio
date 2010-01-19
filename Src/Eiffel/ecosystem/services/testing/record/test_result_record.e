note
	description: "[
		Test record containing results from any type of test execution.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RESULT_RECORD

inherit
	TEST_COMMON_SESSION_RECORD [EQA_RESULT]
		rename
			has_item as has_result,
			has_item_for_test as has_result_for_test,
			item_for_name as result_for_name,
			item_for_test as result_for_test
		end

feature {TEST_EXECUTION_I} -- Element change

	add_result (a_test: TEST_I; a_result: like result_for_test)
			-- Add new test result to the end of `test_map'.
			--
			-- `a_test': Name of test for which item should be added
			-- `a_result': New result for test named `a_name'.
		require
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			a_test_usable: a_test.is_interface_usable
			not_added_yet: not has_result_for_test (a_test)
		do
			add_item (a_result, a_test.name)
			if is_attached then
				repository.report_record_update (Current)
			end
		ensure
			has_result_for_test: has_result_for_test (a_test)
			valid_result: result_for_test (a_test) = a_result
			result_is_last: internal_tests.last.same_string (a_test.name)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
