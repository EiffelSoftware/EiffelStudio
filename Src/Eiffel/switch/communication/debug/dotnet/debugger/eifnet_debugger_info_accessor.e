indexing
	description: "Accessor for the dotnet debugger information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_INFO_ACCESSOR

inherit

	REFACTORING_HELPER

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		end

	COR_DEBUG_STEP_REASON_ENUM
		export
			{NONE} all
		end

	EIFNET_DEBUGGER_CONTROL_CONSTANTS
		export
			{NONE} all
		end

	EIFNET_DEBUGGER_UNMANAGED_CALLBACK_CONSTANTS
		export
			{NONE} all
		end

	EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS
		export
			{NONE} all
		end

	EIFNET_EXPORTER

feature {EIFNET_EXPORTER}

	make is
		do
			create eifnet_debugger_info.make
			create callback_info.make
		end

	reset_info is
		do
			eifnet_debugger_info.reset
			callback_info.reset
		end

feature {NONE} -- Private info

	eifnet_debugger_info: EIFNET_DEBUGGER_INFO

	callback_info: EIFNET_DEBUGGER_CALLBACK_INFO

feature -- Queries

	icor_debug_module (a_mod_name: STRING): ICOR_DEBUG_MODULE is
			-- ICorDebugModule related to `a_mod_name'
		do
			Result := eifnet_debugger_info.icor_debug_module (a_mod_name)
		end

feature -- Status

	last_control_mode_is_stepping: BOOLEAN is
		do
			Result := eifnet_debugger_info.last_control_mode_is_stepping
		end

	last_exception_is_handled: BOOLEAN is
		do
			Result := eifnet_debugger_info.last_exception_is_handled
		end

feature {EIFNET_EXPORTER} -- Restricted Bridge to EIFNET_DEBUGGER_INFO

	managed_callback_name (cb_id: INTEGER): STRING is
		do
			Result := callback_info.managed_callback_name (cb_id)
		end

	managed_callback_is_exit_process (cb_id: INTEGER): BOOLEAN is
		do
			Result := callback_info.managed_callback_is_exit_process (cb_id)
		end

	managed_callback_is_step_complete (cb_id: INTEGER): BOOLEAN is
		do
			Result := callback_info.managed_callback_is_step_complete (cb_id)
		end

	managed_callback_is_breakpoint (cb_id: INTEGER): BOOLEAN is
		do
			Result := callback_info.managed_callback_is_breakpoint (cb_id)
		end

	managed_callback_is_eval_complete (cb_id: INTEGER): BOOLEAN is
		do
			Result := callback_info.managed_callback_is_eval_complete (cb_id)
		end

	managed_callback_is_eval_exception (cb_id: INTEGER): BOOLEAN is
		do
			Result := callback_info.managed_callback_is_eval_exception (cb_id)
		end

	managed_callback_is_exception (cb_id: INTEGER): BOOLEAN is
		do
			Result := callback_info.managed_callback_is_exception (cb_id)
		end

feature {EIFNET_EXPORTER} -- Restricted Bridge to EIFNET_DEBUGGER_INFO

	set_last_managed_callback (cb_id: INTEGER) is
		do
			callback_info.set_last_managed_callback (cb_id)
		end

	last_managed_callback: INTEGER is
		do
			Result := callback_info.last_managed_callback
		end

	last_managed_callback_is_eval_exception: BOOLEAN is
		do
			Result := managed_callback_is_eval_exception (last_managed_callback)
		end

	last_managed_callback_is_exception: BOOLEAN is
		do
			Result := managed_callback_is_exception (last_managed_callback)
		end

feature -- Access

	icor_debug_controller: ICOR_DEBUG_CONTROLLER is
		do
			Result := eifnet_debugger_info.icd_controller
		end

	icor_debug_process: ICOR_DEBUG_PROCESS is
		do
			Result := eifnet_debugger_info.icd_process
		end

	icor_debug_thread: ICOR_DEBUG_THREAD is
		do
			Result := Eifnet_debugger_info.icd_thread
		end

	icor_debug_thread_by_id (a_tid: INTEGER): like ICOR_DEBUG_THREAD is
		do
			Result := eifnet_debugger_info.icd_thread_by_id (a_tid)
		end

	ise_runtime_module: ICOR_DEBUG_MODULE is
			-- EiffelSoftware.runtime ICorDebugModule
		do
			Result := eifnet_debugger_info.ise_runtime_module
		end

	evaluation_icor_debug_exception: ICOR_DEBUG_VALUE is
		do
			Result := eifnet_debugger_info.evaluation_icd_exception
		end

feature -- Callstack related

	current_stack_info: EIFNET_DEBUGGER_STACK_INFO is
		do
			Result := eifnet_debugger_info.current_stack_info
		end

	previous_stack_info: EIFNET_DEBUGGER_STACK_INFO is
		do
			Result := eifnet_debugger_info.previous_stack_info
		end

	reset_current_callstack is
		do
			eifnet_debugger_info.reset_current_callstack
		end

	init_current_callstack is
		do
			eifnet_debugger_info.init_current_callstack
		end

	save_current_stack_as_previous is
		do
			eifnet_debugger_info.save_current_stack_as_previous
		end

feature -- Breakpoint related

	current_breakpoint_location: BREAKPOINT_LOCATION is
		do
			check
				managed_callback_is_breakpoint (last_managed_callback)
			end
			Result := eifnet_debugger_info.current_breakpoint_location
		end

	request_breakpoint_add (a_bp: BREAKPOINT_LOCATION; a_module_name: STRING; a_class_token: INTEGER; a_feature_token: INTEGER; a_line: INTEGER_64) is
		do
			eifnet_debugger_info.request_breakpoint_add (a_bp, a_module_name, a_class_token, a_feature_token, a_line)
		end

	request_breakpoint_remove (a_bp: BREAKPOINT_LOCATION; a_module_name: STRING; a_class_token: INTEGER; a_feature_token: INTEGER; a_line: INTEGER_64) is
		do
			eifnet_debugger_info.request_breakpoint_remove (a_bp, a_module_name, a_class_token, a_feature_token, a_line)
		end

feature {NONE} -- Change by pointer

	set_last_controller_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_controller (p)
		end

	set_last_process_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_process (p)
		end

	set_last_exception_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_exception (p)
		end

	set_last_evaluation_exception_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_evaluation_icd_exception (p)
		end

	set_last_breakpoint_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_breakpoint (p)
		end

	set_last_thread_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_thread (p)
		end

	add_managed_thread_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.add_managed_thread_by_pointer (p)
		end

	remove_managed_thread_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.remove_managed_thread_by_pointer (p)
		end

feature {NONE} -- Change by value

	set_last_step_complete_reason (v: INTEGER) is
		do
			eifnet_debugger_info.set_last_step_complete_reason (v)
		end

	set_last_exception_handled (v: BOOLEAN) is
		do
			eifnet_debugger_info.set_last_exception_handled (v)
		end

feature {NONE} -- reset

	reset_last_controller_by_pointer (p: POINTER) is
		do
			if eifnet_debugger_info.last_p_icd_controller.is_equal (p) then
				set_last_controller_by_pointer (Default_pointer)
			end
		end

	reset_last_process_by_pointer (p: POINTER) is
		do
			if eifnet_debugger_info.last_p_icd_process.is_equal (p) then
				set_last_process_by_pointer (default_pointer)
			end
		end

feature {EIFNET_EXPORTER} -- Stepping Access

	set_last_control_mode_is_continue is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_continue)
		end
	set_last_control_mode_is_stop is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_stop)
		end
	set_last_control_mode_is_kill is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_kill)
		end
	set_last_control_mode_is_next is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_step_next)
		end
	set_last_control_mode_is_into is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_step_into)
		end
	set_last_control_mode_is_out is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_step_out)
		end
	set_last_control_mode_is_nothing is
		do
			eifnet_debugger_info.set_last_control_mode (Cst_control_nothing)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EIFNET_DEBUGGER_INFO_ACCESSOR
