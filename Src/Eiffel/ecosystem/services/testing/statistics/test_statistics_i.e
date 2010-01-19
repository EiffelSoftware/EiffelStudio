note
	description: "[
		Interface providing access to different test statistics.
		
		Note: this interface is provisional for 6.5 and is likely to change in future releases.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_STATISTICS_I

inherit
	EVENT_CONNECTION_POINT_I [TEST_STATISTICS_OBSERVER, TEST_STATISTICS_I]

feature -- Access

	test_suite: TEST_SUITE_S
			-- Test suite containing actual tests.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
		end

feature -- Access: general statistics

	test_count: NATURAL
			-- Number of tests in `test_suite'
		require
			usable: is_interface_usable
		deferred
		ensure
			result_correct: Result = test_suite.tests.count.as_natural_32
		end

	executed_test_count: NATURAL
			-- Number of executed tests in `test_suite'
		require
			usable: is_interface_usable
		deferred
		ensure
			result_valid: 0 <= Result and Result <= test_suite.tests.count.as_natural_32
		end

	passing_test_count: NATURAL
			-- Number of tests in `test_suite' which currently pass
		require
			usable: is_interface_usable
		deferred
		end

	failing_test_count: NATURAL
			-- Number of tests in `test_suite' which currently fail
		require
			usable: is_interface_usable
		deferred
		end

	unresolved_test_count: NATURAL
			-- Number of tests in `test_suite' which are currently unresolved
		require
			usable: is_interface_usable
		deferred
		end

feature -- Access: test statistics

	execution_count (a_test: TEST_I): NATURAL
			-- Number of times the given test was executed
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_valid: test_suite.has_test (a_test.name) and then test_suite.test (a_test.name) = a_test
		deferred
		end

	last_result (a_test: TEST_I): TEST_RESULT_I
			-- Result of last execution
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_valid: test_suite.has_test (a_test.name) and then test_suite.test (a_test.name) = a_test
			a_test_executed: execution_count (a_test) > 0
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Events

	statistics_updated_event: EVENT_TYPE_I [TUPLE [statistics: TEST_STATISTICS_I]]
			-- Event called when the statistics were updated
		require
			usable: is_interface_usable
		deferred
		end

	test_statistics_updated_event: EVENT_TYPE_I [TUPLE [statistics: TEST_STATISTICS_I; session: TEST_I]]
			-- Event called when the statistics for a specific test were updated
		require
			usable: is_interface_usable
		deferred
		end

invariant
	valid_counts: passing_test_count + failing_test_count + unresolved_test_count <= executed_test_count

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
