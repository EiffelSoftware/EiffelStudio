indexing
	description: "[
		Callback "COM Object" used to manage the dotnet debugger's callbacks
		]"

class
	ICOR_DEBUG_MANAGED_CALLBACK

inherit
	ICOR_OBJECT

	EIFNET_DEBUGGER_INFO_ACCESSOR
		export
			{NONE} all
		undefine
			out
		end

	EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS
		export
			{NONE} all
		undefine
			out
		end

	ICOR_EXPORTER
		export
			{NONE} all
		undefine
			out
		end
		
	EIFNET_EXPORTER
		export
			{NONE} all
		undefine
			out
		end
		
	DEBUG_OUTPUT_SYSTEM_I
		export
			{NONE} all
		undefine
			out
		end

create 
	make_by_pointer
	
feature -- Initialization

	initialize_callback is
			-- Initialize the eiffel feature related to the Managed Callback.
		local
			test: INTEGER
		do
			test := c_initialize_callback (item, Current,
					$breakpoint ,
					$step_complete ,
					$break ,
					$exception ,
					$eval_complete ,
					$eval_exception ,
					$create_process ,
					$exit_process ,
					$create_thread ,
					$exit_thread ,
					$load_module ,
					$unload_module ,
					$load_class ,
					$unload_class ,
					$debugger_error ,
					$log_message ,
					$log_switch ,
					$create_app_domain ,
					$exit_app_domain ,
					$load_assembly ,
					$unload_assembly ,
					$control_ctrap ,
					$name_change ,
					$update_module_symbols ,
					$edit_and_continue_remap ,
					$breakpoint_set_error
				)
		end

feature {NONE} -- debugger behavior
	
	begin_of_managed_callback (cb_id: INTEGER) is
			-- called at each beginning of callback
		local
			l_msg: STRING
		do
			notify_start_of_callback (cb_id)
			eifnet_debugger_info.set_last_managed_callback (cb_id)
			Eifnet_debugger_info.reset_current_callstack

			debug ("DEBUGGER_TRACE_CALLBACK_DATA")
				l_msg := "[EIFFEL/DEB/CALL] ###"
				l_msg.append_string (eifnet_debugger_info.value_of_cst_managed_cb (eifnet_debugger_info.last_managed_callback))
				l_msg.append_string ("###")
				print (l_msg +" %N")
			end
		end

	end_of_managed_callback (cb_id: INTEGER) is
			-- called at each ending of callback
		local
			process_callback: BOOLEAN
			execution_stopped: BOOLEAN
		do			
			process_callback := eifnet_debugger_info.callback_enabled (eifnet_debugger_info.last_managed_callback)

			if process_callback then
				Eifnet_debugger_info.init_current_callstack					
				if Eifnet_debugger_info.last_managed_callback_is_breakpoint then
					execution_stopped := execution_stopped_on_end_of_breakpoint_callback
				elseif Eifnet_debugger_info.last_managed_callback_is_step_complete then
					if Eifnet_debugger_info.application.imp_dotnet.status.is_evaluating	then
						print ("StepComplete while execution ...%N")
						execution_stopped := False
					else
						execution_stopped := execution_stopped_on_end_of_step_complete_callback
					end
				else
						--| Then we stop the execution ;)
						--| do nothing for now
					execution_stopped := True
				end
			else
				--| Let's continue, we don't stop on this callback
				if Eifnet_debugger_info.icd_process /= Void then
					Eifnet_debugger_info.controller.do_continue
				else
					print ("No ICorDebugController ... going to terminate_debugger ...%N")
					Eifnet_debugger_info.controller.terminate_debugger
				end
			end
			notify_end_of_callback (cb_id, execution_stopped)
		end

	execution_stopped_on_end_of_breakpoint_callback: BOOLEAN is
			-- Process end_of_breakpoint_callback and then return if is stopped.
		require
			top_callstack_data_initialised: Eifnet_debugger_info.current_callstack_initialized
		local
			l_previous_stack_info, l_current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			l_copy: EIFNET_DEBUGGER_STACK_INFO
			l_potential_next_il_offset: INTEGER
			l_il_debug_info: IL_DEBUG_INFO_RECORDER
			l_feat: FEATURE_I
		do
			if Eifnet_debugger_info.last_control_mode_is_stepping then
				l_previous_stack_info := Eifnet_debugger_info.previous_stack_info
				l_current_stack_info := Eifnet_debugger_info.current_stack_info
				
				create l_copy
				l_copy.copy (l_previous_stack_info)
				
				l_il_debug_info := Eifnet_debugger_info.controller.Il_debug_info_recorder
				l_feat := l_il_debug_info.feature_i_by_module_class_token (
							l_copy.current_module_name, 
							l_copy.current_class_token, 
							l_copy.current_feature_token
						)
				l_potential_next_il_offset := l_il_debug_info.next_feature_breakable_il_offset_for (l_feat, l_copy.current_il_offset)
				
				l_copy.set_current_il_offset (l_potential_next_il_offset)
				if l_copy.is_equal (l_current_stack_info) then
					Eifnet_debugger_info.controller.do_continue				
					Result := False
				else
					Result := True
				end
			else
				Result := True
			end
		end


	execution_stopped_on_end_of_step_complete_callback: BOOLEAN is
			-- Process end_of_step_complete_callback and then return if is stopped.
		require
			top_callstack_data_initialised: Eifnet_debugger_info.current_callstack_initialized
		local
			unknown_class_for_call_stack_stop: BOOLEAN
			inside_valid_feature_call_stack_stepping: BOOLEAN
			is_valid_callstack_offset: BOOLEAN
			execution_stopped: like execution_stopped_on_end_of_step_complete_callback

			l_class_token: INTEGER
			l_feat_token: INTEGER
			
			l_module_name: STRING
			l_current_il_offset: INTEGER
			l_feat: FEATURE_I		
			l_current_stack_info: EIFNET_DEBUGGER_STACK_INFO
		do
			l_current_stack_info := Eifnet_debugger_info.current_stack_info
			
				--| If we were stepping ...
			debug ("DEBUGGER_TRACE_STEPPING")
				print ("%N>=> StepComplete <=< %N")
				print ("%T - last_control_mode        = " + Eifnet_debugger_info.last_control_mode_as_string + "%N")
				print ("%T - last_step_complete_reason = 0x" + Eifnet_debugger_info.last_step_complete_reason.to_hex_string)
				print ("  ==> " + step_id_to_string (Eifnet_debugger_info.last_step_complete_reason) + "%N")
				print ("%N")
			end
			
			if 
				Eifnet_debugger_info.last_control_mode_is_step_into
				and then Eifnet_debugger_info.is_current_state_same_as_previous
			then
				Eifnet_debugger_info.Application.imp_dotnet.step_into
			else
				l_class_token := l_current_stack_info.current_class_token
				l_module_name := l_current_stack_info.current_module_name
				check
					module_name_valid: l_module_name /= Void and then not l_module_name.is_empty
				end
				if 
					l_module_name /= Void 
					and then not l_module_name.is_empty 
					and l_class_token > 0
				then
					unknown_class_for_call_stack_stop := not Il_debug_info_recorder.has_class_info_about_module_class_token (l_module_name, l_class_token)
--				else
--					unknown_class_for_call_stack_stop := False					
				end
				if unknown_class_for_call_stack_stop then
					debug ("debugger_trace_stepping")
						print ("[!] Unknown Class [0x" + l_class_token.to_hex_string + "] .. we'd better go out to breath %N")
						print ("[!] module = " + l_module_name + "%N")
					end
					Eifnet_debugger_info.controller.do_step_out
				else
					l_feat_token := l_current_stack_info.current_feature_token
					if l_feat_token > 0 then
						inside_valid_feature_call_stack_stepping := Il_debug_info_recorder.has_feature_info_about_module_class_token (l_module_name, l_class_token, l_feat_token)
--					else
--						inside_valid_feature_call_stack_stepping := False
					end
					if inside_valid_feature_call_stack_stepping then
						l_current_il_offset := l_current_stack_info.current_il_offset
						
						l_feat := Il_debug_info_recorder.feature_i_by_module_class_token (l_module_name, l_class_token, l_feat_token)				
						debug ("debugger_trace_stepping")
							print ("[!] Valid and known feature [0x" + l_class_token.to_hex_string 
									+ "::" + l_feat.feature_name 
									+ "] => IP=0x"+l_current_il_offset.to_hex_string
									+" %N")
							print ("[!] module = " + l_module_name + "%N")
						end
						
						if l_current_il_offset = 0 then
								--| Let's skip the first `nop' , non sense for the eStudio debugger					
							Eifnet_debugger_info.controller.do_step_into					
						else
							is_valid_callstack_offset := Il_debug_info_recorder.is_il_offset_related_to_eiffel_line (l_feat, l_current_il_offset)					
							if 
								(not Eifnet_debugger_info.last_control_mode_is_step_out)
								and then (not is_valid_callstack_offset) 
							then
								debug ("debugger_trace_stepping")
									print ("[!] InValid or Unknown offset [0x" + l_current_il_offset.to_hex_string + "].%N")
								end					
									--| if the offset is not related to an know stoppable point, let adjust it					
									--| In case we are not on a potential stop point
									--| this means we are at the beginning of a feature : offset = 0
									--| or we are in a step_into concerning a `foo( a(), b())'
									--| so in either case, a step_into is the correct behavior.
								
								Eifnet_debugger_info.controller.do_step_into
							else
									--| we can stop, this is a valid stoppable point for
									--| the eStudio debugger
								execution_stopped := True
							end						
						end
					else
						debug ("debugger_trace_stepping")
							print ("[!] InValid or Unknown feature [0x" + l_class_token.to_hex_string + "::0x" + l_feat_token.to_hex_string + "].%N")
							print ("[!] class = " + Il_debug_info_recorder.class_name_for_class_token_and_module ( l_class_token, l_module_name) + "%N")
							print ("[!] module = " + l_module_name + "%N")
						end
							--| We'll continue the stepping in the same mode
						
							--| ranges ...
						if Eifnet_debugger_info.last_control_mode_is_step_out then
							Eifnet_debugger_info.controller.do_step_out
						elseif 
							Eifnet_debugger_info.last_control_mode_is_step_into
						then
							Eifnet_debugger_info.controller.do_step_range (True, <<[0,l_current_stack_info.current_il_code_size]>>)
						elseif 
							Eifnet_debugger_info.last_control_mode_is_step_next
						then
							Eifnet_debugger_info.controller.do_step_range (False, <<[0,l_current_stack_info.current_il_code_size]>>)
						else --| FIXME: JFIAT : default ?? needed ???
--							print ("[WARNING] unexpected/expected case in step_complete callback%N") --FIXME: JFIAT
							Eifnet_debugger_info.controller.do_step_range (False, <<[0,l_current_stack_info.current_il_code_size]>>)
						end
					end
				end	
				Result := execution_stopped
			end			
		end
		
feature -- Basic Operations

	breakpoint (p_app_domain: POINTER; p_thread: POINTER; p_breakpoint: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `p_breakpoint' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_breakpoint)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			set_last_breakpoint_by_pointer (p_breakpoint)
			end_of_managed_callback (Cst_managed_cb_breakpoint)
		end

	step_complete (p_app_domain: POINTER; p_thread: POINTER; p_stepper: POINTER; a_reason: INTEGER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `p_stepper' [in].  
			-- `reason' [in]. 
			-- (See ECOM_COR_DEBUG_STEP_REASON_ENUM for possible `reason' values. )
		require
		do
			begin_of_managed_callback (Cst_managed_cb_step_complete)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			set_last_step_complete_reason (a_reason)
			end_of_managed_callback (Cst_managed_cb_step_complete)
			
				--| STEP_NORMAL means that stepping completed normally, in the same
				--|		function.
				--|
				--| STEP_RETURN means that stepping continued normally, after the function
				--|		returned.
				--|
				--| STEP_CALL means that stepping continued normally, at the start of 
				--|		a newly called function.
				--|
				--| STEP_EXCEPTION_FILTER means that control passed to an exception filter
				--|		after an exception was thrown.
				--| 
				--| STEP_EXCEPTION_HANDLER means that control passed to an exception handler
				--|		after an exception was thrown.
				--|
				--| STEP_INTERCEPT means that control passed to an interceptor.
				--| 
				--| STEP_EXIT means that the thread exited before the step completed.
				--|		No more stepping can be performed with the stepper.
		end

	break (p_app_domain: POINTER; p_thread: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `thread' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_break)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_break)
		end

	exception (p_app_domain: POINTER; p_thread: POINTER; unhandled: INTEGER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `unhandled' [in].  
		require
		do
			debug ("DEBUGGER_TRACE_MESSAGE")
				-- unhandled :=  --| TRUE = 1 , FALSE = 0
	 			debugger_messages.extend ("Exception :: param:unhandled = " + (unhandled /= 0).out + "%N")
 			end
			begin_of_managed_callback (Cst_managed_cb_exception)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_exception)
		end		

	eval_complete (p_app_domain: POINTER; p_thread: POINTER; p_eval: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `p_eval' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_eval_complete)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_eval_complete)
		end

	eval_exception (p_app_domain: POINTER; p_thread: POINTER; p_eval: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `p_eval' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_eval_exception)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_eval_exception)
		end

	create_process (p_process: POINTER) is
			-- No description available.
			-- `p_process' [in].  
		do
			begin_of_managed_callback (Cst_managed_cb_create_process)
			set_last_process_by_pointer (p_process)
			end_of_managed_callback (Cst_managed_cb_create_process)
		end

	exit_process (p_process: POINTER) is
			-- No description available.
			-- `p_process' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_exit_process)
			reset_last_process_by_pointer (p_process)			
			end_of_managed_callback (Cst_managed_cb_exit_process)
		end

	create_thread (p_app_domain: POINTER; p_thread: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `thread' [in].  
		do
			begin_of_managed_callback (Cst_managed_cb_create_thread)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer_if_unset (p_thread)
			end_of_managed_callback (Cst_managed_cb_create_thread)
		end

	exit_thread (p_app_domain: POINTER; p_thread: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `thread' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_exit_thread)
			set_last_app_domain_by_pointer (p_app_domain)
			reset_last_thread_by_pointer (p_thread)			
			end_of_managed_callback (Cst_managed_cb_exit_thread)
		end

	load_module (p_app_domain: POINTER; p_module: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_module' [in].  
		require
		local
			l_hr: INTEGER
			mp: MANAGED_POINTER
			p_cchname: INTEGER
			
			l_module: ICOR_DEBUG_MODULE
		do
			begin_of_managed_callback (Cst_managed_cb_load_module)

			set_last_app_domain_by_pointer (p_app_domain)

			if p_module /= Default_pointer then
				create l_module.make_by_pointer (p_module)
				l_module.add_ref
				Eifnet_debugger_info.register_new_module (l_module)	
			end

			debug ("DEBUGGER_TRACE_MESSAGE")
				--| Get Module Name
	 			create mp.make (256 * 2)
	 			l_hr := feature {ICOR_DEBUG_MODULE}.cpp_get_name (p_module, 256, $p_cchname, mp.item)
	 			debugger_messages.extend ("Module :: " + (create {UNI_STRING}.make_by_pointer (mp.item)).string)
	 		end

			end_of_managed_callback (Cst_managed_cb_load_module)
		end

	unload_module (p_app_domain: POINTER; p_module: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_module' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_unload_module)
			set_last_app_domain_by_pointer (p_app_domain)
			end_of_managed_callback (Cst_managed_cb_unload_module)
		end

	load_class (p_app_domain: POINTER; p_class: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].
			-- `c' [in].  
		require
		local
			l_class: ICOR_DEBUG_CLASS
		do
			begin_of_managed_callback (Cst_managed_cb_load_class)
			set_last_app_domain_by_pointer (p_app_domain)
			
			io.read_line
			if p_class /= Default_pointer then
				create l_class.make_by_pointer (p_class)
				l_class.add_ref
--				Eifnet_debugger_info.register_new_class (l_class)	
			end		
			
			end_of_managed_callback (Cst_managed_cb_load_class)
		end

	unload_class (p_app_domain: POINTER; p_class: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `c' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_unload_class)
			set_last_app_domain_by_pointer (p_app_domain)
			end_of_managed_callback (Cst_managed_cb_unload_class)
		end

	debugger_error (p_process: POINTER; error_hr: INTEGER; error_code: INTEGER) is
			-- No description available.
			-- `p_process' [in].  
			-- `error_hr' [in].  
			-- `error_code' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_debugger_error)
			set_last_process_by_pointer (p_process)
			end_of_managed_callback (Cst_managed_cb_debugger_error)
		end

	log_message (p_app_domain: POINTER; p_thread: POINTER; l_level: INTEGER; p_log_switch_name: INTEGER_REF; p_message: INTEGER_REF) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `l_level' [in].  
			-- `p_log_switch_name' [in].  
			-- `p_message' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_log_message)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_log_message)
		end

	log_switch (p_app_domain: POINTER; p_thread: POINTER; l_level: INTEGER; ul_reason: INTEGER; p_log_switch_name: INTEGER_REF; p_parent_name: INTEGER_REF) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `l_level' [in].  
			-- `ul_reason' [in].  
			-- `p_log_switch_name' [in].  
			-- `p_parent_name' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_log_switch)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_log_switch)
		end

	create_app_domain (p_process: POINTER; p_app_domain: POINTER) is
			-- No description available.
			-- `p_process' [in].  
			-- `p_app_domain' [in].  
		require
		local
--			l_icor_debug_process: ICOR_DEBUG_PROCESS;
--			l_icor_debug_app_domain: ICOR_DEBUG_APP_DOMAIN;
			l_hr: INTEGER
		do
			begin_of_managed_callback (Cst_managed_cb_create_app_domain)
			set_last_process_by_pointer (p_process)
			set_last_app_domain_by_pointer (p_app_domain)
			
			l_hr := feature {ICOR_DEBUG_APP_DOMAIN}.cpp_attach (p_app_domain)
			check
				l_hr = 0
			end

--			create l_icor_debug_process.make_by_pointer (p_process)
--			l_icor_debug_process.terminate (123)

			end_of_managed_callback (Cst_managed_cb_create_app_domain)
		end

	exit_app_domain (p_process: POINTER; p_app_domain: POINTER) is
			-- No description available.
			-- `p_process' [in].  
			-- `p_app_domain' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_exit_app_domain)
			set_last_process_by_pointer (p_process)
			set_last_app_domain_by_pointer (p_app_domain)

			reset_last_app_domain_by_pointer (p_app_domain)			

			end_of_managed_callback (Cst_managed_cb_exit_app_domain)
		end

	load_assembly (p_app_domain: POINTER; p_assembly: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_assembly' [in].  
		require
		local
			l_hr: INTEGER
			mp: MANAGED_POINTER
			p_cchname: INTEGER
		do
			begin_of_managed_callback (Cst_managed_cb_load_assembly)
			set_last_app_domain_by_pointer (p_app_domain)

			debug ("DEBUGGER_TRACE_MESSAGE")
				--| Get Assembly Name
				create mp.make (256 * 2)
				l_hr := feature {ICOR_DEBUG_ASSEMBLY}.cpp_get_name (p_assembly, 256, $p_cchname, mp.item)
				debugger_messages.extend ("Assembly :: " + (create {UNI_STRING}.make_by_pointer (mp.item)).string)	
				--|
			end
			
			end_of_managed_callback (Cst_managed_cb_load_assembly)
		end

	unload_assembly (p_app_domain: POINTER; p_assembly: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_assembly' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_unload_assembly)
			set_last_app_domain_by_pointer (p_app_domain)
			end_of_managed_callback (Cst_managed_cb_unload_assembly)
		end

	control_ctrap (p_process: POINTER) is
			-- No description available.
			-- `p_process' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_control_ctrap)
			set_last_process_by_pointer (p_process)
			end_of_managed_callback (Cst_managed_cb_control_ctrap)
		end

	name_change (p_app_domain: POINTER; p_thread: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_name_change)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer_if_unset (p_thread)
			end_of_managed_callback (Cst_managed_cb_name_change)
		end

	update_module_symbols (p_app_domain: POINTER; p_module: POINTER; p_symbol_stream: POINTER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_module' [in].  
			-- `p_symbol_stream' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_update_module_symbols)
			set_last_app_domain_by_pointer (p_app_domain)
			end_of_managed_callback (Cst_managed_cb_update_module_symbols)
		end

	edit_and_continue_remap (p_app_domain: POINTER; p_thread: POINTER; p_function: POINTER; f_accurate: INTEGER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `p_function' [in].  
			-- `f_accurate' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_edit_and_continue_remap)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_edit_and_continue_remap)
		end

	breakpoint_set_error (p_app_domain: POINTER; p_thread: POINTER; p_breakpoint: POINTER; dw_error: INTEGER) is
			-- No description available.
			-- `p_app_domain' [in].  
			-- `p_thread' [in].  
			-- `p_breakpoint' [in].  
			-- `dw_error' [in].  
		require
		do
			begin_of_managed_callback (Cst_managed_cb_breakpoint_set_error)
			set_last_app_domain_by_pointer (p_app_domain)
			set_last_thread_by_pointer (p_thread)
			end_of_managed_callback (Cst_managed_cb_breakpoint_set_error)
		end

feature {NONE} -- Implementation

	c_initialize_callback (obj: POINTER; a_current: ICOR_DEBUG_MANAGED_CALLBACK; 
					a_cb_breakpoint ,
					a_cb_step_complete ,
					a_cb_break ,
					a_cb_exception ,
					a_cb_eval_complete ,
					a_cb_eval_exception ,
					a_cb_create_process ,
					a_cb_exit_process ,
					a_cb_create_thread ,
					a_cb_exit_thread ,
					a_cb_load_module ,
					a_cb_unload_module ,
					a_cb_load_class ,
					a_cb_unload_class ,
					a_cb_debugger_error ,
					a_cb_log_message ,
					a_cb_log_switch ,
					a_cb_create_app_domain ,
					a_cb_exit_app_domain ,
					a_cb_load_assembly ,
					a_cb_unload_assembly ,
					a_cb_control_ctrap ,
					a_cb_name_change ,
					a_cb_update_module_symbols ,
					a_cb_edit_and_continue_remap ,
					a_cb_breakpoint_set_error : POINTER
				): INTEGER is
			-- Pass features to external side to enable callbacks.
		external
			"[
				C++ DebuggerManagedCallback signature 
					( EIF_OBJECT, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER, EIF_POINTER): EIF_INTEGER
				use "cli_debugger_callback.h"
			]"
		alias
			"initialize_callback"
		end

end -- class ICOR_DEBUG_MANAGED_CALLBACK

--	breakpoint (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; p_breakpoint: ICOR_DEBUG_BREAKPOINT) is
--	step_complete (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; p_stepper: ICOR_DEBUG_STEPPER; reason: INTEGER) is
--	break (p_app_domain: ICOR_DEBUG_APP_DOMAIN; thread: ICOR_DEBUG_THREAD) is
--	exception (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; unhandled: INTEGER) is
--	eval_complete (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; p_eval: ICOR_DEBUG_EVAL) is
--	eval_exception (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; p_eval: ICOR_DEBUG_EVAL) is
--	create_process (p_process: ICOR_DEBUG_PROCESS) is
--	exit_process (p_process: ICOR_DEBUG_PROCESS) is
--	create_thread (p_app_domain: ICOR_DEBUG_APP_DOMAIN; thread: ICOR_DEBUG_THREAD) is
--	exit_thread (p_app_domain: ICOR_DEBUG_APP_DOMAIN; thread: ICOR_DEBUG_THREAD) is
--	load_module (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_module: ICOR_DEBUG_MODULE) is
--	unload_module (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_module: ICOR_DEBUG_MODULE) is
--	load_class (p_app_domain: ICOR_DEBUG_APP_DOMAIN; c: ICOR_DEBUG_CLASS) is
--	unload_class (p_app_domain: ICOR_DEBUG_APP_DOMAIN; c: ICOR_DEBUG_CLASS) is
--	debugger_error (p_process: ICOR_DEBUG_PROCESS; error_hr: ECOM_HRESULT; error_code: INTEGER) is
--	log_message (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; l_level: INTEGER; p_log_switch_name: INTEGER_REF; p_message: INTEGER_REF) is
--	log_switch (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; l_level: INTEGER; ul_reason: INTEGER; p_log_switch_name: INTEGER_REF; p_parent_name: INTEGER_REF) is
--	create_app_domain (p_process: ICOR_DEBUG_PROCESS; p_app_domain: ICOR_DEBUG_APP_DOMAIN) is
--	exit_app_domain (p_process: ICOR_DEBUG_PROCESS; p_app_domain: ICOR_DEBUG_APP_DOMAIN) is
--	load_assembly (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_assembly: ICOR_DEBUG_ASSEMBLY) is
--	unload_assembly (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_assembly: ICOR_DEBUG_ASSEMBLY) is
--	control_ctrap (p_process: ICOR_DEBUG_PROCESS) is
--	name_change (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD) is
--	update_module_symbols (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_module: ICOR_DEBUG_MODULE; p_symbol_stream: ISTREAM) is
--	edit_and_continue_remap (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; p_function: ICOR_DEBUG_FUNCTION; f_accurate: INTEGER) is
--	breakpoint_set_error (p_app_domain: ICOR_DEBUG_APP_DOMAIN; p_thread: ICOR_DEBUG_THREAD; p_breakpoint: ICOR_DEBUG_BREAKPOINT; dw_error: INTEGER) is

