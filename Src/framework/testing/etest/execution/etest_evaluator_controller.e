note
	description: "[
		Controller which can launch an evaluator process to obtain test results.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETEST_EVALUATOR_CONTROLLER

inherit
	ROTA_TASK_I

	DISPOSABLE_SAFE

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite; a_testing_directory: like testing_directory)
			-- Initialize `Current'.
			--
			-- `a_test_suite': Test suite containing tests.
			-- `a_testing_directory': Directory in which tests are executed.
		require
			a_test_suite_attached: a_test_suite /= Void
		do
			test_suite := a_test_suite
			testing_directory := a_testing_directory
		ensure
			test_suite_set: test_suite = a_test_suite
			testing_directory_set: testing_directory = a_testing_directory
		end

feature -- Access

	test_result: EQA_PARTIAL_RESULT
			-- Result received for `test'
		require
			running: is_running
			has_result: has_result
		local
			l_result: detachable like test_result
			l_type: TYPE [EQA_PARTIAL_RESULT]
		do
				-- Referencing different result types to make sure they are compiled and can be received
			l_type := {EQA_RESULT}
			l_type := {EQA_PARTIAL_RESULT}

			l_result := connection.last_result
			check l_result /= Void end
			Result := l_result
		ensure
			result_from_connection: Result = connection.last_result
		end

	last_exit_code: INTEGER
			-- Exit code last returned from evaluator
			--
			-- Note: only valid if `has_died' is true.

	last_output: STRING
			-- Output printed by evaluator since last call to `launch_test'
		deferred
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	test_suite: ETEST_SUITE
			-- Test suite containing {ETEST} instances

	connection: ETEST_EVALUATOR_CONNECTION [TUPLE, like test_result]
			-- Connection to evaluator
		require
			running: is_running
		local
			l_connection: like internal_connection
		do
			l_connection := internal_connection
			check l_connection /= Void end
			Result := l_connection
		ensure
			result_equals_storage: Result = internal_connection
		end

	internal_connection: detachable like connection
			-- Connection to evaluator

	testing_directory: PATH
			-- Directory in which tests will have some associated files stored during execution.

feature -- Status report

	is_running: BOOLEAN
			-- Is evaluator currently running?
		do
			Result := internal_connection /= Void
		ensure
			result_implies_connection_attached: Result implies internal_connection /= Void
		end

	has_result: BOOLEAN
			-- Has a result been received for `test'?
		require
			running: is_running
		do
			Result := connection.last_result /= Void
		ensure
			result_implies_result_attached: Result implies connection.last_result /= Void
		end

	has_next_step: BOOLEAN
			-- <Precursor>

	has_died: BOOLEAN
			-- Has connection to evaluator died?
		do
			Result := connection.has_connection_died
		ensure
			result_implies_connection_died: Result implies connection.has_connection_died
		end

feature {NONE} -- Status report

	is_evaluator_launched: BOOLEAN
			-- Has evaluator process been launched?
		require
			running: is_running
		deferred
		end

	is_evaluator_running: BOOLEAN
			-- Is evaluator process running?
		require
			running: is_running
			evaluator_launched: is_evaluator_launched
		deferred
		end

feature -- Status setting

	launch_test (a_request: TUPLE)
			-- Launch test through given evaluator class and feature.
			--
			-- `a_request': Evaluator request containing byte code for calling test routine.
		require
			a_request_attached: a_request /= Void
			not_has_next_step: not has_next_step
		local
			l_connection: like connection
			l_args: STRING_32
		do
			if is_running and has_died then
				reset
			end
			if not is_running then
				create l_connection.make
				internal_connection := l_connection
				create l_args.make (100)
				l_args.append_integer (l_connection.current_port)
				l_args.append (" %"")
				l_args.append_string_general (testing_directory.name)
				l_args.append_character ('"')
				l_args.append (" -eif_root ")
				l_args.append ({TEST_SYSTEM_I}.eqa_evaluator_name)
				l_args.append_character ('.')
				l_args.append ({TEST_SYSTEM_I}.eqa_evaluator_creator)
				start_evaluator (l_args)
			end
				-- See bug#18686 where if you select a test that was just renamed
				-- and try to run it, it will cause a compilation that will cause
				-- the test to be removed and a call to `reset' indirectly which
				-- will invalidate the connection just made above.
			if attached internal_connection as l_internal_connection then
				l_internal_connection.send_request (a_request)
				has_next_step := True
			end
		end

	step
			-- <Precursor>
		local
			l_has_next_step: BOOLEAN
		do
			if has_died then
				if is_evaluator_launched then
					stop_evaluator
				end
			elseif not is_evaluator_running then
				connection.terminate
				check died: has_died end
			elseif not has_result then
				l_has_next_step := True
			end
			has_next_step := l_has_next_step
		ensure then
			running: is_running
			valid_state: not has_next_step implies (has_died or has_result)
		end

	reset
			-- Reset evaluator.
		require
			running: is_running
		do
			if is_evaluator_launched then
				stop_evaluator
			end
			connection.terminate
			internal_connection := Void
			has_next_step := False
		ensure
			not_running: not is_running
		end

	cancel
			-- <Precursor>
		do
			reset
		end

feature {NONE} -- Status setting

	start_evaluator (a_argument: READABLE_STRING_GENERAL)
			-- Launch evaluator process.
			--
			-- `a_argument': Arguments with which evaluator should be launched.
		require
			a_argument_attached: a_argument /= Void
			running: is_running
			not_launched: not is_evaluator_launched
		deferred
		ensure
			running: is_running
			launched: is_evaluator_launched
		end

	stop_evaluator
			-- Stop evaluator process.
		require
			launched: is_evaluator_launched
		deferred
		ensure
			not_launched: not is_evaluator_launched
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if is_running then
					reset
				end
			end
		end

feature {NONE} -- Constants

	testing_directory_name: STRING = "execution"

invariant
	has_next_step_implies_running: has_next_step implies (is_running and then is_evaluator_launched)

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
