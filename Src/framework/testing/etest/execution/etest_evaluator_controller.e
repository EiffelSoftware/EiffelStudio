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
		end

feature -- Access

	test_result: EQA_RESULT
			-- Result received for `test'
		require
			running: is_running
			has_result: has_result
		local
			l_result: detachable like test_result
		do
			l_result := connection.last_result
			check l_result /= Void end
			Result := l_result
		ensure
			result_from_connection: Result = connection.last_result
		end

feature {NONE} -- Access

	test_suite: ETEST_SUITE
			-- Test suite containing {ETEST} instances

	connection: ETEST_EVALUATOR_CONNECTION
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

	internal_connection: detachable ETEST_EVALUATOR_CONNECTION
			-- Connection to evaluator

	testing_directory: STRING
			-- Directory in which tests should be executed

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

	launch_test (a_request: TUPLE; an_evaluator_class: EIFFEL_CLASS_C; an_evaluator_feature: FEATURE_I)
			-- Launch test through given evaluator class and feature.
			--
			-- `a_request': Evaluator request containing byte code for calling test routine.
			-- `an_evaluator_class': CLASS_C instance of EQA_EVALUATOR_ROOT.
			-- `an_evaluator_feature': Instance of root feature in EQA_EVALUATOR_ROOT.
		require
			a_request_attached: a_request /= Void
			an_evaluator_class_attached: an_evaluator_class /= Void
			an_evaluator_feature_attached: an_evaluator_feature /= Void
			an_evaluator_class_valid: an_evaluator_class.types.count = 1
			an_evaluator_feature_valid: an_evaluator_feature.valid_body_id
			not_has_next_step: not has_next_step
		local
			l_connection: like connection
			l_args: STRING
		do
			if is_running and has_died then
				reset
			end
			if not is_running then
				create l_connection.make
				internal_connection := l_connection
				create l_args.make (100)
				l_args.append_integer (l_connection.current_port)
				l_args.append_character (' ')
				l_args.append_integer (an_evaluator_feature.real_body_id (an_evaluator_class.types.first) - 1)
				l_args.append_character (' ')
				l_args.append_integer (an_evaluator_feature.real_pattern_id (an_evaluator_class.types.first))
				l_args.append (" %"")
				l_args.append_string (testing_directory)
				l_args.append_character ('"')
				l_args.append (" -eif_root ")
				l_args.append ({ETEST_CONSTANTS}.eqa_evaluator_root)
				l_args.append_character ('.')
				l_args.append ({ETEST_CONSTANTS}.eqa_evaluator_creator)
				start_evaluator (l_args)
			end
			connection.send_request (a_request)
			has_next_step := True
		ensure
			running: is_running
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

	start_evaluator (a_argument: STRING)
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
