indexing
	description: "Interface to access dot debugger services"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

inherit 

	EIFNET_EXPORTER
		export
			{NONE} all
		end
	
	ICOR_EXPORTER
		export
			{NONE} all
		end	
	
	EIFNET_DEBUGGER_INFO_ACCESSOR
		export
			{NONE} all
			{ANY} icor_debug_app_domain, icor_debug_breakpoint, icor_debug_process, icor_debug_thread
			{ANY} Eifnet_debugger_info, data_changed, reset_data_changed
		end	

	EIFNET_DEBUGGER_SYNCHRO
		export
			{NONE} all
			{APPLICATION_EXECUTION_DOTNET} stop_dbg_timer
		end	

	EIFNET_DEBUGGER_TRACER_ACCESS
		export
			{NONE} all
		end

	SHARED_DEBUG
		export
			{NONE} all
		end		

	EIFNET_DEBUGGER_CONTROL_CONSTANTS
		export
			{NONE} all
		end		

	DEBUG_OUTPUT_SYSTEM_I
		export
			{NONE} all
		end
		
	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
			{ICOR_DEBUG_MANAGED_CALLBACK} Il_debug_info_recorder
		end	

create
	make

feature -- Initialization

	make is
			-- Creation
		do
		end
		
	initialize_clr_host is
			-- Initialize dotnet runtime, to be sure to use the correct version of the
			-- runtime after while
		local
			l_host: CLR_HOST
		once
			(create {CLI_COM}).initialize_com
			l_host := (create {CLR_HOST_FACTORY}).runtime_host (Eiffel_system.System.clr_runtime_version)			
		end
		
	initialize_debugger_session is
			-- Initialize a debugger session 
		require
			not is_debugging
		local
			icor_debug_ptr: POINTER

			icor_debug_managed_callback_obj: ICOR_DEBUG_MANAGED_CALLBACK
			icor_debug_unmanaged_callback_obj: ICOR_DEBUG_UNMANAGED_CALLBACK
		do
			initialize_clr_host
			Eifnet_debugger_info.set_controller (Current)

			eif_debug_display ("[EIFDBG] initialize debugger session")
			icor_debug_ptr := (create {ICOR_DEBUG_FACTORY}).new_cordebug_pointer
			if icor_debug_ptr /= Default_pointer then
				set_last_icor_debug_by_pointer (icor_debug_ptr)
	
				icor_debug_managed_callback_obj := (create {ICOR_DEBUG_MANAGED_CALLBACK_FACTORY}).new_cordebug_managed_callback
				icor_debug_managed_callback_obj.initialize_callback
				
				icor_debug_unmanaged_callback_obj := (create {ICOR_DEBUG_UNMANAGED_CALLBACK_FACTORY}).new_cordebug_unmanaged_callback
				icor_debug_unmanaged_callback_obj.initialize_callback
	
				icor_debug.initialize
				if icor_debug.last_call_succeed then
					icor_debug_managed_callback_obj.add_ref
					icor_debug.set_managed_handler (icor_debug_managed_callback_obj)
					icor_debug_unmanaged_callback_obj.add_ref			
					icor_debug.set_unmanaged_handler (icor_debug_unmanaged_callback_obj)				
		
					init_dbg_synchronisation
					enable_estudio_callback
					start_dbg_timer
					is_debugging := True
				end
			else
				is_debugging := False
			end
		ensure 
			is_debugging implies icor_debug /= Void
		end

	terminate_debugger is
			-- Terminate the debugging session
		require
			is_debugging: is_debugging
		local
			l_icor_dbg_pro: ICOR_DEBUG_PROCESS
		do
			eif_debug_display ("[EIFDBG] terminate debugging")
			l_icor_dbg_pro := icor_debug_process
			if l_icor_dbg_pro /= Void then
				eif_debug_display ("[EIFDBG] pProcess->Terminate (..)")
				l_icor_dbg_pro.stop (infinite_time) --| to get the hand on and to be synchronized
				l_icor_dbg_pro.terminate (1)
				--| the end of the killing process will be done on callback ExitProcess

			else
				eif_debug_display ("[EIFDBG] could not find ICorDebugProcess object ...")
			end
	
--			stop_dbg_timer

--			Eifnet_debugger_info.reset
--			Eifnet_debugger_info.set_controller (Void)
--			Application.process_termination			

		end

	on_exit_process	is
			-- 
		do
			Eifnet_debugger_info.icd.terminate
			eif_debug_display ("[EIFDBG] execution exiting")
			
			is_debugging := False			
			Application.process_termination			
		ensure
			not is_debugging
		end		

	is_debugging: BOOLEAN

feature -- Status

	last_dbg_call_success: INTEGER

	last_dbg_call_succeed: BOOLEAN is
			-- 
		do
			Result := last_dbg_call_success = 0
		end

feature -- Callback notification about synchro

	estudio_callback_event is
			-- 
		do
--			print ("eStudio : Notification callback done%N")
			Application.imp_dotnet.estudio_callback_notify
		end
		
feature -- Interaction with .Net Debugger

	waiting_debugger_callback (a_title: STRING) is
		do
			debug ("debugger_trace_operation")
				print ("%N... Waiting for debugger to callback...%N%N")
			end
			
			eif_debug_display ("[EIFDBG] " + a_title)
		end

	do_run is
			-- Start the process to debug
		require
		do
			icor_debug.create_process (debug_param_executable + " " + debug_param_arguments, debug_param_directory)
			waiting_debugger_callback ("run process")
			last_dbg_call_success := icor_debug.last_call_success
		end

	do_stop is
		require
			process_exists: icor_debug_process /= Void
		do
			icor_debug_process.stop (infinite_time)
			debug ("debugger_eifnet_data")
				print ("EIFNET_DEBUGGER.do_stop : after stop icor_debug_process.last_call_success = " + icor_debug_process.last_error_code_id + "%N")
			end
			
			waiting_debugger_callback ("stop")
			last_dbg_call_success := icor_debug_process.last_call_success
		end

	do_continue is
		require
			process_exists: icor_debug_process /= Void
		do
			icor_debug_process.continue (False)
--			waiting_debugger_callback ("continue")
			last_dbg_call_success := icor_debug_process.last_call_success
		end
		
	do_clear_exception is
			-- Clear current exception
		local
			l_thread: ICOR_DEBUG_THREAD
		do
			l_thread := Eifnet_debugger_info.icd_thread
			if l_thread /= Void then
				l_thread.clear_current_exception
--				check
--					l_thread.last_call_succeed
--				end
			end
		end	

feature -- Stepping Access

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
		
feature {NONE} -- Stepping Implementation

	last_stepper: ICOR_DEBUG_STEPPER

	get_stepper: BOOLEAN is
			-- Retrieve or Create Stepper
			-- Result value is the error code
		local
			l_stepper: ICOR_DEBUG_STEPPER
			l_thread: ICOR_DEBUG_THREAD
			l_frame: ICOR_DEBUG_FRAME	
			l_error: INTEGER			
		do
			if last_stepper /= Void then
				last_stepper.deactivate
				last_stepper := Void				
			end

			
--			debug ("DEBUGGER_TRACE_STEPPING")
--				if 
--					Eifnet_debugger_info.last_managed_callback_is_step_complete
--					and then Eifnet_debugger_info.icd_stepper /= Void 
--				then
--					print ("[?] Stepper.IsActive ??? => ")
--					if Eifnet_debugger_info.icd_stepper.is_active then
--						print ("Yes %N")
--					else
--						print ("No  %N")
--					end
--	--				last_stepper := Eifnet_debugger_info.icd_stepper
--				end
--			end

			l_thread := icor_debug_thread
			if l_thread /= Void then
				l_frame := l_thread.get_active_frame
				if l_thread.last_call_succeed and then l_frame /= Void then
					l_stepper := l_frame.create_stepper			
					l_error := l_frame.last_call_success
				else
					l_stepper := l_thread.create_stepper
					l_error := l_thread.last_call_success
				end	
				Result := l_error = 0
				last_stepper := l_stepper
				last_stepper.add_ref				
			else
				Result := False
				eif_debug_display ("[DBG/WARNING] No thread available ...")
			end
		end


--	set_last_stepping_mode (a_mode: INTEGER) is
--		require
--			step_value_valid: Eifnet_debugger_info.valid_stepping_mode (a_mode)
--		do
--			Eifnet_debugger_info.set_last_stepping_mode (a_mode)
--		end

	do_step (a_mode: INTEGER) is
		require
--			valid_step_mode: (a_mode = cst_control_step_next) 
--								or else (a_mode = cst_control_step_in)
--								or else (a_mode = cst_control_step_out)						
			process_exists: icor_debug_process /= Void
		local
			l_succeed: BOOLEAN
			l_controller: ICOR_DEBUG_CONTROLLER			
		do
			l_succeed := get_stepper
			if l_succeed then
				--| Manage the step
				inspect	a_mode
				when cst_control_step_next then
					last_stepper.step (False)
				when cst_control_step_into then
					last_stepper.step (True)
				when cst_control_step_out then
					last_stepper.step_out
				else
					last_stepper.step (False)
				end
				check last_stepper.check_last_call_succeed end
				
				--| Get the controller
				l_controller := icor_debug_thread.get_process
				check icor_debug_thread.check_last_call_succeed end
				
				--| And continue the debugging
				l_controller.continue (False)
				check l_controller.check_last_call_succeed end
			else
				debug  ("DEBUGGER_TRACE_EIFNET")
					eif_debug_display ("[DBG/WARNING] No stepper made available ...")			
				end
			end
		end

feature -- Stepping Access
		
	do_step_range (a_bstep_in: BOOLEAN; a_il_ranges: ARRAY [TUPLE [INTEGER, INTEGER]]) is
			-- Step next.
		local
			l_succeed: BOOLEAN
			l_controller: ICOR_DEBUG_CONTROLLER

		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_range ("+a_bstep_in.out+")%N")
			end
--			if a_bstep_in then
--				set_last_stepping_mode (cst_step_range_into)
--			else			
--				set_last_stepping_mode (cst_step_range_next)
--			end
			l_succeed := get_stepper
			if l_succeed then
				debug  ("DEBUGGER_TRACE_EIFNET")
					print ("[>] Stepping using ICorDebugStepper [0x"+last_stepper.out+"]%N")
				end
				last_stepper.step_range (a_bstep_in, a_il_ranges)
				check last_stepper.check_last_call_succeed end				

				--| Get the controller
				l_controller := icor_debug_thread.get_process
				check icor_debug_thread.check_last_call_succeed end
				
				--| And continue the debugging
				l_controller.continue (False)
				check l_controller.check_last_call_succeed end				
			else
				eif_debug_display ("[DBG/WARNING] No stepper made available ...")			
			end

			waiting_debugger_callback ("step range")			
		end

	do_step_next is
			-- Step next.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_next%N")
			end
			
--			set_last_stepping_mode (cst_step_next)
			
			do_step (cst_control_step_next)
			waiting_debugger_callback ("step next")
		end

	do_step_into is
			-- Step in.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_into%N")
			end
			
--			set_last_stepping_mode (cst_step_into)
			do_step (cst_control_step_into)
			waiting_debugger_callback ("step into")
		end		

	do_step_out is
			-- Step out.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_out%N")
			end
			
--			set_last_stepping_mode (cst_step_out)
			do_step (cst_control_step_out)
			waiting_debugger_callback ("step out")
		end		

	stepping_possible: BOOLEAN is
			-- 
		do
			Result := icor_debug_process /= Void and then icor_debug_thread /= Void
		end

feature -- Debuggee Session Parameters

	debug_param_directory: STRING is
			-- Directory from where the debugger runs the process
		do
			Result := Eifnet_debugger_info.param_directory
		end

	debug_param_executable: STRING is
			-- Filename to the executable to debug
		do
			Result := Eifnet_debugger_info.param_executable
		end
			
	debug_param_arguments: STRING is
			-- Arguments
		do
			Result := Eifnet_debugger_info.param_arguments
		end

feature -- Change Debuggee Session Parameters
	
	set_debug_param_directory (a_dir: STRING) is
		do
			Eifnet_debugger_info.set_param_directory (a_dir)
		end

	set_debug_param_executable (a_exec: STRING) is
		do
			Eifnet_debugger_info.set_param_executable (a_exec)
		end

	set_debug_param_arguments (a_arg: STRING) is
		do
			Eifnet_debugger_info.set_param_arguments (a_arg)
		end		

feature -- Bridge to EIFNET_DEBUGGER_INFO

	last_managed_callback_is_exception: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_managed_callback_is_exception
		end	
		
	last_managed_callback_is_eval_exception: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_managed_callback_is_eval_exception
		end	

	active_exception_value: ICOR_DEBUG_VALUE is
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			l_last_thread := icor_debug_thread
			if l_last_thread /= Void then
				Result := l_last_thread.get_current_exception
			end
		end

	active_frame: ICOR_DEBUG_FRAME is
		local
			l_last_thread: ICOR_DEBUG_THREAD
			l_active_frame: ICOR_DEBUG_FRAME

		do
			l_last_thread := icor_debug_thread
			if l_last_thread /= Void then
				l_active_frame := l_last_thread.get_active_frame
				if l_last_thread.last_call_succeed and then l_active_frame /= Void then
					l_active_frame.add_ref
					Result := l_active_frame
				end
			end
		end

--	active_il_frame: ICOR_DEBUG_IL_FRAME is
--		local
--			l_active_frame: ICOR_DEBUG_FRAME
--
--			l_il_frame: ICOR_DEBUG_IL_FRAME
--		do
--			l_active_frame := active_frame
--			if l_active_frame /= Void then
--				l_il_frame := l_active_frame.query_interface_icor_debug_il_frame
--				if l_active_frame.last_call_success = 0 then
--					l_il_frame.add_ref
--					Result := l_il_frame
--				end
--			end
--		end
--
--	active_il_offset: INTEGER is
--		do
--			Result := il_offset_from (active_il_frame)
--		end
--		
--	il_offset_from (a_frame: ICOR_DEBUG_IL_FRAME): INTEGER is
--			-- IL Offset for the frame `a_frame'
--		do
--			if a_frame /= Void then
--				Result := a_frame.get_ip
--			end		
--		end	

	icd_function_from (a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_FUNCTION is
			-- CorDebugFunction from `a_frame'
		do
			if a_frame /= Void then
				Result := a_frame.get_function
				if a_frame.last_call_success = 0 then
					Result.add_ref
				else
					Result := Void
				end
			end
		end
		
	icd_module_from (a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_MODULE is
			-- CorDebugModule from `a_frame'
		local
			l_function: ICOR_DEBUG_FUNCTION			
		do
			l_function := icd_function_from (a_frame)
			if l_function /= Void then
				Result := l_function.get_module
				if l_function.last_call_success = 0 then
					Result.add_ref
				else
					Result := Void
				end
			end			
		end

--	helper_thread_id: INTEGER is
--		do
--			if icor_debug_process /= Void then
--				Result := icor_debug_process.get_helper_thread_id
--			end
--		end
		
		
feature -- Function Evaluation

	Internal_string_builder_name: STRING is "internal_string_builder"
	
	string_value_from_string_class_object_value (icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): STRING is
		local
			l_icd_value: ICOR_DEBUG_VALUE
			
			l_string_class: CLASS_C
			l_feat_internal_string_builder: FEATURE_I
			l_feat_internal_string_builder_token: INTEGER
		do
			if icd_string_instance = Void then
				Result := "Void"
			else
				--| Get STRING info from compilo
				l_string_class := Eiffel_system.String_class.compiled_class
				--| Get token to access `internal_string_builder'
				l_feat_internal_string_builder := l_string_class.feature_named (Internal_string_builder_name)
				l_feat_internal_string_builder_token := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_internal_string_builder)
				--| Get `internal_string_builder' from `STRING' instance Value
				l_icd_value := icd_string_instance.get_field_value (icd_string_instance.get_class, l_feat_internal_string_builder_token)
				--| l_icd_value represents the `internal_string_builder' value
				if l_icd_value /= Void then
					Result := (create {EIFNET_DEBUG_EXTERNAL_FORMATTER}).string_from_string_builder (l_icd_value)
				end
--				if Result = Void then
--					Result := "Error : Unavailable"				
--				end
			end
		end

 	debug_output_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; a_class_type: CLASS_TYPE): STRING is
			-- Debug ouput string value
		local
			l_icd: ICOR_DEBUG_VALUE		
			l_icd_object: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: INTEGER
			
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION

			l_debug_info : EIFNET_DEBUG_VALUE_INFO
			skip_debug_output_evaluation: BOOLEAN
		do	
--			skip_debug_output_evaluation := True
			if skip_debug_output_evaluation then
				Result := Void --"debug_output evaluation is OFF"
			else	
				l_icd := a_icd
				l_icd_object := a_icd_obj
	
				l_class_type := a_class_type
				l_feat := debug_output_feature_i (a_class_type.associated_class)
				if l_feat /= Void then
					l_icd_class := l_icd_object.get_class
					l_icd_module := l_icd_class.get_module
					l_module_name := l_icd_module.get_name
				
					l_feature_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (l_feat, l_class_type)
					l_func := l_icd_module.get_function_from_token (l_feature_token)
	
					if l_func /= Void then
						l_icd := function_evaluation (a_frame, l_icd, l_func)
						if l_icd /= Void then
							create l_debug_info.make (l_icd)
							Result := string_value_from_string_class_object_value (l_debug_info.interface_debug_object_value)							
						else
							Result := Void -- "WARNING: Could not evaluate output"	
						end
					else
						debug ("DEBUGGER_TRACE_EVAL")
							print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve ICorDebugFunction %N")
							print ("                                :: class name    = ["+l_class_type.full_il_type_name+"]%N")
							print ("                                :: module_name   = %""+l_module_name+"%"%N")
							print ("                                :: feature_token = 0x"+l_feature_token.to_hex_string+" %N")
						end
					end
	
				else
					debug ("DEBUGGER_TRACE_EVAL")
						print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve FEATURE_I ["+l_class_type.associated_class.name_in_upper+"] %N")
					end
				end
				debug ("DEBUGGER_TRACE_EVAL")
					if Result = Void then
						print ("EIFNET_DEBUGGER.debug_output_.. :: Error: non debuggable ;) %N")
					end
				end
			end		
		end	

 	to_string_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING is
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE		
			l_icd_object: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: INTEGER
			l_func: ICOR_DEBUG_FUNCTION
			l_debug_info : EIFNET_DEBUG_VALUE_INFO
			skip_debug_output_evaluation: BOOLEAN
			l_formatter: EIFNET_DEBUG_EXTERNAL_FORMATTER
		do	
--			skip_debug_output_evaluation := True
			if skip_debug_output_evaluation then
				Result := Void --"debug_output evaluation is OFF"
			else	
				l_icd := a_icd
				l_icd_object := a_icd_obj
				l_icd_class := l_icd_object.get_class
				l_icd_module := l_icd_class.get_module
				l_module_name := l_icd_module.get_name
				
				create l_formatter
				l_feature_token := l_formatter.token_Exception_ToString
				l_func := l_icd_module.get_function_from_token (l_feature_token)
	
				if l_func /= Void then
					l_icd := function_evaluation (a_frame, l_icd, l_func)
					if l_icd /= Void then
							--| We should get a System.String
						create l_debug_info.make (l_icd)
						Result := l_formatter.system_string_value_to_string (l_debug_info.interface_debug_object_value)							
					else
						Result := Void -- "WARNING: Could not evaluate output"	
					end
				end
			end
		end

	function_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_func: ICOR_DEBUG_FUNCTION): ICOR_DEBUG_VALUE is
			-- Function evaluation result for `a_func' on `a_icd'
		require
--			frame_not_void: a_frame /= Void
			object_not_void: a_icd /= Void
			func_not_void: a_func /= Void
		local
			l_chain: ICOR_DEBUG_CHAIN
			l_func: ICOR_DEBUG_FUNCTION
			l_icd_thread: ICOR_DEBUG_THREAD
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			l_func := a_func
			if a_frame /= Void then
				l_chain := a_frame.get_chain
				l_icd_thread := l_chain.get_thread
			else
				l_icd_thread := icor_debug_thread
			end
			l_icd_eval := l_icd_thread.create_eval
			l_status := Application.imp_dotnet.status
			l_status.set_is_evaluating (True)
				--| Let use the evaluating mecanism instead of the normal one
				--| then let's disable the timer
			stop_dbg_timer
			l_icd_eval.call_function (l_func, 1, << a_icd >>)
			do_continue
			lock_and_wait_for_callback
			reset_data_changed

			if 
				Application.imp_dotnet.eifnet_debugger.last_managed_callback_is_exception 
			then
				Result := Void --"WARNING: Could not evaluate output"
				debug ("DEBUGGER_TRACE_EVAL")
					display_last_exception
					print ("EIFNET_DEBUGGER.debug_output_.. :: WARNING Exception occured %N")
				end
				do_clear_exception
			else
				if l_icd_eval /= Void then
					Result := l_icd_eval.get_result
				end
			end
			l_status.set_is_evaluating (False)
			start_dbg_timer					
		end

feature {NONE}

	display_last_exception is
			-- 
		require
			last_managed_callback_is_exception
		local
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
			l_exception: ICOR_DEBUG_VALUE
		do
			l_exception := active_exception_value
			if l_exception /= Void then
				create l_exception_info.make (active_exception_value)
	
				print ("%N%NException ....%N")
				print ("%T Class   => " + l_exception_info.value_class_name + "%N")
				print ("%T Module  => " + l_exception_info.value_module_file_name + "%N")
				print ("%T Message => " + (create {EIFNET_EXCEPTION_CODE} ).exception_string_representation (l_exception_info.value_class_token ) + "%N")			
			end
		end

feature {NONE} -- External

	Infinite_time: INTEGER is 0xFFFFFFFF
			-- Value for C externals to have an infinite wait

end -- class EIFNET_DEBUGGER

