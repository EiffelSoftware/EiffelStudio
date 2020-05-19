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

	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

create
	make

feature {NONE} -- Initialization

	make (a_exception: EXCEPTION; a_class_name, a_feature_name: detachable READABLE_STRING_8)
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
			if attached a_exception.type_name as l_type then
				class_name := l_type.string
			else
				create {STRING_8} class_name.make_empty
			end
			if attached a_exception.recipient_name as l_rec then
				recipient_name := l_rec.string
			else
				create {STRING_8} recipient_name.make_empty
			end
			if attached a_exception.description as l_tag then
				create {IMMUTABLE_STRING_32} tag_name.make_from_string_general (l_tag)
			else
				create {IMMUTABLE_STRING_32} tag_name.make_empty
			end
			if attached a_exception.trace as l_trace and then not l_trace.is_empty then
				parse_trace (l_trace, a_class_name, a_feature_name)
			else
				create {IMMUTABLE_STRING_32} trace.make_empty
			end
		end

	parse_trace (a_trace: like trace; a_class_name, a_feature_name: detachable READABLE_STRING_8)
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
			l_prev, l_found, l_bp_set: BOOLEAN
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
					parse_frame (a_trace, i)
					if not l_bp_set then
						break_point_slot := last_break_point_slot
						l_bp_set := True
					end
					if attached last_class_name as l_cn then
						if
							l_cn.same_string_general (a_class_name) and
							(a_feature_name /= Void implies (attached last_routine_name as l_rn and then l_rn.same_string_general (a_feature_name)))
						then
							l_found := True
							l_prev := True
						elseif l_prev then
							l_last := i - 1
							l_prev:= False
						end
						i := go_after_next_dash_line (a_trace, i)
					else
						i := 0
					end
				end

				if l_found then
					if code = precondition then
						is_test_invalid := l_depth <= 2
					else
						is_test_invalid := l_depth <= 1
					end
					if l_prev then
							-- Note: special case where the last frame was a feature of the test class
						l_last := a_trace.count
					end
					is_trace_valid := True
				else
					is_test_invalid := True
					l_last := a_trace.count
				end
			else
				parse_frame (a_trace, i)
				break_point_slot := last_break_point_slot
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

	tag_name: READABLE_STRING_32
			-- Tag describing the exception

	trace: READABLE_STRING_32
			-- Text based representation of the stack trace

	break_point_slot: INTEGER
			-- Break point slot in exception recipient that triggered exception;
			-- Note that the number of slots available in a routine may change depending
			-- on the level of assertion monitoring.

feature {NONE} -- Access: parsing

	last_class_name: detachable like trace
			-- Class name last parsed through `parse_frame'

	last_routine_name: detachable like trace
			-- Routine name last parsed through `parse_frame'

	last_break_point_slot: like break_point_slot
			-- Last breakpoint slot parsed by `is_trace_valid', zero if slot information could not be found.

feature -- Status report

	is_trace_valid: BOOLEAN
			-- Does `trace' have an expected format?
			--
			-- Note: is provided class/feature name in creation procedure was not found in exception trace,
			--       `trace' will contain the original exception trace and `is_trace_valid' will be False.

	is_test_invalid: BOOLEAN
			-- Does this exception show that the associated test is invalid.
			-- An invalid test happens when the system is not brought into a state
			-- suitable to test the feature under test. For example, if the precondition
			-- of the feature under test is not satisfied.

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

	parse_frame (a_trace: like trace; a_position: INTEGER)
			-- Parse current frame in stack trace and set `last_class', `last_routine' and
			-- `last_break_point_slot' accordingly.
			--
			-- `a_trace': Complete stack trace.
			-- `a_position': Position in `a_trace' where current frame begins.
		require
			a_trace_attached: a_trace /= Void
			a_position_valid: a_position > 0 and a_position <= a_trace.count
		local
			i, j, l_count, l_bp: INTEGER
			l_done: BOOLEAN
			l_substring: like trace
			c: CHARACTER_32
		do
			last_class_name := Void
			last_routine_name := Void
			last_break_point_slot := 0
			from
				j := a_position
				l_count := a_trace.count
			until
				l_done
			loop
				from
					i := j
				until
					j > l_count or else (a_trace.item (j).is_space and i < j)
				loop
					c := a_trace.item (j)
					j := j + 1
					if c.is_space or c = '@' then
						i := j
					end
				end
				if i < j then
					l_substring := a_trace.substring (i, j - 1)
					if last_class_name = Void then
						last_class_name := l_substring
					elseif last_routine_name = Void then
						last_routine_name := l_substring
					else
						if l_substring.is_integer then
							l_bp := l_substring.to_integer
							if l_bp > 0 then
								last_break_point_slot := l_bp
							end
						end
						l_done := True
					end
				else
					l_done := True
				end
			end
		end

feature {NONE} -- Constants

	dash_line: STRING_32 = "-------------------------------------------------------------------------------%N"

	class_attribute_name: STRING_8 = "class_name"
	recipient_attribute_name: STRING_8 = "internal_exception"
	tag_attribute_name: STRING_8 = "tag_name"
	trace_attribute_name: STRING_8 = "trace"
			-- Name of attributes in `Current'

feature -- Mismatch Correnction

	correct_mismatch
			-- <Precursor>
		do
			if
				attached {like class_name} mismatch_information.item (class_attribute_name) as l_class and
				attached {like recipient_name} mismatch_information.item (recipient_attribute_name) as l_recipient and
				attached {like tag_name} mismatch_information.item (tag_attribute_name) as l_tag and
				attached {like trace} mismatch_information.item (trace_attribute_name) as l_trace
			then
				create {STRING_8} class_name.make_from_string (l_class)
				create {STRING_8} recipient_name.make_from_string (l_recipient)
				create {IMMUTABLE_STRING_32} tag_name.make_from_string (l_tag)
				create {IMMUTABLE_STRING_32} trace.make_from_string (l_trace)
			else
				Precursor
			end
		end

invariant
	code_valid: valid_code (code)
	recipient_name_attached: recipient_name /= Void
	class_name_attached: class_name /= Void
	tag_attached: tag_name /= Void
	trace_attached: trace /= Void
	exception_break_point_slot_positive: break_point_slot >= 0

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
