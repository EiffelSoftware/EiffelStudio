indexing
	description: "[
					Objects that represents the debuggeur information 
					regarding callbacks status
				]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_CALLBACK_INFO

inherit

	EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS
	EIFNET_DEBUGGER_UNMANAGED_CALLBACK_CONSTANTS

feature {NONE}-- initialisation

	init is
		do
		end
	
	reset is
			-- 
		do		
		end
		
feature {NONE} -- notification status

	inside_callback_process: BOOLEAN
			-- Is it inside a callback processing ?

	callback_is_waiting: BOOLEAN

	data_access_enabled: BOOLEAN

feature -- notification

	notify_start_of_callback (cb_id: INTEGER) is
			-- 
		do
			inside_callback_process := True
		end

	notify_end_of_callback (cb_id: INTEGER) is
			-- 
		do
			inside_callback_process := False
		end

--feature {NONE} -- notification "waiting"
--
--	notify_start_of_callback_waiting (cb_id: INTEGER) is
--			-- 
--		do
--			callback_is_waiting := True
--		end
--
--	notify_end_of_callback_waiting (cb_id: INTEGER) is
--			-- 
--		do
--			callback_is_waiting := False
--		end

feature {NONE} -- callbacks initialisation

	initialize_managed_callback_status is
			-- Initialize default callback to process
		do
			enable_managed_callback (Cst_managed_cb_breakpoint)
			enable_managed_callback (Cst_managed_cb_step_complete)
--			enable_managed_callback (Cst_managed_cb_break)
			enable_managed_callback (Cst_managed_cb_exception)
			enable_managed_callback (Cst_managed_cb_eval_complete)
			enable_managed_callback (Cst_managed_cb_eval_exception)
--			enable_managed_callback (Cst_managed_cb_create_process)
			enable_managed_callback (Cst_managed_cb_exit_process)
--			enable_managed_callback (Cst_managed_cb_create_thread)
--			enable_managed_callback (Cst_managed_cb_exit_thread)
--			enable_managed_callback (Cst_managed_cb_load_module)
--			enable_managed_callback (Cst_managed_cb_unload_module)
--			enable_managed_callback (Cst_managed_cb_load_class)
--			enable_managed_callback (Cst_managed_cb_unload_class)
--			enable_managed_callback (Cst_managed_cb_debugger_error)
--			enable_managed_callback (Cst_managed_cb_log_message)
--			enable_managed_callback (Cst_managed_cb_log_switch)
--			enable_managed_callback (Cst_managed_cb_create_app_domain)
--			enable_managed_callback (Cst_managed_cb_exit_app_domain)
--			enable_managed_callback (Cst_managed_cb_load_assembly)
--			enable_managed_callback (Cst_managed_cb_unload_assembly)
--			enable_managed_callback (Cst_managed_cb_control_ctrap)
--			enable_managed_callback (Cst_managed_cb_name_change)
--			enable_managed_callback (Cst_managed_cb_update_module_symbols)
--			enable_managed_callback (Cst_managed_cb_edit_and_continue_remap)
--			enable_managed_callback (Cst_managed_cb_breakpoint_set_error)
		end

feature -- Callback ids

	last_managed_callback: INTEGER

	last_unmanaged_callback: INTEGER
	
	last_managed_callback_name: STRING is
			-- 	
		do
			Result := value_of_cst_managed_cb (last_managed_callback)
		end

feature {APPLICATION_EXECUTION_DOTNET, EIFNET_EXPORTER} -- Callback nature

	last_managed_callback_is_breakpoint: BOOLEAN is
		do
			Result := last_managed_callback = Cst_managed_cb_breakpoint
		end

	last_managed_callback_is_step_complete: BOOLEAN is
		do
			Result := last_managed_callback = Cst_managed_cb_step_complete
		end

	last_managed_callback_is_eval_complete: BOOLEAN is
		do
			Result := last_managed_callback = Cst_managed_cb_eval_complete
		end

	last_managed_callback_is_eval_exception: BOOLEAN is
		do
			Result := last_managed_callback = Cst_managed_cb_eval_exception
		end

	last_managed_callback_is_exception: BOOLEAN is
		do
			Result := last_managed_callback = Cst_managed_cb_exception
		end

	last_managed_callback_is_exit_process: BOOLEAN is
		do
			Result := last_managed_callback = Cst_managed_cb_exit_process
		end
		
feature {ICOR_DEBUG_MANAGED_CALLBACK, ICOR_DEBUG_UNMANAGED_CALLBACK} -- Change Callbacks

	set_last_managed_callback (cst: INTEGER) is
			-- Set `last_managed_callback' value to `cst'.
		do
			last_managed_callback := cst
		end

	set_last_unmanaged_callback (cst: INTEGER) is
			-- Set `last_unmanaged_callback' value to `cst'.
		do
			last_unmanaged_callback := cst
		end
	
feature {ICOR_DEBUG_MANAGED_CALLBACK} -- Callback status

	callback_enabled (cb_id: INTEGER): BOOLEAN is
			-- Do we process callback `cb_id' ?
		do
			Result := managed_callback_status_info.has (cb_id) 
						and then managed_callback_status_info.item (cb_id) --| = True
		end

	callback_disabled (cb_id: INTEGER): BOOLEAN is
			-- Do we ignore callback `cb_id' ?
		do
			Result := not callback_enabled (cb_id)
		end

feature {NONE} -- Callback status change

	set_managed_callback_status (cb_id: INTEGER; a_status: BOOLEAN) is
		do
			managed_callback_status_info.force (a_status, cb_id)
		end

	enable_managed_callback (cb_id: INTEGER) is
			-- Tell debugger to process  `cb_id' callback.
		do
			set_managed_callback_status (cb_id, True);
		end

	disable_managed_callback (cb_id: INTEGER) is
			-- Tell debugger to skip  `cb_id' callback.
		do
			set_managed_callback_status (cb_id, False);
		end

feature {EIFNET_EXPORTER} -- Callback status

	managed_callback_status_info: HASH_TABLE [BOOLEAN, INTEGER] is
			-- Callback information table
		once
			create Result.make (50)
			initialize_managed_callback_status
		end

end -- class EIFNET_DEBUGGER_CALLBACK_INFO

