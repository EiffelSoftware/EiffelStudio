indexing
	description: "Interface to access dotnet debugger services"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

inherit 

	EIFNET_DEBUGGER_INFO_ACCESSOR

	EIFNET_EXPORTER
		export
			{NONE} all
		end
	
	ICOR_EXPORTER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	EIFNET_DEBUGGER_SYNCHRO
		export
			{NONE} all
			{EIFNET_EXPORTER} dbg_timer_active, stop_dbg_timer, start_dbg_timer, lock_and_wait_for_callback
		end

	SHARED_DEBUG
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
			{ICOR_DEBUG_MANAGED_CALLBACK, EIFNET_EXPORTER} Il_debug_info_recorder
		end	
		
	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Creation
		do
			create evaluator.make (Current)
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
			
			do_step (cst_control_step_next)
			waiting_debugger_callback ("step next")
		end

	do_step_into is
			-- Step in.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_into%N")
			end
			
			do_step (cst_control_step_into)
			waiting_debugger_callback ("step into")
		end		

	do_step_out is
			-- Step out.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_out%N")
			end
			
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
		
feature -- Tracer

	eif_debug_display (msg: STRING) is
		do
		end

feature {EIFNET_EXPORTER} -- Restricted Bridge to EIFNET_DEBUGGER_INFO

	set_last_managed_callback (a_cb: like last_managed_callback) is
		do
			eifnet_debugger_info.set_last_managed_callback (a_cb)
		end
		
	last_managed_callback: INTEGER is
		do
			Result := Eifnet_debugger_info.last_managed_callback
		end	
		
feature -- Bridge to EIFNET_DEBUGGER_INFO

	last_managed_callback_is_exception: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_managed_callback_is_exception
		end	
		
	last_exception_is_handled: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_exception_is_handled
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
		
feature -- Easy access

	icor_debug_class (a_class_type: CLASS_TYPE): ICOR_DEBUG_CLASS is
		require
			arg_class_type_void: a_class_type /= Void
		local
			l_class_module_name: STRING
			l_icd_module: ICOR_DEBUG_MODULE
			l_class_token: INTEGER
		do
			l_class_module_name := Il_debug_info_recorder.module_file_name_for_class (a_class_type)
			l_icd_module := icor_debug_module (l_class_module_name)
			l_class_token := Il_debug_info_recorder.class_token (l_class_module_name, a_class_type)
			Result := l_icd_module.get_class_from_token (l_class_token)
		end
		
feature -- Function Evaluation

	Internal_string_builder_name: STRING is "internal_string_builder"

	Internal_make_from_cil_name: STRING is "make_from_cil";
	
	eiffel_string_make_from_cil_constructor: ICOR_DEBUG_FUNCTION is
			-- 
		local
			l_string_class : CLASS_C
			l_mod_name: STRING
			l_icd_module: ICOR_DEBUG_MODULE
			l_feat_ctor : FEATURE_I
			l_feat_ctor_tok: INTEGER

		do
			l_string_class := Eiffel_system.String_class.compiled_class
			
			l_feat_ctor := l_string_class.feature_named (Internal_make_from_cil_name)
			l_feat_ctor_tok := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_ctor)
			
			l_mod_name := il_debug_info_recorder.module_file_name_for_class (l_string_class.types.first)
			l_icd_module := icor_debug_module (l_mod_name)
			Result := l_icd_module.get_function_from_token (l_feat_ctor_tok)
		ensure
			Result /= Void
		end		
	
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
					Result := Edv_external_formatter.string_from_string_builder (l_icd_value)
				end
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

			l_value_info : EIFNET_DEBUG_VALUE_INFO
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
						l_icd := function_evaluation (a_frame, l_func, <<l_icd>>)
						if l_icd /= Void then
							create l_value_info.make (l_icd)
							Result := string_value_from_string_class_object_value (l_value_info.interface_debug_object_value)							
						else
							Result := Void -- "WARNING: Could not evaluate output"	
						end
					else
						debug ("DEBUGGER_TRACE_EVAL")
							print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve ICorDebugFunction %N")
							print ("                                :: class name    = [" + l_class_type.full_il_type_name + "]%N")
							print ("                                :: module_name   = %"" + l_module_name + "%"%N")
							print ("                                :: feature_token = 0x" + l_feature_token.to_hex_string + " %N")
						end
					end
	
				else
					debug ("DEBUGGER_TRACE_EVAL")
						print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve FEATURE_I [" 
							+ l_class_type.associated_class.name_in_upper
							+"] %N")
					end
				end
				debug ("DEBUGGER_TRACE_EVAL")
					if Result = Void then
						print ("EIFNET_DEBUGGER.debug_output_.. :: Error: non debuggable ! %N")
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
			skip_exception_message_evaluation: BOOLEAN
		do	
--			skip_exception_message_evaluation := True
			if skip_exception_message_evaluation then
				Result := Void --"debug_output evaluation is OFF"
			else	
				l_icd := a_icd
				l_icd_object := a_icd_obj
				l_icd_class := l_icd_object.get_class
				l_icd_module := l_icd_class.get_module
				l_module_name := l_icd_module.get_name

--				l_icd_module := icor_debug_module_for_mscorlib
				
				l_feature_token := Edv_external_formatter.token_Exception_ToString
				l_func := l_icd_module.get_function_from_token (l_feature_token)
	
				if l_func /= Void then
					l_icd := function_evaluation (a_frame, l_func, <<l_icd>>)
					if l_icd /= Void then
							--| We should get a System.String
						create l_debug_info.make (l_icd)
						Result := Edv_external_formatter.system_string_value_to_string (l_debug_info.interface_debug_object_value)							
					else
						Result := Void -- "WARNING: Could not evaluate output"	
					end
				end
			end
		end

 	get_message_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING is
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
		do	
			l_icd := a_icd
			l_icd_object := a_icd_obj
			l_icd_class := l_icd_object.get_class
			l_icd_module := l_icd_class.get_module
			l_module_name := l_icd_module.get_name

			l_icd_module := icor_debug_module_for_mscorlib

			l_feature_token := Edv_external_formatter.token_Exception_get_Message
			l_func := l_icd_module.get_function_from_token (l_feature_token)

			if l_func /= Void then
				l_icd := function_evaluation (a_frame, l_func, <<l_icd>>)
				if l_icd /= Void then
						--| We should get a System.String
					create l_debug_info.make (l_icd)
					Result := Edv_external_formatter.system_string_value_to_string (l_debug_info.interface_debug_object_value)							
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
			end
		end

	once_function_value_on_icd_class (a_icd_frame: ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS; a_adapted_class_type: CLASS_TYPE; a_feat: E_FEATURE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue object representing the once value.
		require
			a_icd_class_not_void: a_icd_class /= Void
			a_feat_not_void: a_feat /= Void
			adapted_class_not_void: a_adapted_class_type /= Void
		local
			l_once_info_tokens: TUPLE [INTEGER, INTEGER]
			l_done_token, l_result_token: INTEGER
			l_icd_debug_value: ICOR_DEBUG_VALUE
			l_once_already_called: BOOLEAN
			l_icd_frame: ICOR_DEBUG_FRAME
		do
				--| Set related frame
			l_icd_frame := a_icd_frame
			if l_icd_frame = Void then
					--| just in case icd_frame is not set
				l_icd_frame := active_frame
			end

				--| Get related tokens
			l_once_info_tokens := Il_debug_info_recorder.once_feature_tokens_for_feat_and_class_type (a_feat.associated_feature_i, a_adapted_class_type)
			l_done_token := l_once_info_tokens.integer_item (1)
			l_result_token := l_once_info_tokens.integer_item (2)	
			

				--| Check if already called (_done)
			if l_done_token /= 0 then
				l_icd_debug_value := a_icd_class.get_static_field_value (l_done_token, l_icd_frame)
				if l_icd_debug_value /= Void then
					l_icd_debug_value := Edv_formatter.prepared_debug_value (l_icd_debug_value)
					l_once_already_called := Edv_formatter.prepared_icor_debug_value_as_boolean (l_icd_debug_value)
				end
			end

				--| if already called then get the value (_result)
			if l_once_already_called then
				if l_result_token /= 0 then
					Result := a_icd_class.get_static_field_value (l_result_token, l_icd_frame)
				end
			end
		end

feature -- Bridge to evaluator

	evaluator: EIFNET_DEBUGGER_EVALUATOR

	function_evaluation (a_frame: ICOR_DEBUG_FRAME; a_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
		do
			Result := evaluator.function_evaluation (a_frame, a_func, a_args)
		end

feature {NONE} -- External

	Infinite_time: INTEGER is 0xFFFFFFFF
			-- Value for C externals to have an infinite wait

end -- class EIFNET_DEBUGGER
