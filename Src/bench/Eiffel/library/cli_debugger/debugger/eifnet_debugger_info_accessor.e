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
	
feature

	Eifnet_debugger_info: EIFNET_DEBUGGER_INFO is
		indexing
			once_status: global
		once
			create Result.make
		end

feature -- Data status

	data_changed: BOOLEAN is
		do
			Result := Eifnet_debugger_info.data_changed
		end

	reset_data_changed is
		do
			Eifnet_debugger_info.set_data_changed (False)
		end

feature -- Callback actions

	notify_start_of_callback (cb_id: INTEGER) is
		do
			Eifnet_debugger_info.notify_start_of_callback (cb_id)
		end

	notify_end_of_callback (cb_id: INTEGER; is_stopped: BOOLEAN) is
		do
			Eifnet_debugger_info.notify_end_of_callback (cb_id)
			Eifnet_debugger_info.set_data_changed (True)
			if is_stopped then
				Eifnet_debugger_info.application.imp_dotnet.status.set_is_stopped (is_stopped)
			end
			
			--| Link to EStudio
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

feature -- Messages

	debugger_messages: LIST [STRING] is
		do
			Result := Eifnet_debugger_info.messages
		end

	wipeout_debugger_messages is
		do
			Eifnet_debugger_info.messages.wipe_out
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

	icor_debug_app_domain: ICOR_DEBUG_APP_DOMAIN is
		do
			Result := Eifnet_debugger_info.icd_app_domain
		end

	icor_debug_thread: ICOR_DEBUG_THREAD is
		do
			Result := Eifnet_debugger_info.icd_thread
		end

	icor_debug_breakpoint: ICOR_DEBUG_BREAKPOINT is
		do
			Result := Eifnet_debugger_info.icd_breakpoint
		end
		
	icor_debug_exception: ICOR_DEBUG_VALUE is
		do
			Result := Eifnet_debugger_info.icd_exception
		end

	last_step_complete_reason: INTEGER is
		do
			Result := Eifnet_debugger_info.last_step_complete_reason
		end

	last_managed_callback: INTEGER is
		do
			Result := Eifnet_debugger_info.last_managed_callback
		end

feature -- Change by ref

	set_icor_debug_by_ref (p: POINTER) is
		do
			Eifnet_debugger_info.set_last_icd_process (p)
		end

feature -- Change by pointer

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

	set_last_exception_by_pointer (p: POINTER) is
		do
			eifnet_debugger_info.set_last_icd_exception (p)
		end
	
feature -- Change by value

	set_last_step_complete_reason (v: INTEGER) is
		do
			eifnet_debugger_info.set_last_step_complete_reason (v)
		end

feature -- reset
		
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

	reset_last_breakpoint_by_pointer (p: POINTER) is
		do
			if Eifnet_debugger_info.last_p_icd_breakpoint.is_equal (p) then
				set_last_breakpoint_by_pointer (Default_pointer)
			end
		end

	reset_last_exception_by_pointer (p: POINTER) is
		do
			if Eifnet_debugger_info.last_p_icd_exception.is_equal (p) then
				set_last_exception_by_pointer (Default_pointer)
			end
		end

end -- class EIFNET_DEBUGGER_INFO_ACCESSOR
