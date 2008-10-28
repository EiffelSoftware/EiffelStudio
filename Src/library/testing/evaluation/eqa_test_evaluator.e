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
			l_operands: TUPLE
		do
			if not l_retry then
				l_old := io.default_output
				if record_output then
					io.set_file_default (buffer)
				end
				a_procedure.apply
				create last_invocation_response.make_normal (buffered_output)
				buffer.wipe_out
			end
			io.set_file_default (l_old)
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
				l_trace := relevant_trace_representation (l_excpt.exception_trace.as_attached)
			end
			create l_texcpt.make (l_excpt.code, l_rec, l_type, l_dtype, l_tag, l_trace)
			create last_invocation_response.make_exceptional (buffered_output, l_texcpt)
			buffer.wipe_out
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
				Result.append (m_truncated)
				Result.append (buffer.closing_content)
			else
				Result := buffer.content
			end
		end

	relevant_trace_representation (a_trace: !STRING): !STRING
			-- Relevant representation of original stack trace
			--
			-- `a_trace': Original stack trace.
		local
			l_lines: !LIST [!STRING]
			l_current: !STRING
			l_valid: BOOLEAN
			i, l_header: INTEGER
		do
			l_lines := a_trace.split ('%N').as_attached
			create Result.make (a_trace.count)
			from
				i := 1
				l_lines.start
				go_after_next_separator (l_lines)
				go_after_next_separator (l_lines)
				l_valid := not l_lines.off
				if l_valid then
					l_header := l_lines.index - 1
				end
			until
				i > l_lines.count or l_lines.off or not l_valid
			loop
				l_current := l_lines.item_for_iteration
				if is_invocation_of (l_lines, m_procedure_name, Void) then
					go_after_next_separator (l_lines)

					-- Note: following lines could be used to remove the leading part of the trace caused by
					--       {EQA_ASSERTIONS}.raise

--				elseif is_invocation_of (l_lines, a_asserter, "raise") then
--					go_after_next_separator (l_lines)
--					Result.wipe_out
--					append_lines (l_lines, Result, 1, l_header)
--					if l_lines.off then
--						i := l_lines.count + 1
--					else
--						i := l_lines.index
--					end

				elseif l_current.substring_index_in_bounds (m_evaluator_name, 1, m_evaluator_name.count) = 1 then
					i := l_lines.count + 1
				else
					go_after_next_separator (l_lines)
					if l_lines.off then
						append_lines (l_lines, Result, i, l_lines.count)
						i := l_lines.count + 1
					else
						append_lines (l_lines, Result, i, l_lines.index - 1)
						i := l_lines.index
					end
				end
			end
			if not l_valid or Result.is_empty then
				Result := a_trace
			elseif i <= l_lines.count then
				append_lines (l_lines, Result, i, l_lines.count)
			end
		end

	go_after_next_separator (a_list: !LIST [!STRING])
			-- Go to item after next item equal to `m_separator'.
		local
			l_found: BOOLEAN
		do
			from
			until
				l_found or a_list.off
			loop
				l_found := a_list.item_for_iteration.is_equal (m_separator)
				a_list.forth
			end
		end

	append_lines (a_list: !LIST [!STRING]; a_string: !STRING; a_start, a_end: INTEGER)
			-- Append lines from `a_list' to `a_string' up to current position of `a_list'
		require
			valid_start: a_start > 0 and then a_start <= a_list.count
			valid_end: a_end >= a_start and then a_end <= a_list.count
		local
			i: INTEGER
		do
			from
				i := a_start
			until
				i > a_end
			loop
				a_string.append (a_list.i_th (i))
				a_string.append_character ('%N')
				i := i + 1
			end
		end

	is_invocation_of (a_lines: !LIST [!STRING]; a_class:!STRING; a_feature: ?STRING): BOOLEAN
		require
			a_lines_not_off: not a_lines.off
			a_class_not_empty: a_class /= Void
			a_feature_not_empty: a_feature /= Void implies a_feature.is_empty
		local
			l_current: ?STRING
		do
			l_current := a_lines.item_for_iteration
			Result := l_current.substring_index_in_bounds (a_class, 1, a_class.count) = 1 and then
				(l_current.count = a_class.count or else l_current.item (a_class.count + 1) = ' ')
			if Result then
				if a_feature /= Void then
					if l_current.count > a_class.count then
						l_current := l_current.substring (a_class.count + 1, l_current.count)
					elseif not a_lines.islast then
						create l_current.make_from_string (a_lines.i_th (a_lines.index + 1))
					else
						l_current := Void
					end
					if l_current /= Void then
						l_current.left_adjust
						Result := l_current.starts_with (a_feature) and then
							(l_current.count = a_feature.count or else l_current.item (a_feature.count + 1) = ' ')
					else
						Result := False
					end
				end
			end
		end

feature {NONE} -- Constants

	m_truncated: !STRING = "%N%N---------------------------%NTruncated section%N---------------------------%N%N"
	m_separator: !STRING = "-------------------------------------------------------------------------------"

	m_evaluator_name: !STRING
		once
			Result := generator.as_attached
		end

	m_procedure_name: !STRING
		once
			Result := (agent do_nothing).generator.as_attached
		end

	m_default_asserter_name: STRING
		once
			Result := (create {EQA_ASSERTIONS}).generator.as_attached
		end

end
