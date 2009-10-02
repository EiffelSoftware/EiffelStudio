note
	description: "[
			Objects that are able to run tests in a protected environment and provide information whether
			the test has failed or succeeded.
			
			Note: Evaluator is not able to recover from all exceptions. Tests causing seg-faults or out-of-
			      memory exceptions might put evaluator in an unstable state.
		]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_EVALUATOR [G -> EQA_TEST_SET create default_create end]

inherit
	ANY

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			class_name as exception_class_name
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

feature -- Access

	last_result: EQA_ETEST_PARTIAL_RESULT
			-- Result last produced by `execute'
		local
			l_cache: like last_result_cache
		do
			l_cache := last_result_cache
			check l_cache /= Void end
			Result := l_cache
		ensure
			result_equals_cache: Result = last_result_cache
		end

feature {NONE} -- Access

	last_result_cache: detachable like last_result
			-- Cache for `last_result'

	buffer: EQA_TEST_OUTPUT_BUFFER
			-- Buffer for recording output
		once
			create Result.make (2048)
		end

feature -- Status report

	has_result: BOOLEAN
			-- Has `execute' been called yet?
		do
			Result := last_result_cache /= Void
		ensure
			result_implies_cache_attached: Result implies last_result_cache /= Void
		end

feature {NONE} -- Status report

	last_invocation_response: detachable EQA_TEST_INVOCATION_RESPONSE
			-- Response last produced by `safe_execute'

feature -- Execution

	frozen execute (a_routine: PROCEDURE [ANY, TUPLE [G]])
			-- Run full test sequence for given test set and test procedure. This includes invoking `set_up'
			-- on the {TEST_SET} instance, then calling the procedure providing the test set as an operand
			-- and finally invoking `tear_down' on the test set.
			--
			-- Note: If an exception occurs, `last_exception' will be True and `last_exception' will provide
			--       the raised exception. If the exception occurs during `set_up', both the procedure and
			--       `tear_down' will not be invoked. If the exception occurs during the actual test
			--       procedure, `tear_down' still gets invoked. If both the test procedure and `tear_down'
			--       raise an exception only the test procedure exception will be stored.
			--
			-- `a_routine': Agent to which calls test routine.
		require
			a_routine_attached: a_routine /= Void
			--a_routine_valid: a_routine.valid_operands ([create {G}])
		local
			l_start_date: DATE_TIME
			l_creator: FUNCTION [like Current, TUPLE, G]
			l_prepare, l_test, l_clean: like last_invocation_response
			l_test_set: detachable G
			l_basic_test_set: EQA_TEST_SET
			l_old: detachable PLAIN_TEXT_FILE
			l_old_work_dir: STRING
		do
			l_old_work_dir := current_working_directory
			create l_start_date.make_now
			l_old := io.default_output
			io.set_file_default (buffer)
			l_creator := agent: G do Result := create {G} end
			safe_execute (l_creator)
			l_prepare := last_invocation_response
			check l_prepare /= Void end
			if l_prepare.is_exceptional then
				create last_result_cache.make (l_start_date, l_prepare, buffered_output)
			else
				l_test_set := l_creator.last_result
				check l_test_set /= Void end
				safe_execute (agent a_routine.call ([l_test_set]))
				l_test := last_invocation_response
				check l_test /= Void end
				l_basic_test_set := l_test_set
				safe_execute (agent l_basic_test_set.clean (l_test.is_exceptional))
				l_clean := last_invocation_response
				check l_clean /= Void end
				create {EQA_ETEST_RESULT} last_result_cache.make (l_start_date, l_prepare, l_test, l_clean, buffered_output)
			end
			if l_old = Void then
				io.set_output_default
			else
				io.set_file_default (l_old)
			end
			change_working_directory (l_old_work_dir)
			buffer.wipe_out
		ensure
			has_result: has_result
		end

feature {NONE} -- Implementation

	safe_execute (a_procedure: ROUTINE [ANY, TUPLE])
			-- Execute `procedure' in a protected way.
		require
			a_procedure_attached: a_procedure /= Void
			buffer_empty: buffer.is_empty
		local
			l_retry: BOOLEAN
			l_excpt: detachable EXCEPTION
			l_texcpt: EQA_TEST_INVOCATION_EXCEPTION
			l_test_set_name: STRING
		do
			if not l_retry then
				a_procedure.call (Void)
				create last_invocation_response.make
			end
		ensure
			last_invocation_response_attached: last_invocation_response /= Void
		rescue
			l_retry := True
			l_excpt := exception_manager.last_exception
			check l_excpt /= Void end
			l_test_set_name := 	type_name_of_type (generic_dynamic_type (Current, 1))
			create l_texcpt.make (l_excpt, l_test_set_name, Void)
			create last_invocation_response.make_exceptional (l_texcpt)
			retry
		end

	buffered_output: STRING
			-- Output buffered by `buffer'
			--
			-- Note: if output was truncated, add string indicating so.
		do
			if buffer.is_truncated then
				create Result.make (buffer.buffer_size + 100)
				Result.append (buffer.leading_content)
				Result.append (m_truncated)
				Result.append (buffer.closing_content)
			else
				Result := buffer.content
			end
		end

feature {NONE} -- Constants

	m_truncated: STRING = "%N%N---------------------------%NTruncated section%N---------------------------%N%N"

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
