indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_DOTNET

inherit
	APPLICATION_STATUS
		redefine
			display_status,
			current_call_stack_element,
			current_call_stack,
			update_on_stopped_state,
			set_current_thread_id,
			thread_name, thread_priority
		end

	SHARED_EIFNET_DEBUGGER

	SHARED_EIFNET_DEBUG_VALUE_FACTORY

create {APPLICATION_EXECUTION}
	make

feature {APPLICATION_STATUS_EXPORTER} -- Initialization

	set_top_level is -- (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
			-- Set the various attributes identifying current
			-- position in source code.
		local
			curr_mod_name: STRING
			curr_ctok, curr_ftok: INTEGER
			curr_il_offset: INTEGER
			dyn_ctype: CLASS_TYPE
			feat_i: FEATURE_I
			curr_stack_info: EIFNET_DEBUGGER_STACK_INFO
			dbg_recorder: IL_DEBUG_INFO_RECORDER
		do
			Eifnet_debugger.init_current_callstack
			dbg_recorder := Eifnet_debugger.Il_debug_info_recorder
			curr_stack_info := Eifnet_debugger.current_stack_info
			if curr_stack_info.is_synchronized then
				curr_mod_name := curr_stack_info.current_module_name
				curr_ctok := curr_stack_info.current_class_token
				curr_ftok := curr_stack_info.current_feature_token
				if dbg_recorder.has_info_about_module (curr_mod_name) then
					dyn_ctype := dbg_recorder.class_type_for_module_class_token (curr_mod_name, curr_ctok)
					feat_i := dbg_recorder.feature_i_by_module_feature_token (curr_mod_name, curr_ftok)
					if dyn_ctype /= Void then
						dynamic_class := dyn_ctype.associated_class

						if feat_i /= Void then
							e_feature := feat_i.e_feature
							origin_class := feat_i.written_class
							body_index := e_feature.body_index

							curr_il_offset := curr_stack_info.current_il_offset
							break_index := dbg_recorder.feature_eiffel_breakable_line_for_il_offset (dyn_ctype, feat_i, curr_il_offset)
						end
					end
				end
				object_address := curr_stack_info.current_stack_address
			end
		end

feature -- Update

	exception_debug_value: ABSTRACT_DEBUG_VALUE is
		require else
			exception_occurred: exception_occurred
			eifnet_debugger_exists: Eifnet_debugger /= Void
		local
			icdv: ICOR_DEBUG_VALUE
		do
			icdv := eifnet_debugger.new_active_exception_value_from_thread
			if icdv /= Void then
				Result := debug_value_from_icdv (icdv, Void)
				Result.set_name ("Exception object")
			end
		end

	exception_occurred: BOOLEAN is
		require else
			eifnet_debugger_exists: Eifnet_debugger /= Void
		do
			Result := Eifnet_debugger.exception_occurred
		end

	exception_handled: BOOLEAN is
			-- Last Exception is handled ?
			-- if True => first chance
			-- if False => The execution will terminate after.
		require
			eifnet_debugger_exists: Eifnet_debugger /= Void
		do
			Result := Eifnet_debugger.last_exception_is_handled
		end

	exception_class_name: STRING is
			-- Exception class name
		require
			exception_occurred: exception_occurred
		do
			Result := Eifnet_debugger.exception_class_name
		end

	exception_module_name: STRING is
			-- Exception module name
		require
			exception_occurred: exception_occurred
		do
			Result := Eifnet_debugger.exception_module_name
		end

	exception_to_string: STRING is
			-- Exception "ToString" output
		require
			exception_occurred: exception_occurred
		do
			Result := Eifnet_debugger.exception_to_string
		end

	exception_message: STRING is
			-- Exception "GetMessage" output
		require else
			exception_occurred: exception_occurred
		do
			Result := Eifnet_debugger.exception_message
		end

	update_on_stopped_state is
			-- Update data once the application is really stopped
		do
			if exception_occurred and is_stopped then
				exception_tag := exception_message
			else
				exception_tag := Void
			end
		end

feature -- Values

	is_evaluating: BOOLEAN
			-- Is the debugged application evaluating expression ?	

feature -- Changes

	set_is_evaluating (b: BOOLEAN) is
			-- set is_evaluating to `b'
		do
			is_evaluating := b
			Eifnet_debugger.info.set_is_evaluating (b) -- For optimization purpose
		end

feature -- Output

	display_status (st: TEXT_FORMATTER) is
			-- Display status of debugged system
		do
			check
				il_generation: Eiffel_system.System.il_generation
			end

			if not is_stopped then
				st.add_string ("System is running")
				st.add_new_line
			end
			st.add_new_line
			-- NOTA jfiat [2004/07/02] : maybe we could display more information
			-- for instance if we run with or without break points
		end

feature -- Thread info

	set_current_thread_id (tid: INTEGER) is
			-- Set current thread ID.
		do
			Precursor {APPLICATION_STATUS} (tid)
			Eifnet_debugger.info.set_last_icd_thread_id (tid)
		end

	refresh_current_thread_id is
		local
			dbg_info: EIFNET_DEBUGGER_INFO
			edti: EIFNET_DEBUGGER_THREAD_INFO
		do
			dbg_info := Eifnet_debugger.info
			if current_thread_id = 0 then
				set_current_thread_id (dbg_info.last_icd_thread_id)
			end
			if not dbg_info.is_valid_managed_thread_id (current_thread_id) then
				edti := dbg_info.default_managed_thread
				if edti /= Void then
					set_current_thread_id (edti.thread_id)
				end
			end
		end

	thread_name	(a_id: like current_thread_id): STRING is
		local
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			dbg_info := Eifnet_debugger.info
			if dbg_info.is_valid_managed_thread_id (a_id) then
				dbg_info.managed_thread (a_id).get_thread_name
				Result := dbg_info.managed_thread (a_id).thread_name
			else
				Result := Precursor (a_id)
			end
		end

	thread_priority	(a_id: like current_thread_id): INTEGER is
		local
			dbg_info: EIFNET_DEBUGGER_INFO
		do
			dbg_info := Eifnet_debugger.info
			if dbg_info.is_valid_managed_thread_id (a_id) then
				dbg_info.managed_thread (a_id).get_thread_priority
				Result := dbg_info.managed_thread (a_id).thread_priority
			else
				Result := Precursor (a_id)
			end
		end

feature -- Call stack related

	current_call_stack: EIFFEL_CALL_STACK_DOTNET

	clean_current_call_stack is
			-- Clean Eiffel callstack data
		do
			if current_call_stack /= Void then
				current_call_stack.clean
			end
		end

feature {NONE} -- CallStack Impl

	new_current_callstack_with (a_stack_max_depth: INTEGER): like current_call_stack is
			-- Create Eiffel Callstack with a maximum depth of `a_stack_max_depth'
		do
			clean_current_call_stack
			create Result.make (a_stack_max_depth, current_thread_id)
		end

	current_call_stack_element: CALL_STACK_ELEMENT is
			-- Current call stack element being displayed
		local
			ccs: EIFFEL_CALL_STACK_DOTNET
			cesn: INTEGER
		do
			ccs := current_call_stack
			cesn := Application.current_execution_stack_number
			if ccs.valid_index (cesn) then
				Result := ccs.i_th (cesn)
			end
		end

feature -- Values

	current_call_stack_element_dotnet: CALL_STACK_ELEMENT_DOTNET is
			-- Current call stack element being displayed
		do
			Result ?= current_call_stack_element
		end

feature -- Reason for stopping

	set_reason (val: like reason) is
			-- Set reason of stopped state
		do
			reason := val
		ensure
			valid_reason
		end

	set_reason_as_break is
		do
			set_reason ({IPC_SHARED}.Pg_break)
		end

	set_reason_as_interrupt is
		do
			set_reason ({IPC_SHARED}.Pg_interrupt)
		end

	set_reason_as_raise is
		do
			set_reason ({IPC_SHARED}.Pg_raise)
		end

	set_reason_as_viol is
		do
			set_reason ({IPC_SHARED}.Pg_viol)
		end

	set_reason_as_new_breakpoint is
		do
			set_reason ({IPC_SHARED}.Pg_new_breakpoint)
		end

	set_reason_as_step is
		do
			set_reason ({IPC_SHARED}.Pg_step)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class APPLICATION_STATUS_DOTNET
