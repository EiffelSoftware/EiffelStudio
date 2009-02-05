note
	description: "[
		Objects representing an exception raised while invoking a test class and/or feature.
		
		Note: {EQA_TEST_INVOCATION_EXCEPTION} does not only contain the exception information, it also
		      analyses the stack trace to determine whether the implementation or the test code is
		      to blame.

		TODO: Take stack frames of agent calls into account, meaning that even though {PROCEDURE}.fast_call
		      causes a precondition violation, the stack frame calling the agent is to blame.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_INVOCATION_EXCEPTION

inherit
	ANY

	EXCEP_CONST
		export
			{NONE} all
		end

	INTERNAL
		rename
			class_name as class_name_from_object,
			dynamic_type as dynamic_type_from_object
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_exception: EXCEPTION; a_class_name, a_feature_name: ?READABLE_STRING_8)
			-- Initialize `Current'.
			--
			-- Note: If `a_test_class_name' is attached, the stack trace will be truncated after the last
			--       frame containing a call to the class (if `a_test_feature_name' the feature name of the
			--       stack frame is also considered). In addition it will be determined, whether the class
			--       `a_class_name' (or feature `a_feature_name' if provided) is to blame, or any routine
			--       further down the call stack.
			--       If `a_test_class_name' is Void, the complete trace will be made available in `trace'.
			--
			-- `a_exception': Original exception object.
			-- `a_class_name': Name of test class in which exception was raised, or Void.
			-- `a_feature_name': Name of test feature in which exception was raised, or Void.
		require
			a_exception_attached: a_exception /= Void
			a_feature_name_attached_implies_a_class_name_attached: a_feature_name /= Void implies a_class_name /= Void
			a_feature_name_not_empty: a_feature_name /= Void implies not a_feature_name.is_empty
		do
			code := a_exception.code
			if {l_type: like class_name} a_exception.type_name then
				class_name := l_type.string
			else
				create {STRING_8} class_name.make_empty
			end
			if {l_rec: like recipient_name} a_exception.recipient_name then
				recipient_name := l_rec.string
			else
				create {STRING_8} recipient_name.make_empty
			end
			if {l_tag: like tag_name} a_exception.message then
				tag_name := l_tag.string
			else
				create {STRING_8} tag_name.make_empty
			end
			if {l_trace: like trace} a_exception.exception_trace and then not l_trace.is_empty then
				parse_trace (l_trace, a_class_name, a_feature_name)
			else
				create {STRING_8} trace.make_empty
			end
		end

	parse_trace (a_trace: like trace; a_class_name, a_feature_name: ?READABLE_STRING_8)
			-- Initialize trace from original trace by cutting off routines which invoked testing routine.
			--
			-- `a_trace': Original exception trace.
			-- `a_class_name': Name of test class in which exception was raised, or Void.
			-- `a_feature_name': Name of test feature in which exception was raised, or Void.
		require
			a_trace_not_empty: a_trace /= Void and then not a_trace.is_empty
			a_feature_name_attached_implies_a_class_name_attached: a_feature_name /= Void implies a_class_name /= Void
			a_feature_name_not_empty: a_feature_name /= Void implies not a_feature_name.is_empty
			code_valid: valid_code (code)
		local
			i, l_last, l_depth: INTEGER
			l_prev, l_found: BOOLEAN
		do
				-- `i': Cursor position in `a_trace'
				-- `l_last': Last character in `a_trace' which will be added to truncated `trace'
				-- `l_depth': Position of first frame containing feature of `a_class_name'
				-- `l_prev': Was the previous stack frame a feature of `a_class_name'?
				-- `l_found': Has any frame been passed yet for `a_class_name'?

				-- Go to first stack frame
			i := go_after_next_dash_line (a_trace, 1)
			i := go_after_next_dash_line (a_trace, i)

			if a_class_name /= Void then
					-- Go to last frame for `a_class_name' and `a_feature_name'
				from until
					i = 0
				loop
					if not l_found then
						l_depth := l_depth + 1
					end
					if is_frame_of_class (a_trace, i, a_class_name, a_feature_name) then
						l_found := True
						l_prev := True
					elseif l_prev then
						l_last := i - 1
						l_prev := False
					end
					i := go_after_next_dash_line (a_trace, i)
				end

				if l_found then
					if code = precondition then
						is_test_exceptional := l_depth <= 2
					else
						is_test_exceptional := l_depth <= 1
					end
					if l_prev then
							-- Note: special case where the last frame was a feature of the test class
						l_last := a_trace.count
					end
					is_trace_valid := True
				else
					is_test_exceptional := True
					l_last := a_trace.count
				end
			else
				is_trace_valid := i > 0
				l_last := a_trace.count
			end

			trace := a_trace.substring (1, l_last)
		end

feature -- Access

	code: INTEGER
			-- Exception code

	recipient_name: READABLE_STRING_8
			-- Name of the feature that triggered the exception

	class_name: READABLE_STRING_8
			-- Name of the class in which the exception occurred

	tag_name: READABLE_STRING_8
			-- Tag describing the exception

	trace: READABLE_STRING_8
			-- Text based representation of the stack trace

feature -- Status report

	is_trace_valid: BOOLEAN
			-- Does `trace' have an expected format?
			--
			-- Note: is provided class/feature name in creation procedure was not found in exception trace,
			--       `trace' will contain the original exception trace and `is_trace_valid' will be False.

	is_test_exceptional: BOOLEAN
			-- Is recipient of exception a feature of the test class?

feature {NONE} -- Implementation

	go_after_next_dash_line (a_trace: like trace; a_start: INTEGER): INTEGER
			-- Index of character immediatly after next occurance of `dash_line'.
			--
			-- Note: If `a_start' is 0, `Result' will automatically be 0 as well. This allows
			--       `go_after_next_dash_line' to be called iteratively without checking the result.
			--
			-- `a_trace': Trace containing stack frames.
			-- `a_start': Start position from which next stack frame will be located.
			-- `Result': Contains index of first character of next stack frame, or 0 if no frame found.
		require
			a_start_valid: a_start >= 0 and a_start <= a_trace.count
		local
			i, l_count: INTEGER
		do
			if a_start > 0 then
				l_count := dash_line.count

					-- Check if `a_start' is currently pointing to a `dash_line' in `a_trace'
				if dash_line.has (a_trace.item (a_start)) then
					i := (a_start - l_count - 1).max (1)
				else
					i := a_start
				end
				i := a_trace.substring_index (dash_line, i)
				if i > 0 then
					Result := i + l_count
					if Result > a_trace.count then
						Result := 0
					end
				end
			end
		ensure
			result_valid: Result = 0 or else (Result > a_start and then Result <= a_trace.count)
			start_zero_implies_result_zero: a_start = 0 implies Result = 0
		end

	is_frame_of_class (a_trace: like trace; a_position: INTEGER; a_class_name: READABLE_STRING_8; a_feature_name: ?READABLE_STRING_8): BOOLEAN
			-- Does stack frame represent call to test routine?
			--
			-- `a_trace': Complete exception trace.
			-- `a_position': Start position of current stack frame.
			-- `a_class_name': Test class name.
			-- `a_feature_name': Name of test feature in which exception was raised, or Void.
			-- `Result': True is current stack frame calls test routine, False otherwise.
		require
			a_position_valid: a_position > 0 and a_position <= a_trace.count
			a_class_name_attached: a_class_name /= Void
			a_class_name_not_empty: not a_class_name.is_empty
			a_feature_name_not_empty: a_feature_name /= Void implies not a_feature_name.is_empty
		local
			i, l_count, l_after: INTEGER
		do
			l_after := a_position + a_class_name.count
			if a_trace.substring_index_in_bounds (a_class_name, a_position, l_after - 1) = a_position then
				l_count := a_trace.count
				Result := l_after > l_count or else a_trace.item (l_after).is_space
				if a_feature_name /= Void then
					from
						i := l_after
					until
						i > l_count or else not a_trace.item (i).is_space
					loop
						i := i + 1
					end
					l_after := i + a_feature_name.count
					Result := l_after - 1 <= l_count and then
						a_trace.substring_index_in_bounds (a_feature_name, i, l_after - 1) = i and then
						(l_after > l_count or else a_trace.item (l_after).is_space)
				end
			end
		end

feature {NONE} -- Constants

	dash_line: STRING = "-------------------------------------------------------------------------------%N"

invariant
	code_valid: valid_code (code)
	recipient_name_attached: recipient_name /= Void
	class_name_attached: class_name /= Void
	tag_attached: tag_name /= Void
	trace_attached: trace /= Void

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
