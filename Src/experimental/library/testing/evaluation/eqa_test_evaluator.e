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
	EQA_TEST_EVALUATOR

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

feature -- Status report

	last_result: detachable EQA_TEST_RESULT
			-- Result last produced by `execute'

feature {NONE} -- Access

	buffer: EQA_TEST_OUTPUT_BUFFER
			-- Buffer for recording output
		once
			create Result.make (2048)
		end

feature -- Status report

	record_output: BOOLEAN
			-- Shall output produced by tests be recorded in responses of `last_result'

feature {NONE} -- Status report

	last_invocation_response: detachable EQA_TEST_INVOCATION_RESPONSE
			-- Response last produced by `safe_execute'

feature -- Status setting

	set_record_output (a_record_output: BOOLEAN)
			-- Set `record_output'.
			--
			-- `a_record_output': Value to which `record_output' will be set.
		do
			record_output := a_record_output
		ensure
			record_output_set: record_output = a_record_output
		end

feature -- Execution

	frozen execute (a_test_set: FUNCTION [ANY, TUPLE, EQA_TEST_SET]; a_test: PROCEDURE [ANY, TUPLE [EQA_TEST_SET]]; a_name: READABLE_STRING_8)
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
			-- `a_test_set': Test set instance for which a test procedure shall be executed.
			-- `a_test': Procedure taking `a_test_set' as an operand and invokes the corresponding test procedure.
		require
			a_test_set_attached: a_test_set /= Void
			a_test_attached: a_test /= Void
			a_name_attached: a_name /= Void
			--valid_test_set: a_test.valid_operands ([a_test_set])
		local
			l_prepare, l_test, l_clean: like last_invocation_response
			l_work_dir, l_target: STRING
		do
			(create {EQA_EVALUATION_INFO}).set_test_name (a_name)
			l_work_dir := current_working_directory.twin
			l_target := type_name_of_type (generic_dynamic_type (a_test_set, 3))
			safe_execute (a_test_set, l_target)
			l_prepare := last_invocation_response
			check l_prepare /= Void end
			if not l_prepare.is_exceptional and then attached a_test_set.last_result as l_test_set then
				safe_execute (agent l_test_set.run_test (a_test), l_target)
				l_test := last_invocation_response
				check l_test /= Void end
				safe_execute (agent l_test_set.clean (l_test.is_exceptional), l_target)
				l_clean := last_invocation_response
				check l_clean /= Void end
				create last_result.make (l_prepare, l_test, l_clean, create {DATE_TIME}.make_now)
			else
				create last_result.make_with_setup (l_prepare, create {DATE_TIME}.make_now)
			end
			change_working_directory (l_work_dir)
		ensure
			last_result_attached: last_result /= Void
		end

feature {NONE} -- Implementation

	safe_execute (a_procedure: ROUTINE [ANY, TUPLE]; a_target: READABLE_STRING_8)
			-- Execute `procedure' in a protected way.
		require
			a_procedure_attached: a_procedure /= Void
			a_target_attached: a_target /= Void
			buffer_empty: buffer.is_empty
		local
			l_retry: BOOLEAN
			l_old: detachable PLAIN_TEXT_FILE
			l_excpt: detachable EXCEPTION
			l_texcpt: EQA_TEST_INVOCATION_EXCEPTION
		do
			if not l_retry then
				l_old := io.default_output
				if record_output then
					io.set_file_default (buffer)
				end
				a_procedure.call (Void)
				create last_invocation_response.make_normal (buffered_output)
				buffer.wipe_out
			end
			if l_old /= Void then
				io.set_file_default (l_old)
			end
		ensure
			last_invocation_response_attached: last_invocation_response /= Void
		rescue
			l_retry := True
			l_excpt := exception_manager.last_exception
			check l_excpt /= Void end
			create l_texcpt.make (l_excpt, a_target, Void)
			create last_invocation_response.make_exceptional (buffered_output, l_texcpt)
			buffer.wipe_out
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
