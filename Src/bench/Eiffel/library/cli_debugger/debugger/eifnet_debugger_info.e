indexing
	description: "Objects that represents the dotnet debuggeur information"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_INFO

inherit

	EIFNET_DEBUGGER_CALLBACK_INFO
		export
			{EIFNET_DEBUGGER_INFO_ACCESSOR} all
		redefine
			reset, init			
		end
		
	EIFNET_DEBUGGER_BREAKPOINT_INFO
		rename
			notify_new_module as notify_new_module_for_breakpoints
--| removed so far, since we do not really need this
--| and for performance reason
--			, notify_new_class as notify_new_class_for_breakpoints
		redefine
			reset, init
		end
		
	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
			{EIFNET_DEBUGGER_INFO_ACCESSOR} Application
		end

	EIFNET_DEBUGGER_CONTROL_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE}

	make is
			-- Create Current data.
		do
			create_jit_info
			init
		end
		
	init is
			-- Initialize
		do
			Precursor {EIFNET_DEBUGGER_CALLBACK_INFO}					
			Precursor {EIFNET_DEBUGGER_BREAKPOINT_INFO}
		end

feature -- Debugger

	optimized_jit_debugging_enabled: BOOLEAN
			-- JIT debugging Optimized ?
			
	set_jit_debugging_mode (v: BOOLEAN) is
			-- Set JIT Debugging mode value
		do
			optimized_jit_debugging_enabled := v
		end		

	controller: EIFNET_DEBUGGER
			-- Bridge to dotnet debugger

	set_controller (val: like controller) is
			-- Set `controller' value to `val'.
		do
			controller := val
		end

feature -- Reset

	reset is
			-- Reset data contained in Current.
		do
			data_changed                := False

				--| ICorDebug |--
			last_icd                    := Void
			last_icd_updated            := True
			last_p_icd                  := Default_pointer
				--| AppDomain |--
			last_icd_app_domain         := Void
			last_icd_app_domain_updated := True
			last_p_icd_app_domain       := Default_pointer
				--| Breakpoint |--
			last_icd_breakpoint         := Void
			last_icd_breakpoint_updated := True
			last_p_icd_breakpoint       := Default_pointer
				--| Exception |--
			last_icd_exception          := Void
			last_icd_exception_updated  := True
			last_p_icd_exception        := Default_pointer
				--| Process |--
			last_icd_process            := Void
			last_icd_process_updated    := True
			last_p_icd_process          := Default_pointer
				--| Thread |--
			last_icd_thread             := Void
			last_icd_thread_updated     := True
			last_p_icd_thread           := Default_pointer		
				--| StepComplete |--
			last_step_complete_reason   := 0
			last_exception_is_handled   := False
			
				--| Param   |--
			param_arguments := Void
			param_executable := Void
			param_directory := Void
			
				--| Various |--
			current_stack_info := Void
			previous_stack_info := Void
			current_callstack_initialized := False
			
			last_control_mode := 0
			
				--| Ancestors |--
			
			reset_jit_info
			Precursor {EIFNET_DEBUGGER_BREAKPOINT_INFO}
		end


feature -- Current CallStack

	current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			-- Contains current debugger info about current stack
			
	previous_stack_info: EIFNET_DEBUGGER_STACK_INFO
			-- Contains saved debugger info about previous stack
	
	reset_current_callstack is
			-- Reset current callstack information
		do
			create current_stack_info
			current_callstack_initialized := False
		end
		
	init_current_callstack is
			-- Initialize current callback information
		local
			l_frame: ICOR_DEBUG_FRAME
			l_chain: ICOR_DEBUG_CHAIN
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_func: ICOR_DEBUG_FUNCTION
		do
			if not current_callstack_initialized then
				if current_stack_info = Void then
					create current_stack_info					
				end
				current_stack_info.set_synchronized (False)
				
				debug ("DEBUGGER_TRACE_EIFNET")
					print ("[!] Initialize Current Stack in EIFNET_DEBUGGER_INFO.%N")
				end
				if 
					last_p_icd_process /= Default_pointer 
					and then last_p_icd_thread /= Default_pointer 
				then
					update_icd_thread
					l_frame := last_icd_thread.get_active_frame
					if l_frame = Void then
						debug ("DEBUGGER_TRACE_SYNCHRO")
							print ("[ERROR] Debugger not synchronized%N")
						end
					else
						l_il_frame := l_frame.query_interface_icor_debug_il_frame
						if l_il_frame /= Void then
							current_stack_info.set_synchronized (True)
							l_chain := l_frame.get_chain
							l_func 	:= l_il_frame.get_function
							current_stack_info.set_current_stack_pseudo_depth (l_chain.enumerate_frames.count)
							current_stack_info.set_current_module_name        (l_func.get_module.get_name)
							current_stack_info.set_current_class_token        (l_func.get_class.get_token)
							current_stack_info.set_current_feature_token      (l_func.get_token)
							current_stack_info.set_current_il_code_size       (l_func.get_il_code.get_size)
							current_stack_info.set_current_il_offset          (l_il_frame.get_ip)
							current_stack_info.set_current_stack_address      (l_il_frame.get_code.get_address.to_hex_string)
						end
					end
				end
				current_callstack_initialized := True
			end
		ensure
			current_callstack_initialized
		end
		
	current_callstack_initialized: BOOLEAN
			-- Is current callstack initialized ?

feature {EIFNET_EXPORTER} -- Current Breakpoint access

	current_breakpoint: BREAKPOINT is
			-- Current eStudio Breakpoint object corresponding to the
			-- current breakpoint in dotnet world.
		local
			l_eifnet_breakpoint: EIFNET_BREAKPOINT
		do
			check
				last_managed_callback_is_breakpoint
			end
			l_eifnet_breakpoint := eifnet_breakpoint (
										current_stack_info.current_module_name,
										current_stack_info.current_class_token,
										current_stack_info.current_feature_token,
										current_stack_info.current_il_offset
									)
			Result := l_eifnet_breakpoint.breakpoint
		end

feature -- Evaluation

	is_inside_function_evaluation: BOOLEAN is
			-- Is the current context correspond to a function evaluation ?
		do
			Result := Application.imp_dotnet.status.is_evaluating
		end		

feature -- Progression

	save_current_stack_as_previous is
			-- Save current callstack as previous callstack.
		do
			previous_stack_info := current_stack_info.twin
		ensure
			current_stack_saved: previous_stack_info.is_equal (current_stack_info)
		end

	is_current_state_same_as_previous: BOOLEAN is
			-- Is current callstack same as previous ?
			-- Used to notice when a debugger operation had no "il offset moving" effect.
			-- this use the il offset related to stoppable point.
		require
			current_stack_info_set: current_stack_info /= Void
		do
			if previous_stack_info /= Void then
				debug ("DEBUGGER_TRACE_STEPPING")
					print ("PREVIOUS=" +previous_stack_info.to_string + "%N")
					print ("CURRENT =" +current_stack_info.to_string + "%N")				
				end
				Result := current_stack_info.is_equal (previous_stack_info)
			end
		end	

feature -- Debugger updatable

	data_changed: BOOLEAN
			-- Data changed during last operation ?

	set_data_changed (val: BOOLEAN) is
			-- Set `data_changed' to `val'.
		do
			data_changed := val
		end

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Access

	icd: ICOR_DEBUG is
			-- Last ICOR_DEBUG object
		do
			update_icd
			Result := last_icd
		end

	icd_process: ICOR_DEBUG_PROCESS is
			-- Last ICOR_DEBUG_PROCESS object
		do
			update_icd_process
			Result := last_icd_process
		end

	icd_thread: ICOR_DEBUG_THREAD is
			-- Last ICOR_DEBUG_THREAD object
		do
			update_icd_thread
			Result := last_icd_thread
		end

	icd_app_domain: ICOR_DEBUG_APP_DOMAIN is
			-- Last ICOR_DEBUG_APP_DOMAIN object
		do
			update_icd_app_domain
			Result := last_icd_app_domain
		end

	icd_breakpoint: ICOR_DEBUG_BREAKPOINT is
			-- Last ICOR_DEBUG_BREAKPOINT object
		do
			update_icd_breakpoint
			Result := last_icd_breakpoint
		end

	icd_exception: ICOR_DEBUG_VALUE is
			-- Last ICOR_DEBUG_VALUE object
		do
			update_icd_exception
			Result := last_icd_exception
		end
		
	last_step_complete_reason: INTEGER
			-- Last `reason' from a `step_complete' callback
			
	last_exception_is_handled: BOOLEAN
			-- Is last exception handled ?
			-- the value is pertinent only in the Exception callback context.
			--
			-- If last_exception_handled is True, this is a "first chance" exception that
			-- hasn't had a chance to be processed by the application.  If
			-- last_exception_handled is False, this is an unhandled exception which will
			-- terminate the process.			

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Change

	set_last_icd (p: POINTER) is 
			-- Set `last_icd' to `p'
		do
			if not p.is_equal (last_p_icd) then
				last_p_icd := p
				last_icd_updated := False
			end
		end

	set_last_icd_process (p: POINTER) is 
			-- Set `last_icd_process' to `p'
		do
			if not p.is_equal (last_p_icd_process) then
				last_p_icd_process := p
				last_icd_process_updated := False
				debug ("DEBUGGER_EIFNET_DATA")
					print ("/// EIFNET_DEBUGGER_INFO:: Process changed%N")
				end

			end
		end

	set_last_icd_app_domain (p: POINTER) is 
			-- Set `last_icd_app_domain' to `p'
		do
			if not p.is_equal (last_p_icd_app_domain) then
				last_p_icd_app_domain := p
				last_icd_app_domain_updated := False
				debug ("DEBUGGER_EIFNET_DATA")
					print ("/// EIFNET_DEBUGGER_INFO:: AppDomain changed%N")
				end				
			end
		end

	set_last_icd_thread (p: POINTER) is 
			-- Set `last_icd_thread' to `p'
		do
			if not p.is_equal (last_p_icd_thread) then
				last_p_icd_thread := p
				last_icd_thread_updated := False
				debug ("DEBUGGER_EIFNET_DATA")
					print ("/// EIFNET_DEBUGGER_INFO:: Thread changed%N")
				end
			end
		end

	set_last_icd_breakpoint (p: POINTER) is 
			-- Set `last_icd_breakpoint' to `p'
		do
			if not p.is_equal (last_p_icd_breakpoint) then
				last_p_icd_breakpoint := p
				last_icd_breakpoint_updated := False
			end
		end

	set_last_icd_exception (p: POINTER) is 
			-- Set `last_icd_exception' to `p'
		do
			if not p.is_equal (last_p_icd_exception) then
				last_p_icd_exception := p
				last_icd_exception_updated := False
			end
		end
		
	set_last_step_complete_reason (val: INTEGER) is
			-- Set `last_step_complete_reason' to `val'
		do
			last_step_complete_reason := val
		end

	set_last_exception_handled (val: BOOLEAN) is
			-- Set `last_exception_is_handled' to `val'
		do
			last_exception_is_handled := val
		end
		
feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Full Update

	update_data is
		do
			update_icd
			update_icd_process
			update_icd_app_domain
			update_icd_thread
			update_icd_exception
--			update_icd_breakpoint
		end

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Pointers to COM Objects

	last_p_icd: POINTER --|ICOR_DEBUG
			-- Last ICOR_DEBUG object
	
	last_p_icd_process: POINTER --|ICOR_DEBUG_PROCESS
			-- Last ICOR_DEBUG_PROCESS object
	
	last_p_icd_app_domain: POINTER --|ICOR_DEBUG_APP_DOMAIN
			-- Last ICOR_DEBUG_APP_DOMAIN object

	last_p_icd_thread: POINTER --|ICOR_DEBUG_THREAD
			-- Last ICOR_DEBUG_THREAD object	
			
	last_p_icd_exception: POINTER --|ICOR_DEBUG_VALUE
			-- Last Exception object

	last_p_icd_breakpoint: POINTER --|ICOR_DEBUG_BREAKPOINT
			-- Last Breakpoint object

feature {NONE} -- Pointers to COM Objects

	last_icd_updated: BOOLEAN
	last_icd: ICOR_DEBUG
			-- Last ICOR_DEBUG object
	
	last_icd_process_updated: BOOLEAN
	last_icd_process: ICOR_DEBUG_PROCESS
			-- Last ICOR_DEBUG_PROCESS object
	
	last_icd_app_domain_updated: BOOLEAN
	last_icd_app_domain: ICOR_DEBUG_APP_DOMAIN
			-- Last ICOR_DEBUG_APP_DOMAIN object

	last_icd_thread_updated: BOOLEAN
	last_icd_thread: ICOR_DEBUG_THREAD
			-- Last ICOR_DEBUG_THREAD object
	
	last_icd_breakpoint_updated: BOOLEAN
	last_icd_breakpoint: ICOR_DEBUG_BREAKPOINT
			-- Last Breakpoint object

	last_icd_exception_updated: BOOLEAN
	last_icd_exception: ICOR_DEBUG_VALUE
			-- Last Exception object	

feature {NONE} -- COM Object

	update_icd is
			-- Last ICOR_DEBUG object
		do
			if not last_icd_updated then
				if last_p_icd = Default_pointer then
					last_icd := Void
				else
					create last_icd.make_by_pointer (last_p_icd)
					last_icd.add_ref
				end
				last_icd_updated := True
			end
		end
	
	update_icd_process is
			-- Last ICOR_DEBUG_PROCESS object
		do
			if not last_icd_process_updated then
				if last_p_icd_process = Default_pointer then
					last_icd_process := Void
				else
					create last_icd_process.make_by_pointer (last_p_icd_process)
					last_icd_process.add_ref
				end
				last_icd_process_updated := True
			end
		end
	
	update_icd_app_domain is
			-- Last ICOR_DEBUG_APP_DOMAIN object
		do
			if not last_icd_app_domain_updated then
				if last_p_icd_app_domain = Default_pointer then
					last_icd_app_domain := Void
				else
					create last_icd_app_domain.make_by_pointer (last_p_icd_app_domain)
					last_icd_app_domain.add_ref
				end
				last_icd_app_domain_updated := True
			end
		end

	update_icd_thread is
			-- Last ICOR_DEBUG_THREAD object
		do
			if not last_icd_thread_updated then
				if last_p_icd_thread = Default_pointer then
					last_icd_thread := Void
				else
					create last_icd_thread.make_by_pointer (last_p_icd_thread)
					last_icd_thread.add_ref
				end
				last_icd_thread_updated := True
			end
		end

	update_icd_breakpoint is
			-- Last Breakpoint object
		do
			if not last_icd_breakpoint_updated then
				if last_p_icd_breakpoint = Default_pointer then
					last_icd_breakpoint := Void
				else
					create last_icd_breakpoint.make_by_pointer (last_p_icd_breakpoint)
					last_icd_breakpoint.add_ref
				end
				last_icd_breakpoint_updated := True
			end
		end
			
	update_icd_exception is
			-- Last Exception object
		do
			if not last_icd_exception_updated then
				if last_p_icd_exception = Default_pointer then
					last_icd_exception := Void
				else
					create last_icd_exception.make_by_pointer (last_p_icd_exception)
					last_icd_exception.add_ref
				end
				last_icd_exception_updated := True
			end
		end

feature -- Debuggee Session Parameters

	param_directory: STRING
			-- Directory from where the debugger runs the process

	param_executable: STRING
			-- Filename to the executable to debug
			
	param_arguments: STRING
			-- Arguments

feature -- Change Debuggee Session Parameters
	
	set_param_directory (a_dir: STRING) is
			-- Set the working directory parameter  to `a_dir'
			-- used for launching application
		do
			param_directory := a_dir
		end

	set_param_executable (a_exec: STRING) is
			-- Set the executable parameter  to `a_exec'
			-- used for launching application
		do
			param_executable := a_exec
		end

	set_param_arguments (a_arg: STRING) is
			-- Set the arguments parameter  to `a_arg'
			-- used for launching application
		do
			param_arguments := a_arg
		end	

feature -- JIT notification

	notify_new_module (a_mod_key: STRING) is
			-- Notify new module loading.
		do
			notify_new_module_for_breakpoints (a_mod_key)
		end

--| removed so far, since we do not really need this
--| and for performance reason
--	notify_new_class (a_cls_token: INTEGER; a_mod_key: STRING) is
--		do
--			notify_new_class_for_breakpoints (a_cls_token, a_mod_key)
--		end

feature -- JIT info

	icor_module (a_mod_name: STRING): ICOR_DEBUG_MODULE is
			-- ICorDebugModule interface related to `a_mod_name'.
		require
			mod_name_valid: a_mod_name /= Void and then not a_mod_name.is_empty
		do
			Result := loaded_modules.item (module_key (a_mod_name))
		end

	create_jit_info is
			-- Create JustInTime information.
		do
			create Loaded_modules.make (10)
			loaded_modules.compare_objects
			
--| removed so far, since we do not really need this
--| and for performance reason
--			create Loaded_classes.make (10)
--			loaded_classes.compare_objects
		end

	reset_jit_info is
			-- Reset JustInTime information.
		do
			Loaded_modules.wipe_out

--| removed so far, since we do not really need this
--| and for performance reason
--			Loaded_classes.wipe_out
		end

	register_new_module (a_module: ICOR_DEBUG_MODULE) is
			-- Register new module after being notified laoding
		require
			a_module /= Void
		local
			l_module_key_name: STRING
			l_module_key_name_tail: STRING
			l_module_stored: ICOR_DEBUG_MODULE
		do
			if optimized_jit_debugging_enabled then
				a_module.enable_jit_debugging (True, True)			
			else
				a_module.enable_jit_debugging (True, False)
			end
			
			l_module_key_name := module_key (a_module.get_name)
			if loaded_modules.is_empty then
					-- We have to deal with the MSCORLIB.DLL module 
					--| FIXME JFIAT : 2003/12/23 : check if MSCORLIB is really always the first loaded module 
				mscorlid_module := a_module
			end
			loaded_modules.put (a_module, l_module_key_name)
			if not loaded_modules.inserted then
				l_module_stored := loaded_modules.item (l_module_key_name)
				if l_module_stored /= Void then
					if l_module_stored.is_equal_as_icor_object (a_module) then
						debug ("debugger_trace_eifnet")
							print ("WARNING: Reloading same ICorDebugModule %N")
							print (" address -> " + a_module.item.out + "%N")
							print ("    name -> " + l_module_key_name + "%N")
						end
					else
						debug ("debugger_trace_eifnet")
							print ("WARNING: Overwriting same ICorDebugModule %N")
							print (" address -> " + a_module.item.out + "%N")
							print ("    name -> " + l_module_key_name + "%N")
						end
	
						loaded_modules.force (a_module, l_module_key_name)
						check
							inserted: loaded_modules.inserted
						end
					end
				else
					print ("[ERROR] while inserting new ICorDebugModule %N")
				end
			end
			
			debug ("debugger_trace_eifnet")
				l_module_key_name_tail := l_module_key_name.twin
				l_module_key_name_tail.keep_tail (30)
				print ("Load module [.. " + l_module_key_name_tail + "]%N")
			end
			notify_new_module (l_module_key_name)
		end

--| removed so far, since we do not really need this
--| and for performance reason
--	register_new_class (a_class: ICOR_DEBUG_CLASS) is
--			-- Notify system a new class is loaded
--		require
--			a_class /= Void
--		local
--			l_class_token: INTEGER
--			l_module_key_name: STRING
--		do
--			--| Register IcorDebugClass
--			l_module_key_name := module_key (a_class.get_module.get_name)
--			l_class_token := a_class.get_token
--			loaded_classes.put (a_class, [l_module_key_name,l_class_token])
--			if not loaded_classes.inserted then
--				print ("ERROR while inserting new ICorDebugClass %N")
--			end
--			
--			debug ("DEBUGGER_TRACE")
--				print ("Load class [0x" + a_class.get_token.to_hex_string + "]%N")
--			end
--
--			notify_new_class (l_class_token, l_module_key_name)
--		end

feature {NONE} -- JIT info implementation

	module_key (a_module_name: STRING): STRING is
			-- module name formatted to be a key
		do
			Result := a_module_name.as_lower
		end

	loaded_modules: HASH_TABLE [ICOR_DEBUG_MODULE, STRING]
			-- Loaded modules by the execution

	mscorlid_module: ICOR_DEBUG_MODULE
			-- MSCORLIB ICorDebugModule
	
--| removed so far, since we do not really need this
--| and for performance reason
--	loaded_classes: HASH_TABLE [ICOR_DEBUG_CLASS, TUPLE[STRING,INTEGER]]

feature -- JIT Info access

	icor_debug_module (a_mod_name: STRING): ICOR_DEBUG_MODULE is
			-- ICorDebugModule for `a_mod_name'
		do
			Result := loaded_modules.item (module_key (a_mod_name))
		end
		
	icor_debug_module_for_mscorlib: ICOR_DEBUG_MODULE is
			-- ICorDebugModule for MSCORLIB
		do
			Result := mscorlid_module
		end

feature -- Stepping

	last_control_mode: INTEGER
			-- Last control mode
			-- stepping into,next,out, continue...

	last_control_mode_as_string: STRING is
			-- String representation for `last_control_mode'
		do
			Result := control_mode_to_string (last_control_mode)
		end

	valid_control_mode (a_mode: INTEGER): BOOLEAN is
			-- Is the control mode `a_mode' valid ?
		do
			Result :=  a_mode = cst_control_continue 
					or a_mode = cst_control_stop 
					or a_mode = cst_control_kill
					or a_mode = cst_control_step_out			
					or a_mode = cst_control_step_next 
					or a_mode = cst_control_step_into
					or a_mode = cst_control_nothing
		end	

	set_last_control_mode (a_mode: INTEGER) is
			-- Set `last_control_mode' to `a_mode'
		require
			control_value_valid: valid_control_mode (a_mode)
		do
			last_control_mode := a_mode
		end

	last_control_mode_is_continue: BOOLEAN is
			-- Last control was `continue'
		do
			Result := last_control_mode = Cst_control_continue
		end

	last_control_mode_is_stop: BOOLEAN is
			-- Last control was `stop'
		do
			Result := last_control_mode = Cst_control_stop
		end

	last_control_mode_is_kill: BOOLEAN is
			-- Last control was `kill'
		do
			Result := last_control_mode = Cst_control_kill
		end

	last_control_mode_is_step_out: BOOLEAN is
			-- Last control was `step_out'
		do
			Result := last_control_mode = Cst_control_step_out
		end

	last_control_mode_is_step_into: BOOLEAN is
			-- Last control was `step_into'
		do
			Result := last_control_mode = Cst_control_step_into
		end

	last_control_mode_is_step_next: BOOLEAN is
			-- Last control was `step_next'
		do
			Result := last_control_mode = Cst_control_step_next
		end
		
	last_control_mode_is_stepping: BOOLEAN is
			-- Last control was `stepping'
		do
			Result := last_control_mode_is_step_into
			or else last_control_mode_is_step_out
			or else last_control_mode_is_step_next
		end

	last_control_mode_is_nothing: BOOLEAN is
			-- Last control was not affected
		do
			Result := last_control_mode = Cst_control_nothing
		end		

end -- class EIFNET_DEBUGGER_INFO

