indexing
	description	: "Controls execution of debugged application under dotnet."
	date		: "$Date$"
	revision	: "$Revision$"

class APPLICATION_EXECUTION_DOTNET

inherit
	APPLICATION_EXECUTION_IMP
		redefine
			make
		end

	APPLICATION_STATUS_EXPORTER
		export
			{NONE} all
		end
	
	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end
		
	ICOR_EXPORTER -- debug trace purpose
		export
			{NONE} all
		end
		
	EIFNET_EXPORTER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end
		

	EIFNET_DEBUGGER_INFO_ACCESSOR
		export
			{NONE} all
		end

	SHARED_DEBUG_VALUE_KEEPER
		export 
			{NONE} all
		end

create {SHARED_APPLICATION_EXECUTION}
	make
	
feature {SHARED_APPLICATION_EXECUTION} -- Initialization
	
	make is
			-- 
		do
			Precursor
			create eifnet_debugger.make
		end

feature {EIFNET_DEBUGGER, EIFNET_EXPORTER} -- Trigger eStudio done

	estudio_callback_notify is
			-- Once the callback is done, when ec is back to life
			-- it will process this notification.
		do
			callback_notification_processed := False		
			if eifnet_debugger /= Void then
				if eifnet_debugger.data_changed then
					if
						status.is_stopped
						and then not status.is_evaluating					
					then
						eifnet_debugger.reset_data_changed
						if Eifnet_debugger_info.last_managed_callback_is_exit_process then --| Exit Process |--	
							notify_execution_on_exit_process
						else
							notify_execution_on_stopped
						end
					elseif --| Evaluation |--
						Eifnet_debugger_info.last_managed_callback_is_eval_complete
						and then status.is_evaluating
					then
						eifnet_debugger.reset_data_changed
						notify_evaluation_done
					end	
				end
			end
			callback_notification_processed := True
		end
		
	callback_notification_processed: BOOLEAN		
		
feature {APPLICATION_EXECUTION} -- load and save

	load_dotnet_debug_info is
			-- Load debug information (so far only the breakpoints)
		local
			w_dlg: EV_WARNING_DIALOG
		do
			Il_debug_info_recorder.load
			if not Il_debug_info_recorder.load_successful then
				if (create {EV_ENVIRONMENT}).application /= Void then
					create w_dlg.make_with_text (Il_debug_info_recorder.loading_errors_message)
					w_dlg.show
				else
					io.error.put_string (Il_debug_info_recorder.loading_errors_message)
				end
			end
		end
		
feature -- Properties

	status: APPLICATION_STATUS_DOTNET is
			-- Status of the running dotnet application
		do
			Result ?= Application.status
		end
		
	set_status (a_status: like status) is
			-- 
		do
			Application.set_status (a_status)
		end

feature {APPLICATION_EXECUTION} -- Properties

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
			Result := True
		end -- FIXME: JFIAT

feature -- Bridge to Debugger

	exception_occured: BOOLEAN is
			-- Last callback is about exception ?
		require
			eifnet_debugger_exists: eifnet_debugger /= Void
		do
			Result := eifnet_debugger.last_managed_callback_is_exception
		end

	exception_handled: BOOLEAN is
			-- Last Exception is handled ?
			-- if True => first chance
			-- if False => The execution will terminate after.
		require
			eifnet_debugger_exists: eifnet_debugger /= Void
		do
			Result := eifnet_debugger.last_exception_is_handled
		end

	exception_details: TUPLE [STRING, STRING] is
			-- class details , module details
		require
			exception_occured: exception_occured
		local
			l_class_details: STRING
			l_module_details: STRING
			retried: BOOLEAN
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
			l_icd_exception: ICOR_DEBUG_VALUE
		do
			if not retried then
				l_icd_exception := eifnet_debugger.active_exception_value
				create l_exception_info.make (l_icd_exception)
				l_class_details := l_exception_info.value_class_name
				l_module_details := l_exception_info.value_module_file_name
				Result := [l_class_details, l_module_details]
			end
		rescue
			retried := True
			retry
		end

	exception_to_string: STRING is
			-- Exception output
		require
			exception_occured: exception_occured
		local
			retried: BOOLEAN
			l_icd_exception: ICOR_DEBUG_VALUE
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
		do
			if not retried then
				l_icd_exception := eifnet_debugger.active_exception_value
				create l_exception_info.make (l_icd_exception)

				Result := eifnet_debugger.to_string_value_from_exception_object_value (Void, 
					l_icd_exception,
					l_exception_info.interface_debug_object_value
				)
			end
		rescue
			retried := True
			retry
		end
		
	exception_message: STRING is
			-- Exception output
		require
			exception_occured: exception_occured
		local
			retried: BOOLEAN
			l_icd_exception: ICOR_DEBUG_VALUE
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
		do
			if not retried then
				l_icd_exception := eifnet_debugger.active_exception_value
				create l_exception_info.make (l_icd_exception)

				Result := eifnet_debugger.get_message_value_from_exception_object_value (Void, 
					l_icd_exception,
					l_exception_info.interface_debug_object_value
				)
			end
		rescue
			retried := True
			retry
		end		
	
	eifnet_debugger: EIFNET_DEBUGGER
			-- Access to the Dotnet Debugger

	string_value_from_string_class_object_value (icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): STRING is
			-- String value of the `icd_string_instance'.
		do
			Result := eifnet_debugger.string_value_from_string_class_object_value (icd_string_instance)
		end
		
	debug_output_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; 
							a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; a_class_type: CLASS_TYPE): STRING is
			-- Debug_output string value.			
		do
			Result := eifnet_debugger.debug_output_value_from_object_value (a_frame, a_icd, a_icd_obj, a_class_type)
		end

feature -- Execution

	run (args, cwd: STRING) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		local
			app: STRING
			l_status: APPLICATION_STATUS_DOTNET
		do


			create eifnet_debugger.make
			eifnet_debugger.initialize_debugger_session
			if eifnet_debugger.is_debugging then
				app := Eiffel_system.application_name (True)

				eifnet_debugger.set_debug_param_directory (cwd)
				eifnet_debugger.set_debug_param_executable (app)
				eifnet_debugger.set_debug_param_arguments (args)

				process_before_running
				create l_status.do_nothing
				set_status (l_status)
				
				eifnet_debugger.do_run
				
				if status /= Void then
						-- Application was able to be started
					status.set_is_stopped (False)
				end				
			end
		end
		
	continue (kept_objects: LINKED_SET [STRING]) is
			-- Continue the running of the application and keep the 
			-- objects addresses in `kept_objects'. Objects that are not in 
			-- `kept_objects' will be removed and will be not under the 
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		do
--			keep_objects (kept_objects)		
--			cont_request.send_breakpoints
			inspect application.execution_mode
			when feature {EXEC_MODES}.step_into then 
				step_into
			when feature {EXEC_MODES}.step_by_step then 
				step_next
			when feature {EXEC_MODES}.out_of_routine then 
				step_out
			else
				process_before_running
				eifnet_debugger.set_last_control_mode_is_continue
				
				status.set_is_stopped (False)
				eifnet_debugger.do_continue
			end
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do	
			if eifnet_debugger.icor_debug_process /= Void then
				debug ("debugger_eifnet_data")
					print ("IsRunning :: " + eifnet_debugger.icor_debug_process.is_running.out + "%N")
				end

				process_before_running	
				eifnet_debugger.set_last_control_mode_is_stop
				
				eifnet_debugger.do_stop

				debug ("debugger_eifnet_data")
					print ("IsRunning :: " + eifnet_debugger.icor_debug_process.is_running.out + "%N")
				end

				--| Here debugger may not be synchronized |--
				Eifnet_debugger_info.reset_current_callstack
				Eifnet_debugger_info.init_current_callstack		
				debug  ("DEBUGGER_TRACE_EIFNET")			
					debug_display_threads
				end
				eifnet_debugger.do_step_next
			end
		end
		

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
			send_breakpoints
		end		

	kill is
			-- Ask the application to terminate itself.
		do
			if eifnet_debugger.is_debugging then
				eifnet_debugger.set_last_control_mode_is_kill
				eifnet_debugger.terminate_debugger
			end
		end

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			Eifnet_debugger.stop_dbg_timer
			Eifnet_debugger_info.set_controller (Void)
			Eifnet_debugger_info.reset
		end
		
feature -- Controle execution

	process_before_running is
		local
			l_entry_point_feature: E_FEATURE
		do
			debug ("debugger_trace_operation")
				print ("%N%N")
				print ("/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\%N")				
				print ("%N%N")
			end
			
			Application.debug_info.update
			inspect Application.execution_mode
			when feature {EXEC_MODES}.no_stop_points then 
				send_no_breakpoints
			when feature {EXEC_MODES}.step_by_step, feature {EXEC_MODES}.step_into then 
				if not Application.is_running then
					debug ("DEBUGGER_TRACE_STEPPING")
						print ("Let's add a breakpoint at the entry point of the system%N")
					end
					l_entry_point_feature := Il_debug_info_recorder.entry_point_feature_i.e_feature
					Application.enable_breakpoint (l_entry_point_feature, 1)
					send_breakpoints
					Application.remove_breakpoint (l_entry_point_feature , 1)
				else
					send_breakpoints
				end
			else
				send_breakpoints
			end
			
			debug ("debugger_eifnet_data")
				debug_display_threads
			end

			Eifnet_debugger_info.init_current_callstack
			Eifnet_debugger_info.save_current_stack_as_previous
			Eifnet_debugger.set_last_control_mode_is_nothing
		end

	debug_display_threads is
			-- 
		local
			l_process: ICOR_DEBUG_PROCESS
			l_enum_thread: ICOR_DEBUG_THREAD_ENUM
			l_threads: ARRAY [ICOR_DEBUG_THREAD]
			i: INTEGER
			l_th: ICOR_DEBUG_THREAD
		do
			l_process := Eifnet_debugger_info.icd_process
			if l_process /= Void then
				l_enum_thread := l_process.enumerate_threads
				if l_enum_thread /= Void and then l_enum_thread.count > 0 then
					l_threads := l_enum_thread.next (l_enum_thread.count)
					print ("[info]  => " + l_threads.count.out + " Threads.%N")
					print ("        => last   :: " + Eifnet_debugger_info.icd_thread.get_id.to_hex_string + "%N")
					print ("        => helper :: " + l_process.get_helper_thread_id.to_hex_string + "%N")

					from
						i := l_threads.lower
					until
						i > l_threads.upper
					loop
						l_th := l_threads.item (i)
						print ("        => " + l_th.get_id.to_hex_string 
--								+ " DebugState=0x" + l_th.get_debug_state.to_hex_string
--								+ " UserState=0x" + l_th.get_user_state.to_hex_string
								+ "%N"
						)
						i := i + 1
					end
				end
			end

--			print ("[info] Nb of Threads : " + Eifnet_debugger_info.icd_process.enumerate_threads.count.out + "%N")			
		end

feature -- Stepping

	step_out is
		do
			process_before_running
			
			debug ("debugger_trace_stepping")
				print ("++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")				
				print ("++ OPERATION :: APPLICATION_EXECUTION_DOTNET::step_out%N")
				print ("++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
			end
			if eifnet_debugger.stepping_possible then
				eifnet_debugger.set_last_control_mode_is_out

				eifnet_debugger.do_step_out
				status.set_is_stopped (False)
			end
		end
		
	step_into is
		do
			process_before_running
			
			debug ("debugger_trace_stepping")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")				
				print ("++ OPERATION :: APPLICATION_EXECUTION_DOTNET::step_into%N")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
			end			
			eifnet_debugger.set_last_control_mode_is_into	
			step_range (True)
		end

	step_next is
		do
			process_before_running

			debug ("debugger_trace_stepping")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")				
				print ("++ OPERATION :: APPLICATION_EXECUTION_DOTNET::step_next%N")
				print ("+++++++++++++++++++++++++++++++++++++++++++++++++++++++%N")
			end			

			if
				(status.e_feature /= Void)
				and then (status.break_index = status.e_feature.number_of_breakpoint_slots)
			then
				--| This is an optimisation when we are at the end of a routine
				--| End of feature, go out ...
				step_out
			else
				eifnet_debugger.set_last_control_mode_is_next
				step_range (False)
			end
		end
		
feature {NONE} -- Stepping

	step_range (a_bstep_in: BOOLEAN) is
		local
			l_current_il_offset: INTEGER
			l_call_stack_element: CALL_STACK_ELEMENT_DOTNET
			do_not_use_range: BOOLEAN
			l_ranges:  ARRAY [TUPLE [INTEGER,INTEGER]]
		do		
			do_not_use_range := False
			if do_not_use_range then
				if a_bstep_in then
					eifnet_debugger.do_step_into
				else
					eifnet_debugger.do_step_next
				end
				status.set_is_stopped (False)
			else
				if eifnet_debugger.stepping_possible then
					l_call_stack_element := status.current_stack_element_dotnet
					if l_call_stack_element /= Void then
						l_current_il_offset := l_call_stack_element.il_offset
						debug ("debugger_trace_stepping")
							print (" ### Current IL OffSet = 0x"+l_current_il_offset.to_hex_string+" ~ "+l_current_il_offset.out+" %N")
						end
					end

					l_ranges := Il_debug_info_recorder.next_feature_breakable_il_range_for (
									l_call_stack_element.dynamic_type,
									l_call_stack_element.routine.associated_feature_i,
									l_current_il_offset
									)	
									
					if l_ranges /= Void then
						debug ("debugger_trace_stepping")
							print ("[>] Go for next point %N")
						end					
						eifnet_debugger.do_step_range (a_bstep_in, l_ranges)
					else
						debug ("debugger_trace_stepping")
							print ("[>] Go out of routine (from "+l_current_il_offset.to_hex_string+")%N")
						end
						eifnet_debugger.do_step_out					
--						eifnet_debugger.do_step_range (a_bstep_in, <<[0 , l_current_il_offset]>>)
					end
					status.set_is_stopped (False)
				end				
			end

		end		

feature {NONE} -- Entry Point

	is_entry_point (f: E_FEATURE): BOOLEAN is
			-- Is the entry point of the system ?
		do
			Result := (f.name).is_equal (Eiffel_system.System.creation_name)
					and then f.written_class.is_equal (Eiffel_system.System.root_class.compiled_class)
		end

feature -- Breakpoints controller

	send_breakpoints is
			-- Synchronise the EiffelStudio BreakPoints with the application ones in execution
		local
			l_bp_list: BREAK_LIST
			l_bp_item: BREAKPOINT
		do
			l_bp_list := Application.debug_info.breakpoints

			from
				l_bp_list.start
			until
				l_bp_list.off
			loop
				l_bp_item := l_bp_list.item_for_iteration
				inspect l_bp_item.update_status
				when feature {BREAKPOINT}.Breakpoint_to_add then
					debug ("debugger_trace_breakpoint")
						print ("ADD BP :: " + l_bp_item.routine.associated_class.name_in_upper +"."+ l_bp_item.routine.name +" @ " + l_bp_item.breakable_line_number.out + "%N")
					end
					add_dotnet_breakpoint (l_bp_item)
					l_bp_item.set_application_set
				when feature {BREAKPOINT}.Breakpoint_to_remove then
					debug ("debugger_trace_breakpoint")
						print ("DEL BP :: " + l_bp_item.routine.associated_class.name_in_upper +"."+ l_bp_item.routine.name +" @ " + l_bp_item.breakable_line_number.out + "%N")
					end
					remove_dotnet_breakpoint (l_bp_item)
					l_bp_item.set_application_not_set					
				when feature {BREAKPOINT}.Breakpoint_do_nothing then
					debug ("debugger_trace_breakpoint")
						print ("NADA BP %N")					
					end
				end
				l_bp_list.forth
			end

			debug ("debugger_trace_breakpoint")
				Eifnet_debugger_info.display_bp_list_status
			end
		end		

	send_no_breakpoints is
			-- Remove BreakPoints from the application ones in execution
			-- to perform a NoStopPoint operation
		local
			l_bp_list: BREAK_LIST
			l_bp_item: BREAKPOINT
		do
			l_bp_list := Application.debug_info.breakpoints

			from
				l_bp_list.start
			until
				l_bp_list.off
			loop
				l_bp_item := l_bp_list.item_for_iteration
				if l_bp_item.is_set_for_application then
					debug ("debugger_trace_breakpoint")
						print ("REMOVE APPLICATION BP :: " + l_bp_item.routine.associated_class.name_in_upper +"."+ l_bp_item.routine.name +" @ " + l_bp_item.breakable_line_number.out + "%N")
					end
					remove_dotnet_breakpoint (l_bp_item)
					l_bp_item.set_application_not_set					
					-- then next time we go with StopPoint enable ... we'll add them again
				end
				l_bp_list.forth
			end
		end		

feature -- BreakPoints

	add_dotnet_breakpoint (bp: BREAKPOINT) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		local
			f: E_FEATURE
			i: INTEGER

			l_feature_token: INTEGER
			l_il_offset_list: LIST [INTEGER]
			l_il_offset: INTEGER
			
			l_module_name: STRING
			l_class_c: CLASS_C
			l_class_token: INTEGER
			
			l_is_entry_point: BOOLEAN
			
			l_class_type_list: TYPE_LIST
			l_class_type: CLASS_TYPE			
		do
			f := bp.routine
			i := bp.breakable_line_number
			debug ("debugger_trace_breakpoint")
				print ("AddBreakpoint " + f.name + " index=" + i.out + "%N")
				display_feature_info (f)
			end
			
			l_class_c := f.written_class			
			l_is_entry_point := is_entry_point (f)

				--| loop on the different derivation of a generic class
			l_class_type_list := l_class_c.types
			from
				l_class_type_list.start
			until
				l_class_type_list.after
			loop
				l_class_type := l_class_type_list.item
				l_module_name := Il_debug_info_recorder.module_file_name_for_class (l_class_type)			
				l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)
				l_feature_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (f.associated_feature_i, l_class_type)

				l_il_offset_list := Il_debug_info_recorder.feature_breakable_il_line_for (l_class_type, f.associated_feature_i, i)
				if l_il_offset_list /= Void then
					from
						l_il_offset_list.start
					until
						l_il_offset_list.after
					loop
						l_il_offset := l_il_offset_list.item
						eifnet_debugger.Eifnet_debugger_info.request_breakpoint_add (l_module_name, l_class_token, l_feature_token, l_il_offset)
	
						if l_is_entry_point and then Il_debug_info_recorder.entry_point_token /= l_feature_token then
							eifnet_debugger.Eifnet_debugger_info.request_breakpoint_add (
									l_module_name, l_class_token, Il_debug_info_recorder.entry_point_token , l_il_offset
								)
						end
						l_il_offset_list.forth
					end		
				else
					check False end -- Should not occurs, unless data are corrupted
				end
				l_class_type_list.forth
			end
		end
		
	remove_dotnet_breakpoint (bp: BREAKPOINT) is
			-- remove the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		local
			f: E_FEATURE
			i: INTEGER

			l_feature_token: INTEGER
			l_il_offset_list: LIST [INTEGER]
			l_il_offset: INTEGER
			
			l_module_name: STRING
			l_class_c: CLASS_C
			l_class_token: INTEGER
			
			l_is_entry_point: BOOLEAN
			
			l_class_type_list: TYPE_LIST
			l_class_type: CLASS_TYPE
		
		do
			f := bp.routine
			i := bp.breakable_line_number
			debug ("debugger_trace_breakpoint")
				print ("RemoveBreakpoint " + f.name + " index=" + i.out + "%N")
				display_feature_info (f)
			end
			
			l_class_c := f.written_class			

			l_is_entry_point := is_entry_point (f)

			--| loop on the different derivation of a generic class	
			l_class_type_list := l_class_c.types
			from
				l_class_type_list.start
			until
				l_class_type_list.after
			loop
				l_class_type := l_class_type_list.item
				l_module_name := Il_debug_info_recorder.module_file_name_for_class (l_class_type)
				l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)
				l_feature_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (f.associated_feature_i, l_class_type)

				l_il_offset_list := Il_debug_info_recorder.feature_breakable_il_line_for (l_class_type, f.associated_feature_i, i)
				if l_il_offset_list /= Void then
					from
						l_il_offset_list.start
					until
						l_il_offset_list.after
					loop
						l_il_offset := l_il_offset_list.item
						eifnet_debugger.Eifnet_debugger_info.request_breakpoint_remove (l_module_name, l_class_token, l_feature_token, l_il_offset)
	
						if l_is_entry_point and then Il_debug_info_recorder.entry_point_token /= l_feature_token then
							eifnet_debugger.Eifnet_debugger_info.request_breakpoint_remove (
									l_module_name, l_class_token, Il_debug_info_recorder.entry_point_token , l_il_offset
								)
						end
						l_il_offset_list.forth
					end
				else
					check False end -- Should not occurs, unless data are corrupted
				end
				l_class_type_list.forth
			end
		end		

feature {NONE} -- Implementation

	display_feature_info (f: E_FEATURE) is
		require
			f /= Void
		local
			l_class_c: CLASS_C
			
			l_str: STRING
			l_types: TYPE_LIST
			l_class_type: CLASS_TYPE

			l_class_token: INTEGER
			l_module_name: STRING
		do
			l_str := "----%N"
			l_str.append_string ("%TFeature :: ")
						
			l_class_c := f.written_class

			l_str.append_string ("%N%T Associated class="+ f.associated_class.name_in_upper + "%T")
			l_str.append_string ("%N%T Written class="+ f.written_class.name_in_upper )
			
			if l_class_c /= Void then
				l_str.append_string ("%N%T class id=" + l_class_c.class_id.out + " [" + l_class_c.name_in_upper)

				if l_class_c.is_generic then
					l_str.append_string (" !Generic! ")
					l_types := l_class_c.types
					from
						l_types.start
					until
						l_types.after
					loop
						l_class_type := l_types.item
						l_module_name := Il_debug_info_recorder.module_file_name_for_class (l_class_type)
						l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)
						l_str.append_string ("%T" + l_class_token.out)
						l_str.append_string (" ~ 0x" + l_class_token.to_hex_string)
						l_types.forth
					end
				else
					l_types := l_class_c.types
					l_class_type := l_types.first
					l_module_name := Il_debug_info_recorder.module_file_name_for_class (l_class_type)
					l_class_token := Il_debug_info_recorder.class_token (l_module_name, l_class_type)

					l_str.append_string (":" + l_class_token.out)
					l_str.append_string (" ~ 0x" + l_class_token.to_hex_string)
				end
				l_str.append_string ("]")
				l_str.append_string ("%N")

			end
			l_str.append_string ("%T module_name="+Il_debug_info_recorder.module_file_name_for_class (l_class_type) )
			
			print (l_str)
			print ("%N")
		end

feature -- Evaluation

	notify_evaluation_done is
		local
		do
			debug ("debugger_trace")
				print ("%N%T !!! notify_evaluation_done !!! %N")
			end
		end

feature {NONE} -- Events on notification

	notify_execution_on_exit_process is
			-- 
		do
			--| We need to stop
			--| Already "stopped" but let's be sure ..
	
			status.set_is_stopped (True)
			eifnet_debugger.on_exit_process
		end
		
	notify_execution_on_stopped is
		do
			debug ("debugger_trace")
				print ("%N*** REASON TO STOP *** %N")
				print ("%T Callback = " + Eifnet_debugger_info.last_managed_callback_name +"%N")

				if Eifnet_debugger_info.last_managed_callback_is_breakpoint then
					display_breakpoint_info (Eifnet_debugger_info.icd_breakpoint)
				end
			end -- debug
			
--			Application_notification_controller.notify_on_before_stopped	

			--| We need to stop
			--| Already "stopped" but let's be sure ..
			status.set_is_stopped (True)
			status.set_top_level

			--| CallStack
			status.reload_call_stack --| since we stop, let's reload the whole callstack
			
			debug ("debugger_trace_callstack")
				io.put_new_line
				print (" ########################################### %N")
				print (" ### CallStack : Head level ## 0x"+Eifnet_debugger_info.last_step_complete_reason.to_hex_string +" ## %N")
				print (" ########################################### %N")
--				io.put_new_line
--				print (frame_callstack_info (Eifnet_debugger.active_frame))
--				io.put_new_line
				display_full_callstack_info
			end


			if Eifnet_debugger_info.last_managed_callback_is_breakpoint then
				status.set_reason_as_break
			end
			if Eifnet_debugger_info.last_managed_callback_is_step_complete then
				status.set_reason_as_step
			end			
			if Eifnet_debugger_info.last_managed_callback_is_exception then
				status.set_reason_as_raise				
				status.set_exception (0, "Exception occured .. waiting for information")

			end
--			set_current_execution_stack (1)
			Application.set_current_execution_stack_number (Application.number_of_stack_elements)

			Application_notification_controller.notify_on_after_stopped
		end

	display_breakpoint_info (icd_bp: ICOR_DEBUG_BREAKPOINT) is
		local
			l_icd_bp: ICOR_DEBUG_BREAKPOINT
			l_icd_func_bp: ICOR_DEBUG_FUNCTION_BREAKPOINT
			l_function: ICOR_DEBUG_FUNCTION
		do
			print ("%T Breakpoint:%N")
			l_icd_bp := icd_bp
			l_icd_func_bp := l_icd_bp.query_interface_icor_debug_function_breakpoint
			if l_icd_func_bp /= Void then
			
				print ("%T   - Offset = " + l_icd_func_bp.get_offset.out + "%N")
				l_function := l_icd_func_bp.get_function
				print ("%T   - Function = " + l_function.to_string + "%N")
			end
		end

feature -- Call stack related

	frame_callstack_info (a_frame: ICOR_DEBUG_FRAME): STRING is
			-- obsolete "To remove soon or later, this is just a debug use for now"
			-- Called by `select_actions' of `but_callstack_update'.
		local
			l_frame_il: ICOR_DEBUG_IL_FRAME
			l_output: STRING
			

			l_func: ICOR_DEBUG_FUNCTION
			l_class_token: INTEGER
			l_feature_token: INTEGER
			l_module_name: STRING
			l_module_display: STRING

			l_class_type: CLASS_TYPE
			l_class_name: STRING
			l_feature_i : FEATURE_I
			l_feature_name: STRING
			
			l_eiffel_bp_slot: INTEGER
			l_il_offset: INTEGER
		do
			l_output := ""
			if a_frame = Void then
				--| FIXME: JFIAT
				l_output := "Debugger not synchronized => no information available%N" 
			else
				l_frame_il := a_frame.query_interface_icor_debug_il_frame
				if a_frame.last_call_succeed and then l_frame_il /= Void then
					l_func := l_frame_il.get_function
					l_feature_token := l_func.get_token
					l_class_token := l_func.get_class.get_token
					l_module_name := l_func.get_module.get_name
	
					l_module_display := l_module_name.twin
					l_module_display.keep_tail (20)
					l_module_display.prepend_string (" ..")
	
					l_class_type := Il_debug_info_recorder.class_type_for_module_class_token (l_module_name, l_class_token)
					if l_class_type /= Void then
						l_class_name := l_class_type.associated_class.name_in_upper
					else
						l_class_name := "<?"+ l_class_token.out + "?>"
					end
					l_feature_i := Il_debug_info_recorder.feature_i_by_module_class_token (l_module_name, l_class_token, l_feature_token)
					if l_feature_i /= Void then
						l_feature_name := Il_debug_info_recorder.feature_i_by_module_class_token (l_module_name, l_class_token, l_feature_token).feature_name
					else
						l_feature_name := "<?"+ l_feature_token.out + "?>"
					end
	
					if l_class_type /= Void and then l_feature_i /= Void then
						l_il_offset := l_frame_il.get_ip
						l_eiffel_bp_slot := Il_debug_info_recorder.feature_eiffel_breakable_line_for_il_offset(l_class_type, l_feature_i, l_il_offset)
						l_output.append_string ("  + <" 
							+ l_eiffel_bp_slot.out
							+ " | " 
							+ l_il_offset.out + ":0x" + l_il_offset.to_hex_string + "> "
							+ l_class_name + "." + l_feature_name + "%N"
							+ "%T0x"+l_class_token.to_hex_string
							+ " :: 0x"+ l_feature_token.to_hex_string
							+ "%N%T Module=" + l_module_display
							)
	
						l_output.append_string ("%N")
					else
						l_output.append_string ("  - <"+ l_frame_il.get_ip.out + ":0x" + l_frame_il.get_ip.to_hex_string + "> ")
						l_output.append_string (" [???] ")
						if l_class_type /= Void then
							l_output.append_string ("%T " + l_class_name)
						end
						if l_feature_i /= Void then
							l_output.append_string ("." + l_feature_name)
						end
							
						l_output.append_string ("%N")
						l_output.append_string ("%T0x" + l_class_token.to_hex_string )
						l_output.append_string (" :: 0x"+l_feature_token.to_hex_string)
						l_output.append_string (" module=" + l_module_display + "%N")
					end
	
				end
			end			
			Result := l_output
		end

	display_full_callstack_info is
			-- obsolete "To remove soon or later, this is just a debug use for now"
			-- Called by `select_actions' of `but_callstack_update'.
		local
			l_active_thread: ICOR_DEBUG_THREAD
			l_enum_chain: ICOR_DEBUG_CHAIN_ENUM			
			l_chain: ICOR_DEBUG_CHAIN
			l_enum_frames: ICOR_DEBUG_FRAME_ENUM
			l_chains: ARRAY [ICOR_DEBUG_CHAIN]
			l_frames: ARRAY [ICOR_DEBUG_FRAME]
			l_frame: ICOR_DEBUG_FRAME
			c: INTEGER
			i: INTEGER
			l_output: STRING

		do
			l_active_thread := Eifnet_debugger.icor_debug_thread

			l_enum_chain := l_active_thread.enumerate_chains
			if l_active_thread.last_call_succeed and then l_enum_chain.get_count > 0 then
				l_chains := l_enum_chain.next (l_enum_chain.get_count)
				from
					c := l_chains.lower
				until
					c > l_chains.upper
				loop
					l_chain := l_chains @ c
					if l_chain /= Void then
						
						l_output := "%N ###################################################### %N"
						l_output.append_string (" Callstack from Chain : " + l_chain.item.out + "%N")
						l_output.append_string (" ###################################################### %N%N")
					
						l_enum_frames := l_chain.enumerate_frames
						if l_chain.last_call_succeed and then l_enum_frames.get_count > 0 then
							l_frames := l_enum_frames.next (l_enum_frames.get_count)
							from
								i := l_frames.lower
							until
								i > l_frames.upper
							loop
								l_frame := l_frames @ i
								l_output.append_string ("... chain::" + c.out + " frame::" + i.out + " =%N")
								l_output.append_string (frame_callstack_info (l_frame))
								i := i + 1
							end		
						end
					end
					
					c := c + 1
				end
			end
			
			io.put_new_line
			io.put_new_line
			io.put_string (l_output)
			io.put_new_line
		end

feature -- Object Keeper

	keep_object (adv: ABSTRACT_DEBUG_VALUE) is
		do
			Debug_value_keeper.keep (adv)
		end

	remove_kept_object_by_address (add: STRING) is
		do
			Debug_value_keeper.remove_by_address (add)
		end

	recycle_kept_object is
		do
			Debug_value_keeper.recycle
		end

	keep_only_objects (a_addresses: LIST [STRING]) is
		do
			Debug_value_keeper.keep_only (a_addresses)
		end

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
		do
			Result := Debug_value_keeper.debug_value_kept.item (a_address)
		end

	know_about_kept_object (a_address: STRING): BOOLEAN is
		do
			Result := Debug_value_keeper.know_about (a_address)
		end

end -- class APPLICATION_EXECUTION_DOTNET
