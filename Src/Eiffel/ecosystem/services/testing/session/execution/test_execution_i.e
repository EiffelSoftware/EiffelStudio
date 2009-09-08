note
	description: "[
		Sessions which obtains new testing results by executing tests through {TEST_EXECUTOR_I} instances.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTION_I

inherit
	TEST_SESSION_I
		redefine
			new_record
		select
			connection
		end

	EVENT_CONNECTION_POINT_I [TEST_EXECUTION_OBSERVER, TEST_EXECUTION_I]
		rename
			connection as execution_connection
		end

feature -- Access

	queued_tests: DS_LINEAR [TEST_I]
			-- All tests which are queued waiting to be executed
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			results_valid: Result.for_all (agent is_test_queued (?))
		end

	running_tests: DS_LINEAR [TEST_I]
			-- All tests which are currently being executed through a {TEST_EXECUTOR_I}
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			results_valid: Result.for_all (agent is_test_running (?))
		end

	execution_connection: EVENT_CONNECTION_I [TEST_EXECUTION_OBSERVER, TEST_EXECUTION_I]
			-- <Precursor>
		local
			l_cache: like execution_connection_cache
		do
			l_cache := execution_connection_cache
			if l_cache = Void then
				l_cache := create {EVENT_CHAINED_CONNECTION [TEST_EXECUTION_OBSERVER, TEST_EXECUTION_I, TEST_SESSION_OBSERVER, TEST_SESSION_I]}.make
					(agent (an_observer: TEST_EXECUTION_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[test_running_event, agent an_observer.on_test_running],
								[test_executed_event, agent an_observer.on_test_executed],
								[test_removed_event, agent an_observer.on_test_removed]
							>>
						end,
					connection)
				execution_connection_cache := l_cache
			end
			Result := l_cache
		end

	initial_test_count: NATURAL
			-- Number of tests queued when `Current' was launched.
		require
			usable: is_interface_usable
			running: has_next_step
		deferred
		end

feature {NONE} -- Access

	execution_connection_cache: like execution_connection
			-- Cache for `execution_connection'
			--
			-- Note: do not use directly, use `execution_connection' instead

feature -- Status report

	frozen has_test (a_test: TEST_I): BOOLEAN
			-- Is test being tested by `Current'?
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
		do
			Result := is_test_queued (a_test) or is_test_running (a_test)
		ensure
			definition: Result = is_test_queued (a_test) or is_test_running (a_test)
		end

	is_test_queued (a_test: TEST_I): BOOLEAN
			-- Is test queued in `Current' to be tested?
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
		deferred
		ensure
			result_implies_not_running: Result implies not is_test_running (a_test)
		end

	is_test_running (a_test: TEST_I): BOOLEAN
			-- Is test currently being executed?
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
		deferred
		ensure
			result_implies_not_queued: Result implies not is_test_queued (a_test)
			result_implies_has_next_step: Result implies has_next_step
		end

	is_debugging: BOOLEAN
			-- Should tests be executed through debugger if applicable?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Status setting

	queue_test (a_test: TEST_I)
			-- Put test into queue of tests to be executed.
			--
			-- `a_test': Test to be put into queue.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_not_queued: not is_test_queued (a_test)
			not_running: not has_next_step
		deferred
		ensure
			a_test_queued: is_test_queued (a_test)
		end

	abort_test (a_test: TEST_I)
			-- Abort execution of test.
			--
			-- `a_test': Test for which execution should be aborted.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			has_test: has_test (a_test)
		deferred
		ensure
			not_has_test: not has_test (a_test)
		end

	set_debugging (a_debugging: like is_debugging)
			-- Set `is_debugging' to given `a_debugging'.
			--
			-- `a_debugging': True if test should be executed in the debugger (if applicable), False
			--                otherwise.
		require
			usable: is_interface_usable
			not_running: not has_next_step
		deferred
		ensure
			debugging_set: is_debugging = a_debugging
		end

feature {TEST_EXECUTOR_I} -- Basic operations

	report_result (a_test: TEST_I; a_result: EQA_RESULT)
			-- Report new obtained test result for test.
			--
			-- Note: test executors calling this routine should not have to check `is_test_running', since
			--       the execution aborts the test if `is_test_running' changes.
			--
			-- `a_test': Test which was executed.
			-- `a_result': Corresponding test result.
		require
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			a_test_usable: a_test.is_interface_usable
			a_test_running: is_test_running (a_test)
		deferred
		ensure
			a_test_removed: not has_test (a_test)
			not_stopped: has_next_step
			result_added: record.has_result_for_test (a_test) and then
				record.result_for_test (a_test) = a_result
		end

feature {NONE} -- Events

	test_running_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I]]
			-- Events called when a test is being executed
			--
			-- session: `Current'
			-- test: Test being executed
		require
			usable: is_interface_usable
		deferred
		end

	test_executed_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I; test_result: EQA_RESULT]]
			-- Events called when a test is done executing
			--
			-- session: `Current'
			-- test: Test which is done executing
		require
			usable: is_interface_usable
		deferred
		end

	test_removed_event: EVENT_TYPE [TUPLE [session: TEST_EXECUTION_I; test: TEST_I]]
			-- Events called when a test is removed from `Current' without being executed.
			--
			-- session: `Current'
			-- test: Test which was removed
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Factory

	new_record: TEST_EXECUTION_RECORD
			-- <Precursor>
		do
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
