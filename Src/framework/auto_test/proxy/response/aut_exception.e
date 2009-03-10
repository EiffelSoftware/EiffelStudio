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

	EQA_TEST_INVOCATION_EXCEPTION
		rename
			make as make_old
		end

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
			parse_trace (trace, {AUT_SHARED_INTERPRETER_INFO}.interpreter_root_class_name, {AUT_SHARED_INTERPRETER_INFO}.feature_name_for_byte_code_injection)
			is_test_exceptional := is_test_exceptional or else is_invariant_violation_on_feature_entry
		ensure
			exception_code_set: code = an_exception_code
			exception_recipient_name_set: recipient_name = an_exception_recipient_name
			exception_class_name_set: class_name = an_exception_class_name
			exception_tag_name_set: tag_name = an_exception_tag_name
			exception_trace_set: trace = an_exception_trace
		end

feature -- Access

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
