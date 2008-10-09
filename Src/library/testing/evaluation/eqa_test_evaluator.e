indexing
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

	last_outcome: ?EQA_TEST_OUTCOME
			-- Outcome last produced by `execute'

feature {NONE} -- Access

	buffer: EQA_TEST_OUTPUT_BUFFER
			-- Buffer for recording output
		once
			create Result.make (2048)
		end

feature -- Status report

	record_output: BOOLEAN
			-- Shall output produced by tests be recorded in responses of `last_outcome'

feature {NONE} -- Status report

	last_invocation_response: ?EQA_TEST_INVOCATION_RESPONSE
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

	frozen execute (a_test_set: !EQA_TEST_SET; a_test: PROCEDURE [ANY, TUPLE [EQA_TEST_SET]]) is
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
			-- `a_p': Procedure taking `a_tc' as an operand and invokes the corresponding test procedure.
		require
			valid_test_set: a_test.valid_operands ([a_test_set])
		local
			l_tuple: TUPLE [EQA_TEST_SET]
			l_prepare, l_test, l_clean: !like last_invocation_response
		do
			safe_execute (agent a_test_set.prepare)
			l_prepare ?= last_invocation_response
			if not last_invocation_response.is_exceptional then
				l_tuple := a_test.empty_operands
				check
					valid_tuple_count: l_tuple.valid_index (1)
					valid_for_tuple: l_tuple.valid_type_for_index (a_test_set, 1)
				end
				l_tuple.put (a_test_set, 1)
				safe_execute (agent a_test.call (l_tuple))
				l_test ?= last_invocation_response
				safe_execute (agent a_test_set.clean)
				l_clean ?= last_invocation_response
				create last_outcome.make (l_prepare, l_test, l_clean, create {DATE_TIME}.make_now)
			else
				create last_outcome.make_with_setup (l_prepare, create {DATE_TIME}.make_now)
			end
		end

feature {NONE} -- Implementation

	safe_execute (a_procedure: !PROCEDURE [ANY, TUPLE]) is
			-- Execute `procedure' in a protected way.
		require
			buffer_empty: buffer.is_empty
		local
			l_retry: BOOLEAN
			l_old: PLAIN_TEXT_FILE
			l_excpt: !EXCEPTION
			l_type, l_rec, l_tag, l_trace: !STRING
			l_dtype: INTEGER
			l_texcpt: !EQA_TEST_INVOCATION_EXCEPTION
		do
			if not l_retry then
				l_old := io.default_output
				if record_output then
					io.set_file_default (buffer)
				end
				a_procedure.apply
				create last_invocation_response.make_normal (buffered_output)
			end
			io.set_file_default (l_old)
			buffer.wipe_out
		ensure
			last_invocation_response_attached: last_invocation_response /= Void
		rescue
			l_retry := True
			l_excpt ?= exception_manager.last_exception
			if l_excpt.type_name = Void or else l_excpt.type_name.is_empty then
				create l_type.make_empty
				l_dtype := -1
			else
				create l_type.make_from_string (l_excpt.type_name)
				l_dtype := dynamic_type_from_string (l_type)
			end
			if l_excpt.recipient_name = Void then
				create l_rec.make_empty
			else
				create l_rec.make_from_string (l_excpt.recipient_name)
			end
			if l_excpt.message = Void then
				create l_tag.make_empty
			else
				create l_tag.make_from_string (l_excpt.message)
			end
			if l_excpt.exception_trace = Void then
				create l_trace.make_empty
			else
				create l_trace.make_from_string (l_excpt.exception_trace)
			end
			create l_texcpt.make (l_excpt.code, l_rec, l_type, l_dtype, l_tag, l_trace)
			create last_invocation_response.make_exceptional (buffered_output, l_texcpt)
			retry
		end

	buffered_output: !STRING
			-- Output buffered by `buffer'
			--
			-- Note: if output was truncated, add string indicating so.
		do
			if buffer.is_truncated then
				create Result.make (buffer.buffer_size + 100)
				Result.append (buffer.leading_content)
				Result.append ("%N%N---------------------------%N")
				Result.append ("Truncated section%N")
				Result.append ("---------------------------%N%N")
				Result.append (buffer.closing_content)
			else
				Result := buffer.content
			end
		end

end
