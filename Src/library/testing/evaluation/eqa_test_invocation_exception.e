note
	description: "[
		Represents an exception that occurred during the execution
		of an Eiffel test
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

	make (a_exception: EXCEPTION; a_class_name: READABLE_STRING_8)
			-- Initialize `Current'.
			--
			-- `a_exception': Original exception object.
			-- `a_class_name': Name of test class in which exception was raised.
		require
			a_exception_attached: a_exception /= Void
			a_class_name_attached: a_class_name /= Void
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
				parse_trace (l_trace, a_class_name)
			else
				create {STRING_8} trace.make_empty
			end
		end

	parse_trace (a_trace: like trace; a_class_name: READABLE_STRING_8)
			-- Initialize trace from original trace by cutting off routines which invoked testing routine.
			--
			-- `a_trace': Original exception trace.
			-- `a_class_name': Name of test class in which exception was raised.
		require
			a_trace_not_empty: a_trace /= Void and then not a_trace.is_empty
			a_class_name_attached: a_class_name /= Void
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
			i := next_frame (a_trace, 1)
			i := next_frame (a_trace, i)

				-- Go to last frame for `a_class_name' and `a_routine_name'
			from until
				i = 0
			loop
				if not l_found then
					l_depth := l_depth + 1
				end
				if is_frame_of_class (a_trace, i, a_class_name) then
					l_found := True
					l_prev := True
				elseif l_prev then
					l_last := i - 1
					l_prev := False
				end
				i := next_frame (a_trace, i)
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
			else
				is_test_exceptional := True
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

	is_test_exceptional: BOOLEAN
			-- Is recipient of exception a feature of the test class?

feature {NONE} -- Implementation

	next_frame (a_trace: like trace; a_start: INTEGER): INTEGER
			-- Start index of next stack frame
			--
			-- Note: if `a_start' is 0, `Result' will be 0 as well. This allows `next_frame' to be called
			--       iterratively without checking the result.
			--
			-- `a_trace': Trace containing stack frames.
			-- `a_start': Start position from which next stack frame will be searched.
			-- `Result': Contains index of first character of next stack frame, or 0 if no frame found.
		require
			a_start_valid: a_start >= 0 and a_start <= a_trace.count
		local
			i, l_count: INTEGER
		do
			from
				l_count := dash_line.count
				i := a_start
			until
				Result > 0 or i = 0
			loop
				if a_trace.item (i) = '%N' and
				   i > l_count and then
				   a_trace.substring_index_in_bounds (dash_line, i - l_count + 1, i) /= 0
				then
					Result := i + 1
					if i >= a_trace.count then
						i := 0
						Result := 0
					end
				else
					i := a_trace.index_of ('%N', i + 1)
				end
			end
		ensure
			result_valid: Result = 0 or else (Result > a_start and then Result <= a_trace.count)
		end

	is_frame_of_class (a_trace: like trace; a_position: INTEGER; a_class_name: READABLE_STRING_8): BOOLEAN
			-- Does stack frame represent call to test routine?
			--
			-- `a_trace': Complete exception trace.
			-- `a_position': Start position of current stack frame.
			-- `a_class_name': Test class name.
			-- `Result': True is current stack frame calls test routine, False otherwise.
		require
			a_position_valid: a_position > 0 and a_position <= a_trace.count
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
		do
			Result := a_trace.substring_index_in_bounds (a_class_name + " ", a_position, a_position + a_class_name.count + 1) > 0
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
