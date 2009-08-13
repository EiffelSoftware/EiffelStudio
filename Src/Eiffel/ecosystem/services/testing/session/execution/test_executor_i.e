note
	description: "[
		Interface of a task which is capable of obtaining test execution results for a {TEST_I}.

		Descendants are forced to implement the execution as a step by step task. They are also
		responsible for producing a test result for any test added through `queue_test', even if `cancel'
		is called before all tests were executed.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTOR_I [G -> TEST_I]

inherit
	ROTA_TIMED_TASK_I

	DISPOSABLE_I
		export
			{NONE} all
			{TEST_EXECUTION_I} dispose
		end

feature -- Access

	test_execution: TEST_EXECUTION_I
			-- Execution to which `Current' is dedicated
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
		end

feature -- Status report

	is_available: BOOLEAN
			-- Can `Current' accept a next test to be executed?
			--
			-- Note: `is_available' can still be true even if a test is currently being executed. This is to
			--       allow parallel test execution by one {TEST_EXECUTOR_I} and should be taken advantage of
			--       by any {TEST_EXECUTION_I} too.
		require
			usable: is_interface_usable
		deferred
		ensure
			consistent: Result = is_available
		end

	is_running_test (a_test: TEST_I): BOOLEAN
			-- Is test being run by `Current'?
			--
			-- `a_test': A test.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
		deferred
		ensure
			result_implies_running: Result implies has_next_step
		end

feature {TEST_EXECUTION_I} -- Status setting

	frozen run_test (a_test: TEST_I)
			-- Obtain new test result for given test.
			--
			-- Note: it is the responsibility of `Current' to report a result back to `test_execution' for
			--       any test launched through `run_test'.
			--
			-- `a_test': Test to be executed.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			available: is_available
			a_test_usable: a_test.is_interface_usable
			a_test_compatible: is_test_compatible (a_test)
			a_test_is_running: test_execution.is_test_running (a_test)
			a_test_not_launched: not is_running_test (a_test)
		do
			if attached {G} a_test as l_typed_test then
				run_compatible_test (l_typed_test)
			else
				check dead_end: False end
			end
		end

feature {TEST_EXECUTION_I} -- Status setting

	abort_test (a_test: TEST_I)
			-- Abort execution of test.
			--
			-- `a_test': Test for which execution should be aborted.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_running: is_running_test (a_test)
			a_test_aborted: not test_execution.has_test (a_test)
		deferred
		end

feature {NONE} -- Status setting

	run_compatible_test (a_test: G)
			-- Obtain test result for given test.
			--
			-- `a_test': A test.
		require
			a_test_attached: a_test /= Void
			usable: is_interface_usable
			available: is_available
			a_test_usable: a_test.is_interface_usable
			a_test_is_running: test_execution.is_test_running (a_test)
			a_test_not_launched: not is_running_test (a_test)
		deferred
		end

feature -- Query

	frozen is_test_compatible (a_test: TEST_I): BOOLEAN
			-- Can given test be executed by `Current'?
			--
			-- `a_test': A test.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
		do
			Result := attached {G} a_test
		ensure
			result_implies_conformance: Result implies attached {G} a_test
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
