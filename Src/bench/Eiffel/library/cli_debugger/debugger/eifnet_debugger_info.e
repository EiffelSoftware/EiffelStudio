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

	EIFNET_DEBUGGER_MESSAGE_INFO
		export
			{EIFNET_DEBUGGER_INFO_ACCESSOR} all
		redefine
			reset, init
		end
		
	EIFNET_DEBUGGER_BREAKPOINT_INFO
		rename
			notify_new_module as notify_new_module_for_breakpoints
--			, notify_new_class as notify_new_class_for_breakpoints
		redefine
			reset, init
		end
		
	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
			{ANY} Application
		end

	EIFNET_DEBUGGER_CONTROL_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE}

	make is
		do
			create_jit_info
			init
		end
		
	init is
			-- 
		do
			Precursor {EIFNET_DEBUGGER_CALLBACK_INFO}					
			Precursor {EIFNET_DEBUGGER_MESSAGE_INFO}					
			Precursor {EIFNET_DEBUGGER_BREAKPOINT_INFO}
		end

feature -- Debugger

	controller: EIFNET_DEBUGGER

	set_controller (val: like controller) is
		do
			controller := val
		end

feature -- Reset

	reset is
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
			
			--| Ancestors |--
			
			reset_jit_info
			Precursor {EIFNET_DEBUGGER_BREAKPOINT_INFO}
			Precursor {EIFNET_DEBUGGER_MESSAGE_INFO}

		end

feature -- Current CallStack

	current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			-- Contains current debugger info about current stack
			
	previous_stack_info: EIFNET_DEBUGGER_STACK_INFO
			-- Contains saved debugger info about previous stack
	
	reset_current_callstack is
		do
			create current_stack_info
			current_callstack_initialized := False
		end
		
	init_current_callstack is
			-- 
--		require
--			current_stack_ready: current_stack_info /= Void
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
--				set_current_state_representation
			end
		ensure
			current_callstack_initialized
		end
		
	current_callstack_initialized: BOOLEAN

feature -- Evaluation

	is_inside_function_evaluation: BOOLEAN is
		do
			Result := Application.imp_dotnet.status.is_evaluating
		end		

feature -- Progression

	save_current_stack_as_previous is
		do
			previous_stack_info := clone (current_stack_info)
		ensure
			current_stack_saved: previous_stack_info.is_equal (current_stack_info)
		end

	is_current_state_same_as_previous: BOOLEAN is
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

	set_data_changed (val: BOOLEAN) is
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
		do
			param_directory := a_dir
		end

	set_param_executable (a_exec: STRING) is
		do
			param_executable := a_exec
		end

	set_param_arguments (a_arg: STRING) is
		do
			param_arguments := a_arg
		end	

feature -- JIT notification

	notify_new_module (a_mod_key: STRING) is
		do
			notify_new_module_for_breakpoints (a_mod_key)
		end

--	notify_new_class (a_cls_token: INTEGER; a_mod_key: STRING) is
--		do
----			notify_new_class_for_breakpoints (a_cls_token, a_mod_key)
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
		do
			create Loaded_modules.make (10)
			loaded_modules.compare_objects
			
--			create Loaded_classes.make (10)
--			loaded_classes.compare_objects
		end

	reset_jit_info is
		do
			Loaded_modules.wipe_out
--			Loaded_classes.wipe_out
		end

	register_new_module (a_module: ICOR_DEBUG_MODULE) is
			-- Notify system a new module is loaded
		require
			a_module /= Void
		local
			l_module_key_name: STRING
			l_module_key_name_tail: STRING
		do
			l_module_key_name := module_key (a_module.get_name)
			loaded_modules.put (a_module, l_module_key_name)
			if not loaded_modules.inserted then
				print ("ERROR while inserting new ICorDebugModule %N")
			end
			
			debug ("DEBUGGER_TRACE")
				l_module_key_name_tail := clone (l_module_key_name)
				l_module_key_name_tail.keep_tail (30)
				print ("Load module [.. " + l_module_key_name_tail + "]%N")
			end
			notify_new_module (l_module_key_name)
		end

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
			Result := clone (a_module_name)
			Result.to_lower
		end

	loaded_modules: HASH_TABLE [ICOR_DEBUG_MODULE, STRING]

--	loaded_classes: HASH_TABLE [ICOR_DEBUG_CLASS, TUPLE[STRING,INTEGER]]

feature -- Stepping

	last_control_mode: INTEGER

	valid_control_mode (a_mode: INTEGER): BOOLEAN is
		do
			Result :=  a_mode = cst_control_continue 
					or a_mode = cst_control_stop 
					or a_mode = cst_control_kill
					or a_mode = cst_control_step_out			
					or a_mode = cst_control_step_next 
					or a_mode = cst_control_step_into
					or a_mode = cst_control_nothing
		end	

	last_control_mode_as_string: STRING is
		do
			Result := control_mode_to_string (last_control_mode)
		end

	set_last_control_mode (a_mode: INTEGER) is
		require
			control_value_valid: valid_control_mode (a_mode)
		do
			last_control_mode := a_mode
		end

	last_control_mode_is_continue: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_continue
		end

	last_control_mode_is_stop: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_stop
		end

	last_control_mode_is_kill: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_kill
		end

	last_control_mode_is_step_out: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_step_out
		end

	last_control_mode_is_step_into: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_step_into
		end

	last_control_mode_is_step_next: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_step_next
		end
		
	last_control_mode_is_stepping: BOOLEAN is
		do
			Result := last_control_mode_is_step_into
			or else last_control_mode_is_step_out
			or else last_control_mode_is_step_next
		end

	last_control_mode_is_nothing: BOOLEAN is
		do
			Result := last_control_mode = Cst_control_nothing
		end		

end -- class EIFNET_DEBUGGER_INFO

