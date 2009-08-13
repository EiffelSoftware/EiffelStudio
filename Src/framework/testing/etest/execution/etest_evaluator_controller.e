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

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
			--
			-- `a_test_suite': Test suite containing tests.
		require
			a_test_suite_attached: a_test_suite /= Void
		do
			test_suite := a_test_suite
		ensure
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	test_result: EQA_RESULT
			-- Result received for `test'
		require
			running: is_running
			has_result: has_result
		do
			Result := connection.test_result
		ensure
			result_from_connection: Result = connection.test_result
		end

feature {NONE} -- Access

	test_suite: ETEST_SUITE
			-- Test suite containing {ETEST} instances

	connection: ETEST_EVALUATOR_CONNECTION
			-- Connection to evaluator
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

	request: detachable TUPLE
			-- Internal storage for byte code of `test'

feature -- Status report

	is_running: BOOLEAN
			-- Is evaluator currently running?
		do
			Result := internal_connection /= Void
		ensure
			result_implies_connection_attached: Result implies internal_connection /= Void
		end

	is_ready: BOOLEAN
			-- Is `Current' ready to run a test?
			--
			-- Note: if `is_ready' is not true, although no test has been assigned yet or a result has been
			--       retrieved for that test, the client is forced to restart `Current'.
		require
			running: is_running
		do
			Result := not has_died and not has_next_step
		ensure
			result_implies_not_died: Result implies not has_died
			result_implies_no_next_step: Result implies not has_next_step
		end

	has_result: BOOLEAN
			-- Has a result been received for `test'?

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result := is_running and not (has_result or has_died)
		ensure then
			result_implies_running: Result implies is_running
			result_implies_not_result_or_died: Result implies not (has_result or has_died)
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

	has_died: BOOLEAN
			-- Has connection to evaluator died?

feature -- Status setting

	start (a_evaluator_class: EIFFEL_CLASS_C; a_evaluator_feature: FEATURE_I)
			-- Launch evaluator
		require
			a_evaluator_class_attached: a_evaluator_class /= Void
			a_evaluator_feature_attached: a_evaluator_feature /= Void
			a_evaluator_class_valid: a_evaluator_class.types.count = 1
			a_evaluator_feature_valid: a_evaluator_feature.valid_body_id
			not_running: not is_running
		local
			l_connection: like connection
			l_args: STRING
			l_id: INTEGER
		do
			has_result := True
			create l_connection.make
			internal_connection := l_connection
			if l_connection.current_port > 0 then
					create l_args.make (100)
				l_args.append_integer (l_connection.current_port)
				l_args.append_character (' ')
				l_args.append_integer (a_evaluator_feature.real_body_id (a_evaluator_class.types.first) - 1)
				l_args.append_character (' ')
				l_args.append_integer (a_evaluator_feature.real_pattern_id (a_evaluator_class.types.first))
				l_args.append (" -eif_root ")
				l_args.append ({ETEST_CONSTANTS}.eqa_evaluator_root)
				l_args.append_character ('.')
				l_args.append ({ETEST_CONSTANTS}.eqa_evaluator_creator)

				has_died := False
				start_evaluator (l_args)
			end
		ensure
			running: is_running
			ready: is_ready
		end

	execute_test (a_request: TUPLE)
			-- Run test in evaluator
		require
			running: is_running
			ready: is_ready
		do
			has_result := False
			request := a_request
		ensure
			has_next_step: has_next_step
		end

	stop
			-- Stop evaluator
		require
			running: is_running
		do
			stop_evaluator
			connection.terminate
			internal_connection := Void
		ensure
			not_running: not is_running
		end

	step
			-- <Precursor>
		do
			if
				not connection.has_connection_died and then
				is_evaluator_launched and then is_evaluator_running
			then
				if attached request as l_request then
					connection.send_request (l_request)
					request := Void
				else
					has_result := connection.has_result
				end
			else
				has_died := True
			end
		end

	cancel
			-- <Precursor>
		do
			stop
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
					stop
				end
			end
		end

feature {NONE} -- Constants

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
