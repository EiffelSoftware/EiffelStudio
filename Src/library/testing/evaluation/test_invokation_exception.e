indexing
	description: "[
		Represents an exception that occurred during the execution
		of an eiffel test
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INVOKATION_EXCEPTION

inherit
	EXCEP_CONST

create
	make

feature {NONE} -- Initialization

	make (a_code: like code; a_recipient_name: like recipient_name; a_class_name: like class_name;
	      a_tag_name: like tag_name; a_trace: like trace) is
			-- Initialize `Current'.
			--
			-- `a_code': Code defining type of exception (as in {EXCEP_CONST})
		require
			a_code_valid: valid_code (a_code)
		do
			code := a_code
			recipient_name := a_recipient_name
			class_name := a_class_name
			tag_name := a_tag_name
			trace := a_trace
			parse_trace
		ensure
			code_set: code = a_code
			recipient_name_set: recipient_name = a_recipient_name
			class_name_set: class_name = a_class_name
			tag_name_set: tag_name = a_tag_name
			trace_set: trace = a_trace
		end

feature -- Access

	code: INTEGER
			-- Exception code

	recipient_name: !STRING
			-- Name of the feature that triggered the exception

	class_name: !STRING
			-- Name of the class in which the exception occurred

	tag_name: !STRING
			-- Tag describing the exception

	trace: !STRING
			-- Text based representation of the stack trace

	trace_depth: NATURAL
			-- Depth of exception trace stored in `exception_trace' (without interpreter frames)

feature {NONE} -- Access

	erl_class_imp: STRING is "TEST_INTERPRETER_"
	function: STRING is "FUNCTION"
	predicate: STRING is "PREDICATE"
	procedure: STRING is "PROCEDURE"
	dash_line: STRING is "-------------------------------------------------------------------------------"
			-- Constants for used to parse trace

feature {NONE} -- Status setting

	parse_trace
			-- Parse `exception_trace' and update `trace_depth' and `exception_break_point_slot' accordingly.
		local
			l_list: !LIST [!STRING]
			l_found: BOOLEAN
		do
			l_list ?= trace.split ('%N')
			if l_list.count >= 5 then
				l_list.start
				go_after_next_dash_line (l_list)
				go_after_next_dash_line (l_list)

				from
					trace_depth := 0
				until
					l_list.off or l_found
				loop
					if is_test_interpreter_line (l_list.item_for_iteration) then
						l_found := True
					else
						trace_depth := trace_depth + 1
						go_after_next_dash_line (l_list)
					end
				end
			else
				-- Something is wrong the the trace.
				-- Not exactly sure what to do. For now we leave `trace_depth' and `exception_break_point_slot' to their default values.
			end

		end

	go_after_next_dash_line (a_list: !LIST [!STRING]) is
		require
			a_list_not_off: not a_list.off
		local
			l_found: BOOLEAN
		do
			from
			until
				l_found or a_list.off
			loop
				if a_list.item_for_iteration.is_equal (dash_line) then
					l_found := True
				end
				a_list.forth
			end
		end

	is_test_interpreter_line (v: !STRING): BOOLEAN is
			-- Is `v' a stack line describing a frame in an TEST_INTERPRETER_* class?
		do
			Result := v.count > erl_class_imp.count and then
					(v.substring (1, erl_class_imp.count).is_equal (erl_class_imp))
		end

	is_routine_fast_line (v: !STRING): BOOLEAN is
			-- Is `v' a stack line describing a frame in an `ROUTINE.fast_*' class?
		local
			l_list: !LIST [!STRING]
			l_string: !STRING
		do
			l_list ?= v.split (' ')
			if l_list.count = 2 then
				l_list.start
				l_string := l_list.item_for_iteration
				if
					l_string.is_equal (function) or
					l_string.is_equal (predicate) or
					l_string.is_equal (procedure)
				then
					l_list.forth
					l_string := l_list.item_for_iteration
					Result := l_string.is_equal ("fast_item") or l_string.is_equal ("fast_call")
				end
			end
		end

invariant
	code_valid: valid_code (code)
	trace_depth_not_negative: trace_depth >= 0

end
