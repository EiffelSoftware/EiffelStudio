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
	EXECUTION_ENVIRONMENT

	EXCEPTIONS
		rename
			class_name as exception_class_name
		end

	INTERNAL

feature {NONE} -- Access

	buffer: EQA_TEST_OUTPUT_BUFFER
			-- Buffer for recording output
		once
			create Result.make (2048)
		end

feature -- Execution

	frozen execute (a_routine: PROCEDURE [EQA_TEST_SET]): EQA_PARTIAL_RESULT
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
			-- `a_routine': Agent which invokes actual test routine.
		local
			l_start_date: DATE_TIME
			l_creator: FUNCTION [EQA_TEST_SET]
			l_prepare, l_test, l_clean: like execute_test_stage
			l_old: detachable PLAIN_TEXT_FILE
			l_old_work_dir: PATH
		do
			l_old_work_dir := current_working_path
			l_old := io.default_output
			io.set_file_default (buffer)
			l_creator := agent: G do create Result end
			create l_start_date.make_now

				-- Call {EQA_TEST_SET}.default_create
			l_prepare := execute_test_stage (l_creator)
			if not l_prepare.is_exceptional and then attached l_creator.last_result as l_test_set then

					-- Call test routine
				check
					valid_operand_count: a_routine.open_count = 1
					valid_operand: a_routine.valid_operands ([l_test_set])
				end
				l_test := execute_test_stage (agent a_routine.call ([l_test_set]))

					-- Call {EQA_TEST_SET}.clean
				l_clean := execute_test_stage (agent l_test_set.clean (l_test.is_exceptional))
				create {EQA_RESULT} Result.make (l_start_date, l_prepare, l_test, l_clean, buffer.formatted_content)
			else
				create Result.make (l_start_date, l_prepare, buffer.formatted_content)
			end
			if l_old = Void then
				io.set_output_default
			else
				io.set_file_default (l_old)
			end
			change_working_path (l_old_work_dir)
			buffer.wipe_out
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	execute_test_stage (a_procedure: ROUTINE): EQA_TEST_INVOCATION_RESPONSE
			-- Execute one stage of a test execution and return the corresponding invocation response.
			--
			-- `a_procedure': Procedure to call.
			-- `Result': Invocation response describing the outcome of calling `a_procedure'.
		require
			a_procedure_attached: a_procedure /= Void
			a_procedure_expects_not_operands: a_procedure.valid_operands (Void)
		local
			l_response: detachable like execute_test_stage
			l_iexcept: EQA_TEST_INVOCATION_EXCEPTION
		do
			if l_response = Void then
				a_procedure.call (Void)
				create l_response.make
			end
			Result := l_response
		rescue
			check attached exception_manager.last_exception as l_exception then
				create l_iexcept.make (l_exception, class_name_8_of_type (({G}).type_id), Void)
				create l_response.make_exceptional (l_iexcept)
			end
			retry
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
