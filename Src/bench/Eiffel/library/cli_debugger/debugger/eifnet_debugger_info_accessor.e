indexing
	description: "Accessor for the dotnet debugger information"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_INFO_ACCESSOR
	
inherit

	SHARED_IL_DEBUG_INFO_RECORDER 
		export 
			{NONE} all
		end	
	
	EIFNET_STEP_REASON_CONSTANTS 
		export 
			{NONE} all
		end

	EIFNET_DEBUGGER_CONTROL_CONSTANTS
		export
			{NONE} all
		end				
	
feature {EIFNET_EXPORTER}

	Eifnet_debugger_info: EIFNET_DEBUGGER_INFO is
		indexing
			once_status: global
		once
			create Result.make
		end

	Edv_external_formatter: EIFNET_DEBUG_EXTERNAL_FORMATTER	 is
		once
			create Result
			Result.set_debugger_info (Eifnet_debugger_info)
		end

feature {EIFNET_EXPORTER} -- Data status

	data_changed: BOOLEAN is
		do
			Result := Eifnet_debugger_info.data_changed
		end

	reset_data_changed is
		do
			Eifnet_debugger_info.set_data_changed (False)
		end

feature {NONE} -- Callback actions

	notify_start_of_callback (cb_id: INTEGER) is
		do
		end

	notify_end_of_callback (cb_id: INTEGER; is_stopped: BOOLEAN) is
		do
			Eifnet_debugger_info.set_data_changed (True)
			if is_stopped then
				Eifnet_debugger_info.application.imp_dotnet.status.set_is_stopped (is_stopped)
			end
			
			debug ("DEBUGGER_TRACE_CALLBACK")
				print ("** Callback ** %T [" + Eifnet_debugger_info.last_managed_callback_name + "] %T done. %N")			
				if is_stopped then
					print ("%T => STOP %N")
				end
				if Eifnet_debugger_info.application.imp_dotnet.status.is_evaluating then
					print ("[!] Callback inside an Evaluation%N")			
				end
			end
		end

feature -- Queries

	icor_debug_module (a_mod_name: STRING): ICOR_DEBUG_MODULE is
			-- ICorDebugModule related to `a_mod_name'
		do
			Result := eifnet_debugger_info.icor_debug_module (a_mod_name)
		end
		
feature -- Access

	icor_debug: ICOR_DEBUG is
		do
			Result := Eifnet_debugger_info.icd
		end

	icor_debug_process: ICOR_DEBUG_PROCESS is
		do
			Result := Eifnet_debugger_info.icd_process
		end

	icor_debug_thread: ICOR_DEBUG_THREAD is
		do
			Result := Eifnet_debugger_info.icd_thread
		end

feature {NONE} -- Change by pointer

	set_last_icor_debug_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd (p)
		end

	set_last_process_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_process (p)
		end

	set_last_app_domain_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_app_domain (p)
		end

	set_last_thread_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_thread (p)
		end
		
	set_last_thread_by_pointer_if_unset (p: POINTER) is
		do
			if Eifnet_debugger_info.last_p_icd_thread = Default_pointer then
				eifnet_debugger_info.set_last_icd_thread (p)			
			end
		end		

	set_last_breakpoint_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_breakpoint (p)
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
		
	reset_last_process_by_pointer (p: POINTER) is
		do
			if Eifnet_debugger_info.last_p_icd_process.is_equal (p) then
				set_last_process_by_pointer (Default_pointer)
			end
		end

	reset_last_app_domain_by_pointer (p: POINTER) is
		do
			if Eifnet_debugger_info.last_p_icd_app_domain.is_equal (p) then
				set_last_app_domain_by_pointer (Default_pointer)
			end
		end

	reset_last_thread_by_pointer (p: POINTER) is
		do
			if Eifnet_debugger_info.last_p_icd_thread.is_equal (p) then
				set_last_thread_by_pointer (Default_pointer)
			end
		end

feature {EIFNET_EXPORTER} -- Stepping Access

	set_last_control_mode_is_continue is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_continue)
		end
	set_last_control_mode_is_stop is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_stop)
		end
	set_last_control_mode_is_kill is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_kill)
		end
	set_last_control_mode_is_next is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_step_next)
		end
	set_last_control_mode_is_into is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_step_into)
		end
	set_last_control_mode_is_out is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_step_out)
		end
	set_last_control_mode_is_nothing is
		do
			Eifnet_debugger_info.set_last_control_mode (Cst_control_nothing)
		end

end -- class EIFNET_DEBUGGER_INFO_ACCESSOR
