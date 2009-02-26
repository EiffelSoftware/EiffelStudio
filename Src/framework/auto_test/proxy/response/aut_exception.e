note
	description:

		"Exception"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_EXCEPTION

inherit
	ANY

	EXCEP_CONST
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (an_exception_code: like code;
		  an_exception_recipient_name:  like recipient_name;
		  an_exception_class_name: like class_name;
		  an_exception_tag_name: like tag_name;
		  an_inv_violation_on_entry_flag: BOOLEAN;
		  an_exception_trace: like trace)
			-- Create new exception.
		require
			an_exception_code_valid: valid_code (an_exception_code)
			an_exception_recipient_name_not_void: an_exception_recipient_name /= Void
			an_exception_class_name_not_void: an_exception_class_name /= Void
			an_exception_tag_name_not_void: an_exception_tag_name /= Void
			an_exception_trace_not_void: an_exception_trace /= Void
		do
			code := an_exception_code
			recipient_name := an_exception_recipient_name
			class_name := an_exception_class_name
			tag_name := an_exception_tag_name
			trace := an_exception_trace
			set_is_invariant_violation_on_feature_entry (an_inv_violation_on_entry_flag)
			parse_trace
		ensure
			exception_code_set: code = an_exception_code
			exception_recipient_name_set: recipient_name = an_exception_recipient_name
			exception_class_name_set: class_name = an_exception_class_name
			exception_tag_name_set: tag_name = an_exception_tag_name
			exception_trace_set: trace = an_exception_trace
		end

feature -- Access

	code: INTEGER
			-- Code of exception

	recipient_name: STRING
			-- Name of exception's recipient

	break_point_slot: INTEGER
			-- Break point slot in exception recipient that triggered exception;
			-- Note that the number of slots available in a routine may change depending
			-- on the level of assertion monitoring.

	class_name: STRING
			-- Name of exception's class name

	tag_name: STRING
			-- Name of exception's tag name

	trace: STRING
			-- Stack trace of exception

	name: STRING
			-- Name of `exception'
		do
			if code = Void_call_target then
				Result := "Void_call_target"
			elseif code = No_more_memory then
				Result := "No_more_memory"
			elseif code = Precondition then
				Result := "Precondition"
			elseif code = Postcondition then
				Result := "Postcondition"
			elseif code = Floating_point_exception then
				Result := "Floating_point_exception"
			elseif code = Class_invariant then
				Result := "Class_invariant"
			elseif code = Check_instruction then
				Result := "Check_instruction"
			elseif code = Routine_failure then
				Result := "Routine_failure"
			elseif code = Incorrect_inspect_value then
				Result := "Incorrect_inspect_value"
			elseif code = Loop_variant then
				Result := "Loop_variant"
			elseif code = Loop_invariant then
				Result := "Loop_invariant"
			elseif code = Signal_exception then
				Result := "Signal_exception"
			elseif code = eiffel_runtime_panic then
				Result := "Eiffel_runtime_panic"
			elseif code = Rescue_exception then
				Result := "Rescue_exception"
			elseif code = out_of_memory then
				Result := "Out_of_memory"
			elseif code = resumption_failed then
				Result := "Resumption_failed"
			elseif code = create_on_deferred then
				Result := "Create_on_deferred"
			elseif code = External_exception then
				Result := "External_exception"
			elseif code = Void_assigned_to_expanded then
				Result := "Void_assigned_to_expanded"
			elseif code = exception_in_signal_handler then
				Result := "Exception_in_signal_handler"
			elseif code = Io_exception then
				Result := "Io_exception"
			elseif code = Operating_system_exception then
				Result := "Operating_system_exception"
			elseif code = Retrieve_exception then
				Result := "Retrieve_exception"
			elseif code = Developer_exception then
				Result := "Developer_exception"
			elseif code = eiffel_runtime_fatal_error then
				Result := "Eiffel_runtime_fatal_error"
			elseif code = dollar_applied_to_melted_feature then
				Result := "Dollar_applied_to_melted_feature"
			elseif code = Runtime_io_exception then
				Result := "Runtime_io_exception"
			elseif code = Com_exception then
				Result := "Com_exception"
			elseif code = Runtime_check_exception then
				Result := "Runtime_check_exception"
			elseif code = old_exception then
				Result := "Old_exception"
			elseif code = serialization_exception then
				Result := "Serialization_exception"
			end
		end

	trace_depth: INTEGER
			-- Depth of exception trace stored in `trace' (without interpreter frames)

feature -- Status report

	is_invariant_violation_on_feature_entry: BOOLEAN
			-- Does this exception contain a class invariant violation
			-- on entry of the testee feature?

feature -- Setting

	set_is_invariant_violation_on_feature_entry (b: BOOLEAN) is
			-- Set `is_invariant_violation_on_feature_entry' with `b'.
		do
			is_invariant_violation_on_feature_entry := b
		ensure
			is_invariant_violation_on_feature_entry_set: is_invariant_violation_on_feature_entry = b
		end

feature {NONE} -- Implementation

	parse_trace
			-- Parse `trace' and update `trace_depth' and `break_point_slot' accordingly.
		local
			line_splitter: ST_SPLITTER
			list: DS_LIST [STRING]
			cs: DS_LIST_CURSOR [STRING]
			erl_frame_found: BOOLEAN
			s: STRING
		do
			create line_splitter.make
			line_splitter.set_separators ("%N")
			list := line_splitter.split (trace)
			if list.count >= 5 then
				cs := list.new_cursor
				cs.start
				go_after_next_dash_line (cs)
				go_after_next_dash_line (cs)


				break_point_slot_regexp.match (cs.item)
				if break_point_slot_regexp.has_matched then
					s := break_point_slot_regexp.captured_substring (1)
					if s.is_integer then
						break_point_slot := s.to_integer
					end
				end

				from
					trace_depth := 0
				until
					cs.off or erl_frame_found
				loop
					if
						is_erl_class_imp_line (cs.item)
					then
						erl_frame_found := True
					else
						trace_depth := trace_depth + 1
						go_after_next_dash_line (cs)
					end
				end
				cs.go_after
			else
				-- Something is wrong the the trace.
				-- Not exactly sure what to do. For now we leave `trace_depth' and `break_point_slot' to their default values.
			end

		end

	go_after_next_dash_line (a_cs: DS_LINEAR_CURSOR [STRING])
		require
			a_cs_not_void: a_cs /= Void
			a_cs_not_off: not a_cs.off
		local
			dash_line_found: BOOLEAN
		do
			from
			until
				dash_line_found or a_cs.off
			loop
				if a_cs.item.is_equal (dash_line) then
					dash_line_found := True
				end
				a_cs.forth
			end
		end

	interpreter_class: STRING = "ITP_INTERPRETER"
	dash_line: STRING = "-------------------------------------------------------------------------------"

	is_erl_class_imp_line (v: STRING): BOOLEAN
			-- Is `v' a stack line describing a frame in an ERL_CLASS_IMP_* class?
		require
			v_not_void: v /= Void
		do
			Result := v.count > interpreter_class.count and then
					(v.substring (1, interpreter_class.count).is_equal (interpreter_class))
		end

	break_point_slot_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression to match the break point slot of a line
			-- from a stack trace
		once
			create Result.make
			Result.compile (".*@(\d+)")
		end

invariant

	exeception_recipient_name_not_void: recipient_name /= Void
	exception_class_name_not_void: class_name /= Void
	exception_tag_name_not_void: tag_name /= Void
	exception_trace_not_void: trace /= Void
	exception_break_point_slot_positive: break_point_slot >= 0
	trace_depth_positive: trace_depth >= 0

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
